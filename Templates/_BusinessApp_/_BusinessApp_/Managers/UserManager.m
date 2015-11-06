//
//  UserManager.m
//  MyInsurrance
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

#import "UserManager.h"
#import "UserObject.h"
#import "SettingsManager.h"
#import "GMObserverList.h"
#import "UserManagerObserver.h"
#import "KeychainManager.h"

// User persistence keys
#define kUserLoggedInPersistenceKey @"LoggedInUser"
#define kUserKeychainTokenKey @"KeychainUserToken"

@interface UserManager () {
    
    GMObserverList *_observers;
}

@end

@implementation UserManager

@synthesize user = _user;
@synthesize networkOperationFactory = _networkOperationFactory;
@synthesize settingsManager = _settingsManager;
@synthesize analyticsManager = _analyticsManager;
@synthesize keychainManager = _keychainManager;

#pragma mark - Public -

#pragma mark UserManagerProtocol

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _user = [[UserObject alloc] init];
        _observers = [[GMObserverList alloc] initWithObservedSubject:self];
    }
    return self;
}

#pragma mark User handling

- (instancetype)initWithSettingsManager:(id <SettingsManagerProtocol>)settingsManager networkOperationFactory:(id <NetworkOperationFactoryProtocol>)networkOperationFactory analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager keychainManager:(id<KeychainManagerProtocol>)keychainManager {
    
    self = [self init];
    if (self) {
        
        _settingsManager = settingsManager;
        _networkOperationFactory = networkOperationFactory;
        _analyticsManager = analyticsManager;
        _keychainManager = keychainManager;
        
        [self loadUser];
    }
    
    return self;
}

- (BOOL)isUserLoggedIn {
    
    return _user.token.length > 0;
}

- (NSError *)saveUser:(UserObject *)user {
    
    // Store token
    NSError *error = [_keychainManager setAuthentificationToken:user.token];
    
    if (!error) {
        
        // Serialize and store user in settings
        NSDictionary *dict = [user toDict];
        [_settingsManager setLoggedInUser:dict];
        
        // Update in-memory user
        _user = user;
    }
    
    return error;
}

- (void)loadUser {
    
    NSDictionary *dict = [_settingsManager loggedInUser];
    
    if (!dict) {
        
        _user = nil;
        return;
    }
    
    _user = [[UserObject alloc] initWithDict:dict];
    
    NSString *token = [_keychainManager authentificationToken];
    
    if (token) {
        
        _user.token = token;
        
    } else {
        
        // Clear user if token was not loaded
        _user = nil;
    }
}

- (void)logout {
    
    NSError *error = [_keychainManager setAuthentificationToken:nil];
    
    if (!error) {
        
        [_settingsManager setLoggedInUser:nil];
        
        _user = nil;
        
        // There should be a webservice which does login and invalides token (if somebody sniffed and stole it). However there's no such webservice and we do logout locally only and so always consider logout as success immediatelly
        [self notifyObserversWithLogoutSuccess:nil];
        
    } else {
        
        [self notifyObserversWithLogoutFail:@"Unable to clear keychain"];
    }
}

- (void)loginUserWithData:(UserObject *)data callback:(Callback)callback {
    
    /*__weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            NSError *err = [weakSelf saveUser:result];
            if (!err) {
                
                [self notifyObserversWithLoginSuccess:weakSelf.user];
                
            } else {
                
                [self notifyObserversWithLoginFail:err.localizedDescription];
            }
            
        } else {
            
            [self notifyObserversWithLoginFail:[error localizedDescription]];
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userLoginOperation = [_networkOperationFactory userLoginNetworkOperationWithParams:[data toDict]];
    [userLoginOperation performWithCallback:wrappedCallback];*/
    
#warning demo code
    UserObject *user = [[UserObject alloc] init];
    user.email = @"gytenis@test.com";
    user.token = @"123";
    [self saveUser:user];
    [self notifyObserversWithLoginSuccess:user];
    callback(YES, user, nil);
}

- (void)signUpUserWithData:(UserObject *)data callback:(Callback)callback {
    
    /*__weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            NSError *err = [weakSelf saveUser:result];
            if (!err) {
                
                [self notifyObserversWithSignUpSuccess:weakSelf.user];
                
            } else {
                
                [self notifyObserversWithSignUpFail:err.localizedDescription];
            }
            
        } else {
            
            [self notifyObserversWithSignUpFail:[error localizedDescription]];
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userSignUpOperation = [_networkOperationFactory userSignUpNetworkOperationWithParams:[data toDict]];
    [userSignUpOperation performWithCallback:wrappedCallback];*/
    
#warning demo code
    data.token = @"123";
    [self saveUser:data];
    [self notifyObserversWithSignUpSuccess:data];
    callback(YES, data, nil);
}

- (void)resetPassword:(UserObject *)data callback:(Callback)callback {
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            [self notifyObserversWithPasswordResetSuccess:nil];
            
        } else {
            
            [self notifyObserversWithPasswordResetFail:nil];
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userResetPasswordOperation = [_networkOperationFactory userResetPasswordNetworkOperationWithParams:[data toDict]];
    [userResetPasswordOperation performWithCallback:wrappedCallback];
}

- (void)getUserProfileWithCallback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
        }
        
        callback(success, result, error);
    };
    
    id<NetworkOperationProtocol> userProfileOperation = [_networkOperationFactory userProfileNetworkOperationWithParams:nil];
    [userProfileOperation performWithCallback:wrappedCallback];
}

#pragma mark User state observer handling

- (void)addServiceObserver:(id<UserManagerObserver>)observer {
    
    [_observers addObserver:observer];
}

- (void)removeServiceObserver:(id<UserManagerObserver>)observer {
    
    [_observers removeObserver:observer];
}

#pragma mark - Private -

#pragma mark UserManagerObserver handling

- (void)notifyObserversWithLoginSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didLoginUser:) withObject:userObject];
}

- (void)notifyObserversWithLoginFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToLoginUser:) withObject:errorMessage];
}

- (void)notifyObserversWithSignUpSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didSignUpUser:) withObject:userObject];
}

- (void)notifyObserversWithSignUpFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToSignUpUser:) withObject:errorMessage];
}

- (void)notifyObserversWithUpdateSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didUpdateUser:) withObject:userObject];
}

- (void)notifyObserversWithUpdateFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToUpdateUser:) withObject:errorMessage];
}

- (void)notifyObserversWithLogoutSuccess:(UserObject *)userObject {
    
    [_observers notifyObserversForSelector:@selector(didLogoutUser:) withObject:nil];
}

- (void)notifyObserversWithLogoutFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToLogoutUser:) withObject:errorMessage];
}

- (void)notifyObserversWithPasswordResetSuccess:(NSString *)email {
    
    [_observers notifyObserversForSelector:@selector(didResetPassword:) withObject:email];
}

- (void)notifyObserversWithPasswordResetFail:(NSString *)errorMessage {
    
    [_observers notifyObserversForSelector:@selector(didFailedToResetPassword:) withObject:errorMessage];
}

@end
