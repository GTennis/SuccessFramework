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

@implementation AppConfigObject

@synthesize isAppNeedUpdate = _isAppNeedUpdate;
@synthesize appStoreUrlString = _appStoreUrlString;
@synthesize appConfigVersion = _appConfigVersion;
@synthesize currentNetworkRequests = _currentNetworkRequests;
@synthesize productionNetworkRequests = _productionNetworkRequests;
@synthesize stageNetworkRequests = _stageNetworkRequests;
@synthesize developmentNetworkRequests = _developmentNetworkRequests;

#pragma mark - ParsableObject -

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
#warning implement strong response checking. It's critical and all of the links should be valid
        
        NSNumber *appConfigVersionNumber = dict[kAppConfigVersionKey];
        _appConfigVersion = [appConfigVersionNumber integerValue];
        
        NSNumber *appNeedsUpdate = dict[kAppConfigForceAppUpdateGroupKey][kAppConfigForceAppUpdateFlagKey];
        _appStoreUrlString = dict[kAppConfigForceAppUpdateGroupKey][kAppConfigForceAppUpdateUrlKey];
        
        // Treat it as forceToUpdate when response doesn't contain kSettingIsAppNeedUpdateKey property
        if (!appNeedsUpdate) {
            
            _isAppNeedUpdate = YES;
            
        } else {
            
            _isAppNeedUpdate = [appNeedsUpdate boolValue];
        }
        
        // Parse production backend urls
        NSDictionary *productionNetworkRequestsDict = dict[kAppConfigBackendAPIsKey][kAppConfigBackendProductionGroupKey];
        _productionNetworkRequests = [self networkRequestsWithDictionary:productionNetworkRequestsDict];
        
        // Parse stage backend urls
        NSDictionary *stageNetworkRequestsDict = dict[kAppConfigBackendAPIsKey][kAppConfigBackendStageGroupKey];
        _stageNetworkRequests = [self networkRequestsWithDictionary:stageNetworkRequestsDict];
        
        // Parse development backend urls
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

@end
