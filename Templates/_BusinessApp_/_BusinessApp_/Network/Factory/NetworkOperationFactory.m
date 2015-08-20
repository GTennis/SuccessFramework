//
//  NetworkOperationFactory.m
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

#import "NetworkOperationFactory.h"
#import "ConfigNetworkOperation.h"
#import "ImageListNetworkOperation.h"
#import "UserLoginNetworkOperation.h"
#import "UserSignUpNetworkOperation.h"
#import "UserProfileNetworkOperation.h"
#import "UserResetPasswordNetworkOperation.h"

#define kNetworkOperationImageListName @"imageList"
#define kNetworkOperationUserLoginName @"userLogin"
#define kNetworkOperationUserSignUpName @"userSignUp"
#define kNetworkOperationUserProfileName @"userProfile"
#define kNetworkOperationUserResetPasswordName @"userResetPassword"

@implementation NetworkOperationFactory

@synthesize appConfig = _appConfig;

#pragma mark - NetworkOperationFactoryProtocol -

- (instancetype)initWithAppConfig:(AppConfigObject *)appConfig {
    
    self = [super init];
    if (self) {
        
        _appConfig = appConfig;
    }
    return self;
}

#pragma mark Content

- (id<NetworkOperationProtocol>)imageListNetworkOperation {
    
    NetworkRequestObject *request = _appConfig.currentNetworkRequests[kNetworkOperationImageListName];
    ImageListNetworkOperation *operation = [[ImageListNetworkOperation alloc] initWithNetworkRequestObject:request];
    
    return operation;
}

#pragma mark User

- (id<NetworkOperationProtocol>)userLoginNetworkOperation {
    
    NetworkRequestObject *request = _appConfig.currentNetworkRequests[kNetworkOperationUserLoginName];
    UserLoginNetworkOperation *operation = [[UserLoginNetworkOperation alloc] initWithNetworkRequestObject:request];
    
    return operation;
}

- (id<NetworkOperationProtocol>)userSignUpNetworkOperation {
    
    NetworkRequestObject *request = _appConfig.currentNetworkRequests[kNetworkOperationUserSignUpName];
    UserSignUpNetworkOperation *operation = [[UserSignUpNetworkOperation alloc] initWithNetworkRequestObject:request];
    
    return operation;
}

- (id<NetworkOperationProtocol>)userProfileNetworkOperation {
    
    NetworkRequestObject *request = _appConfig.currentNetworkRequests[kNetworkOperationUserProfileName];
    UserProfileNetworkOperation *operation = [[UserProfileNetworkOperation alloc] initWithNetworkRequestObject:request];
    
    return operation;
}

- (id<NetworkOperationProtocol>)userResetPasswordNetworkOperation {
    
    NetworkRequestObject *request = _appConfig.currentNetworkRequests[kNetworkOperationUserResetPasswordName];
    UserResetPasswordNetworkOperation *operation = [[UserResetPasswordNetworkOperation alloc] initWithNetworkRequestObject:request];
    
    return operation;
}

@end
