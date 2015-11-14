//
//  AppConfigObject.m
//  MyInsurrance
//
//  Created by Gytenis Mikulenas on 26/08/15.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import "AppConfigObject.h"
#import "ConstNetworkConfig.h"

@interface AppConfigObject () {
    
    NSString *_platform;
    NSMutableDictionary *_environmentLogLevels;
    BackendEnvironment _currentNetworkEnvironment;
}

@end

@implementation AppConfigObject

@synthesize appConfigVersion = _appConfigVersion;
@synthesize supportedAppVersions = _supportedAppVersions;
@synthesize appStoreUrlString = _appStoreUrlString;
@synthesize currentNetworkRequests = _currentNetworkRequests;
@synthesize productionNetworkRequests = _productionNetworkRequests;
@synthesize stageNetworkRequests = _stageNetworkRequests;
@synthesize developmentNetworkRequests = _developmentNetworkRequests;

#pragma mark - Public -

#pragma mark ParsableObject

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        _platform = dict[kAppConfigPlatformKey];
        NSDictionary *environmentsDict = dict[kAppConfigBackendAPIsKey][kAppConfigBackendEnvironmentsKey];
        NSDictionary *productionEnvironmentsDict = environmentsDict[kAppConfigBackendProductionGroupKey];
        NSDictionary *stageEnvironmentsDict = environmentsDict[kAppConfigBackendStageGroupKey];
        NSDictionary *developmentEnvironmentsDict = environmentsDict[kAppConfigBackendDevelopmentGroupKey];
        
        //----- Check app config version -----//
        
        NSNumber *appConfigVersionNumber = dict[kAppConfigVersionKey];
        
        if (!appConfigVersionNumber) {
            
            return nil;
            
        } else {
            
            _appConfigVersion = [appConfigVersionNumber integerValue];
        }
        
        //----- Extract log levels -----//
        
        _environmentLogLevels = [[NSMutableDictionary alloc] init];
        
        // Add production log level
        _environmentLogLevels[@(kBackendEnvironmentProduction)] = productionEnvironmentsDict[kAppConfigLoggingGroupKey][kAppConfigLogLevelKey];
        // Add stage log level
        _environmentLogLevels[@(kBackendEnvironmentStage)] = stageEnvironmentsDict[kAppConfigLoggingGroupKey][kAppConfigLogLevelKey];
        // Add development log level
        _environmentLogLevels[@(kBackendEnvironmentDevelopment)] = developmentEnvironmentsDict[kAppConfigLoggingGroupKey][kAppConfigLogLevelKey];
        
        //----- Check for supported version -----//
        
        _supportedAppVersions = dict[kAppConfigSupportedAppVersionsKey][kAppConfigSupportedAppVersionListKey];
        _appStoreUrlString = dict[kAppConfigSupportedAppVersionsKey][kAppConfigSupportedAppStoreUrlKey];
        
        //----- Parse and check production backend urls -----//
        
        NSString *productionBaseUrl = productionEnvironmentsDict[kAppConfigBackendEnvironmentBaseUrlKey];
        NSDictionary *productionNetworkRequestsDict = productionEnvironmentsDict[kAppConfigBackendEnvironmentActionsKey];
        
        if (!productionNetworkRequestsDict) {
            
            return nil;
            
        } else {
            
            _productionNetworkRequests = [self networkRequestsWithDictionary:productionNetworkRequestsDict environmentBaseUrl:productionBaseUrl];
            
            if (!_productionNetworkRequests) {
                
                return nil;
            }
        }
        
        //----- Parse stage backend urls -----//
        // No need to check because it's not important on production environment if they would become empty
        
        NSString *stageBaseUrl = stageEnvironmentsDict[kAppConfigBackendEnvironmentBaseUrlKey];
        NSDictionary *stageNetworkRequestsDict = stageEnvironmentsDict[kAppConfigBackendEnvironmentActionsKey];
        _stageNetworkRequests = [self networkRequestsWithDictionary:stageNetworkRequestsDict environmentBaseUrl:stageBaseUrl];
        
        //----- Parse and check stage backend urls -----//
        // No need to check because it's not important on production environment if they would become empty
        
        NSString *developmentBaseUrl = developmentEnvironmentsDict[kAppConfigBackendEnvironmentBaseUrlKey];
        NSDictionary *developmentNetworkRequestsDict = developmentEnvironmentsDict[kAppConfigBackendEnvironmentActionsKey];
        _developmentNetworkRequests = [self networkRequestsWithDictionary:developmentNetworkRequestsDict environmentBaseUrl:developmentBaseUrl];
    }
    
    return self;
}

- (BOOL)isAppNeedUpdate {
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    BOOL isAppVersionSupported = [self containsAppVersion:version];
    
    return !isAppVersionSupported;
}

- (BOOL)isConfigForIosPlatform {
    
    return ([_platform isEqualToString:kAppConfigPlatformIOS]) ? YES : NO;
}

- (LogLevelType)logLevel {
    
    NSString *logLevelString = _environmentLogLevels[@(_currentNetworkEnvironment)];
    
    return [self convertedLogLevel:logLevelString];
}

- (void)setCurrentRequestsWithBackendEnvironment:(BackendEnvironment)backendEnvironment {
    
    _currentNetworkEnvironment = backendEnvironment;
    
    switch (_currentNetworkEnvironment) {
            
        case kBackendEnvironmentProduction:
            
            _currentNetworkRequests = _productionNetworkRequests;
            break;
            
        case kBackendEnvironmentStage:
            
            _currentNetworkRequests = _stageNetworkRequests;
            break;
            
        case kBackendEnvironmentDevelopment:
            
            _currentNetworkRequests = _developmentNetworkRequests;
            break;
            
        default:
            
            _currentNetworkRequests = _productionNetworkRequests;
            break;
    }
}

#pragma mark - Private -

- (NSDictionary <NetworkRequestObject>*)networkRequestsWithDictionary:(NSDictionary *)networkRequestsDict environmentBaseUrl:(NSString *)baseUrl {
    
    NSArray *networkRequestNames = [networkRequestsDict allKeys];
    
    NSMutableDictionary <NetworkRequestObject> *result = (NSMutableDictionary <NetworkRequestObject> *) [[NSMutableDictionary alloc] initWithCapacity:networkRequestNames.count];
    NSDictionary *dict = nil;
    NetworkRequestObject *networkRequest = nil;
    
    for (NSString *networkRequestName in networkRequestNames) {
        
        // Extract object
        dict = networkRequestsDict[networkRequestName];
        networkRequest = [[NetworkRequestObject alloc] initWithDict:dict];
        
        if (!networkRequest.baseUrl.length) {
            
            networkRequest.baseUrl = baseUrl;
        }
        
        // Add object
        result[networkRequestName] = networkRequest;
    }
    
    // Return
    return result;
}

- (LogLevelType)convertedLogLevel:(NSString *)logLevelString {
    
    // Basic type check
    if (![logLevelString isKindOfClass:[NSString class]]) {
        
        return kLogLevelWarning;
    }
    
    // Proceed
    
    LogLevelType logLevel;
    
    if ([logLevelString isEqualToString:@"none"]) {
        
        logLevel = kLogLevelNone;
        
    } else if ([logLevelString isEqualToString:@"error"]) {
        
        logLevel = kLogLevelError;
        
    } else if ([logLevelString isEqualToString:@"warning"]) {
        
        logLevel = kLogLevelWarning;
        
    } else if ([logLevelString isEqualToString:@"info"]) {
        
        logLevel = kLogLevelInfo;
        
    } else if ([logLevelString isEqualToString:@"debug"]) {
        
        logLevel = kLogLevelDebug;
        
    } else if ([logLevelString isEqualToString:@"verbose"]) {
        
        logLevel = kLogLevelVerbose;
        
    } else if ([logLevelString isEqualToString:@"all"] ) {
        
        logLevel = kLogLevelAll;
        
    } else {
        
        logLevel = kLogLevelWarning;
    }
    
    return logLevel;
}

- (BOOL)containsAppVersion:(NSString *)appVersion {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", appVersion];
    
    NSArray *filteredList = [_supportedAppVersions filteredArrayUsingPredicate:predicate];
    
    return filteredList.count ? YES : NO;
}

@end
