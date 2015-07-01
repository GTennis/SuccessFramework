//
//  BackendAPIClientProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
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

@class UserObject;

@protocol BackendAPIClientProtocol <NSObject>

- (void)getAppSettingsWithParam1:(id)param1 callback:(Callback)callback;
- (void)getTopImagesWithTag:(id)tag callback:(Callback)callback;

// User related
- (void)loginUserWithData:(UserObject *)user callback:(Callback)callback;
- (void)signUpUserWithData:(UserObject *)user callback:(Callback)callback;
- (void)resetPasswordWithData:(UserObject *)user callback:(Callback)callback;
- (void)getUserWithData:(UserObject *)user callback:(Callback)callback;

// Push Notifications related
- (void)registerPushNotificationToken:(NSData *)token;
- (void)handleReceivedPushNotificationWithUserInfo:(NSDictionary *)userInfo;

@end
