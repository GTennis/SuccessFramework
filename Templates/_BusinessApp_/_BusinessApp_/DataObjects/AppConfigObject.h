//
//  AppConfigObject.h
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

#import "ParsableObject.h"
#import "NetworkRequestObject.h"
#import "ConstNetworkConfig.h"

#define kAppConfigForceAppUpdateGroupKey @"forceAppUpdate"
#define kAppConfigForceAppUpdateFlagKey @"shouldForceUpdate"
#define kAppConfigForceAppUpdateUrlKey @"appStoreUrl"

#define kAppConfigVersionKey @"appConfigVersion"

#define kAppConfigBackendAPIsKey @"backendAPIs"
#define kAppConfigBackendProductionGroupKey @"production"
#define kAppConfigBackendStageGroupKey @"stage"
#define kAppConfigBackendDevelopmentGroupKey @"development"

@protocol AppConfigObject <ParsableObject>

#pragma mark - Public -

@property (nonatomic) BOOL isAppNeedUpdate;
@property (nonatomic, copy) NSString *appStoreUrlString;

@property (nonatomic) NSInteger appConfigVersion; // This property is received from backend during app launch and stored in memory during app run. Then app will requery app configs from the app everytime it will return from background. If current in-memory appConfigVersion is not equal to received appConfigVersion then app will reload itself (in order to update its backend API paths)

@property (nonatomic, strong) NSDictionary<NetworkRequestObject> *productionNetworkRequests;
@property (nonatomic, strong) NSDictionary<NetworkRequestObject> *stageNetworkRequests;
@property (nonatomic, strong) NSDictionary<NetworkRequestObject> *developmentNetworkRequests;

@end

@interface AppConfigObject : NSObject <AppConfigObject>

#pragma mark - Public -

@property (readonly) NSDictionary<NetworkRequestObject> *currentNetworkRequests; // will point to one of the three properties below

- (void)setCurrentRequestsWithBackendEnvironment:(BackendEnvironment)backendEnvironment;

@end
