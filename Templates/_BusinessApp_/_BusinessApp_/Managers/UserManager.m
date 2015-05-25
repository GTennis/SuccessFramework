//
//  UserManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/19/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
@synthesize backendAPIClient = _backendAPIClient;
@synthesize settingsManager = _settingsManager;
@synthesize analyticsManager = _analyticsManager;

- (instancetype)initWithSettingsManager:(id <SettingsManagerProtocol>)settingsManager backendAPIClient:(id <BackendAPIClientProtocol>)backendAPIClient analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager; {
    
    self = [self init];
    if (self) {
        
        _settingsManager = settingsManager;
        _backendAPIClient = backendAPIClient;
        _analyticsManager = analyticsManager;
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _user = [[UserObject alloc] init];
        _observers = [[GMObserverList alloc] initWithObservedSubject:self];
    }
    return self;
}

- (BOOL)isUserLoggedIn {
    
    return _user.token.length > 0;
}

- (NSError *)saveUser {
    
    /*(UICKeyChainStore *keychain = [KeychainManager keychainSharedStoreForApp];
    NSError *error;
    [keychain setString:_user.masterToken forKey:kUserKeychainTokenKey error:&error];
    
    if (error) {
        *savingError = error;
        _user.masterToken = @"";
        DLog(@"%@", error.localizedDescription);
        return false;
    }
    
    NSDictionary *dict = [_user toDict];
    [_settingsManager setValue:dict forKey:kUserLoggedInPersistenceKey];*/
    
    return nil;
}

- (NSError *)loadUser {
    
    /*NSDictionary *dict = [_settingsManager valueForKey:kUserLoggedInPersistenceKey defaultValueIfNotExists:nil];
    _user = [[UserObject alloc] initWithDict:dict];
    
    UICKeyChainStore *keychain = [KeychainManager keychainSharedStoreForApp];
    NSError *error;
    NSString *token = [keychain stringForKey:kUserKeychainTokenKey error:&error];
    if (token) {
        
        _user.masterToken = token;
        DLog(@"Loaded user token: %@", token);
    }
    
    if (error) {
        
        *loadingError = error;
    }*/
    
    return nil;
}


- (void)logout {
    
    /*UICKeyChainStore *keychain = [KeychainManager keychainSharedStoreForApp];
    NSError *error;
    [keychain removeItemForKey:kUserKeychainTokenKey error:&error];
    if (error) {
        
        DLog(@"%@", error.localizedDescription);
    }
    _user = nil;
    
    [_settingsManager removeValueForKey:kUserLoggedInPersistenceKey];*/
    
    // There should be a webservice which does login and invalides token (if somebody sniffed and stole it). However there's no such webservice and we do logout locally only and so always consider logout as success immediatelly
    [self notifyObserversWithLogoutSuccess:nil];
}

- (void)loginUserWithData:(UserObject *)data callback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
            
            NSError *err = [weakSelf saveUser];
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
    
    [_backendAPIClient loginUserWithData:data callback:wrappedCallback];
}

- (void)signUpUserWithData:(UserObject *)data callback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
            NSError *err = [weakSelf saveUser];
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
    
    [_backendAPIClient signUpUserWithData:data callback:wrappedCallback];
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
    
    [_backendAPIClient resetPasswordWithData:data callback:wrappedCallback];
}

- (void)getUserProfileWithCallback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.user = (UserObject *)result;
        }
        
        callback(success, result, error);
    };
    
    [_backendAPIClient getUserWithData:_user callback:wrappedCallback];
}

#pragma mark - User state observers

- (void)addServiceObserver:(id<UserManagerObserver>)observer {
    
    [_observers addObserver:observer];
}

- (void)removeServiceObserver:(id<UserManagerObserver>)observer {
    
    [_observers removeObserver:observer];
}

#pragma mark - UserManagerObserver

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
