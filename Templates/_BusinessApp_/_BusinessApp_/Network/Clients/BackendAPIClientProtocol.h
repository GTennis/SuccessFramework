//
//  BackendAPIClientProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@class UserObject;

@protocol BackendAPIClientProtocol <NSObject>

- (void)getAppSettingsWithParam1:(id)param1 callback:(Callback)callback;
- (void)getTopImagesWithTag:(id)tag callback:(Callback)callback;

// User related
- (void)loginUserWithData:(UserObject *)user callback:(Callback)callback;
- (void)signUpUserWithData:(UserObject *)user callback:(Callback)callback;
- (void)resetPasswordWithData:(UserObject *)user callback:(Callback)callback;
- (void)getUserWithData:(UserObject *)user callback:(Callback)callback;

@end
