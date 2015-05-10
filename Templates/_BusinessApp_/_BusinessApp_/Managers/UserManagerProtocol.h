//
//  UserManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/19/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "UserManagerProtocol.h"
#import "SettingsManagerProtocol.h"
#import "BackendAPIClientProtocol.h"
#import "UserManagerObserver.h"
#import "AnalyticsManagerProtocol.h"

@class UserObject;

@protocol UserManagerProtocol <NSObject>

// Dependencies
@property (nonatomic, strong) id<SettingsManagerProtocol> settingsManager;
@property (nonatomic, strong) id<BackendAPIClientProtocol> backendAPIClient;
@property (nonatomic, strong) id<AnalyticsManagerProtocol> analyticsManager;

// Data object
@property (nonatomic, strong) UserObject *user;

// Public methods
- (instancetype)initWithSettingsManager:(id <SettingsManagerProtocol>)settingsManager backendAPIClient:(id <BackendAPIClientProtocol>)backendAPIClient analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager;

- (NSError *)saveUser;
- (NSError *)loadUser;
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
