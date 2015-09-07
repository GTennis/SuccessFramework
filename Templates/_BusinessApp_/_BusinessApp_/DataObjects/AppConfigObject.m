//
//  AppConfigObject.m
//  _BusinessApp_
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
#import "NSString+Validator.h"

@implementation AppConfigObject

@synthesize isAppNeedUpdate = _isAppNeedUpdate;
@synthesize appStoreUrlString = _appStoreUrlString;
@synthesize appConfigVersion = _appConfigVersion;
@synthesize logLevel = _logLevel;
@synthesize currentNetworkRequests = _currentNetworkRequests;
@synthesize productionNetworkRequests = _productionNetworkRequests;
@synthesize stageNetworkRequests = _stageNetworkRequests;
@synthesize developmentNetworkRequests = _developmentNetworkRequests;

#pragma mark - ParsableObject -

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        //----- Check app config version -----//
        
        NSNumber *appConfigVersionNumber = dict[kAppConfigVersionKey];
        
        if (!appConfigVersionNumber) {
            
            return nil;
            
        } else {
            
            _appConfigVersion = [appConfigVersionNumber integerValue];
        }
        
        // Parse log level. Will be set to no logging in case it's missing
        NSString *logLevelString = dict[kAppConfigLoggingGroupKey][kAppConfigLogLevelKey];
        DDLogDebug(@"LogLevel is about to be set to %@", logLevelString);
        
        _logLevel = [self convertedLogLevel:logLevelString];
        
        //----- Check app config version -----//
        
        NSNumber *appNeedsUpdate = dict[kAppConfigForceAppUpdateGroupKey][kAppConfigForceAppUpdateFlagKey];
        
        // Treat it as forceToUpdate when response doesn't contain kSettingIsAppNeedUpdateKey property
        if (!appNeedsUpdate) {
            
            _isAppNeedUpdate = YES;
            
        } else {
            
            _isAppNeedUpdate = [appNeedsUpdate boolValue];
        }
        
        //----- Check app store url is valid -----//
        
        _appStoreUrlString = dict[kAppConfigForceAppUpdateGroupKey][kAppConfigForceAppUpdateUrlKey];
        
        if (!_appStoreUrlString || ![_appStoreUrlString isValidUrlString]) {
            
            return nil;
        }
        
        //----- Parse and check production backend urls -----//
        
        NSDictionary *productionNetworkRequestsDict = dict[kAppConfigBackendAPIsKey][kAppConfigBackendProductionGroupKey];
        
        if (!productionNetworkRequestsDict) {
            
            return nil;
            
        } else {
        
            _productionNetworkRequests = [self networkRequestsWithDictionary:productionNetworkRequestsDict];
            
            if (!_productionNetworkRequests) {
                
                return nil;
            }
        }
        
        //----- Parse stage backend urls -----//
        // No need to check because it's not important on production environment if they would become empty
        
        NSDictionary *stageNetworkRequestsDict = dict[kAppConfigBackendAPIsKey][kAppConfigBackendStageGroupKey];
        _stageNetworkRequests = [self networkRequestsWithDictionary:stageNetworkRequestsDict];
            
       
        //----- Parse and check stage backend urls -----//
        // No need to check because it's not important on production environment if they would become empty
        
        NSDictionary *developmentNetworkRequestsDict = dict[kAppConfigBackendAPIsKey][kAppConfigBackendDevelopmentGroupKey];
        _developmentNetworkRequests = [self networkRequestsWithDictionary:developmentNetworkRequestsDict];
    }
    
    return self;
}

#pragma mark - Public -

- (void)setCurrentRequestsWithBackendEnvironment:(BackendEnvironment)backendEnvironment {
    
    switch (backendEnvironment) {
            
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

- (NSDictionary <NetworkRequestObject>*)networkRequestsWithDictionary:(NSDictionary *)networkRequestsDict {
    
    NSArray *networkRequestNames = [networkRequestsDict allKeys];
    
    NSMutableDictionary <NetworkRequestObject> *result = (NSMutableDictionary <NetworkRequestObject> *) [[NSMutableDictionary alloc] initWithCapacity:networkRequestNames.count];
    NSDictionary *dict = nil;
    NetworkRequestObject *networkRequest = nil;
    
    for (NSString *networkRequestName in networkRequestNames) {
        
        // Extract object
        dict = networkRequestsDict[networkRequestName];
        networkRequest = [[NetworkRequestObject alloc] initWithDict:dict];
        
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

@end
