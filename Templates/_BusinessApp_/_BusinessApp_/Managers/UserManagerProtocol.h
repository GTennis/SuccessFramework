//
//  UserManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/19/14.
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

#import "UserManagerProtocol.h"
#import "SettingsManagerProtocol.h"
#import "NetworkOperationFactoryProtocol.h"
#import "UserManagerObserver.h"
#import "AnalyticsManagerProtocol.h"
#import "KeychainManagerProtocol.h"

@class UserObject;

@protocol UserManagerProtocol <NSObject>

// Dependencies
@property (nonatomic, strong) id<SettingsManagerProtocol> settingsManager;
@property (nonatomic, strong) id<NetworkOperationFactoryProtocol> networkOperationFactory;
@property (nonatomic, strong) id<AnalyticsManagerProtocol> analyticsManager;
@property (nonatomic, strong) id<KeychainManagerProtocol> keychainManager;

// Data object
@property (nonatomic, strong) UserObject *user;

// User handling
- (instancetype)initWithSettingsManager:(id <SettingsManagerProtocol>)settingsManager networkOperationFactory:(id <NetworkOperationFactoryProtocol>)networkOperationFactory analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager keychainManager:(id<KeychainManagerProtocol>)keychainManager;

- (NSError *)saveUser;
- (void)loadUser;
- (BOOL)isUserLoggedIn;
- (void)loginUserWithData:(UserObject *)data callback:(Callback)callback;
- (void)signUpUserWithData:(UserObject *)data callback:(Callback)callback;
- (void)resetPassword:(UserObject *)data callback:(Callback)callback;
- (void)getUserProfileWithCallback:(Callback)callback;
- (void)logout;

// User state observers
- (void)addServiceObserver:(id<UserManagerObserver>)observer;
- (void)removeServiceObserver:(id<UserManagerObserver>)observer;

@end
