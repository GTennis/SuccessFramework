//
//  UserManagerObserver.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/19/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@class UserObject;

@protocol UserManagerObserver <NSObject>

@optional

// User login
- (void)didLoginUser:(UserObject *)userObject;
- (void)didFailedToLoginUser:(NSString *)errorMessage;

// User creation
- (void)didSignUpUser:(UserObject *)userObject;
- (void)didFailedToSignUpUser:(NSString *)errorMessage;

// User update
- (void)didUpdateUser:(UserObject *)userObject;
- (void)didFailedToUpdateUser:(NSString *)errorMessage;

// User logout
- (void)didLogoutUser:(UserObject *)userObject;
- (void)didFailedToLogoutUser:(NSString *)errorMessage;

// Password reset
- (void)didResetPassword:(NSString *)email;
- (void)didFailedToResetPassword:(NSString *)errorMessage;

@end
