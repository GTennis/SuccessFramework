//
//  BaseAPIClient.h
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

#import "AFHTTPSessionManager.h"
#import "ConstNetworkErrorCodes.h"

@interface BaseAPIClient : AFHTTPSessionManager

#pragma mark - Public -

- (id)initWithBaseURL:(NSURL *)url userManager:(id<UserManagerProtocol>)userManager settingsManager:(id<SettingsManagerProtocol>)settingsManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager;

#pragma mark - Protected -

// Dependencies
@property (nonatomic, strong) id<UserManagerProtocol> userManager;
@property (nonatomic, strong) id<AnalyticsManagerProtocol> analyticsManager;
@property (nonatomic, strong) id<SettingsManagerProtocol> settingsManager;

#pragma mark Common header handling

- (void)setAuthorizationHeader;
- (void)setAcceptLanguageHeader;

#pragma mark Priority handling

// Should be overwritten in subclass. If set to YES, cancels all other API client's requests, before performing the called one
- (BOOL)shouldCancelAllOtherRequests;

// Could be overwritten in subclass. It set to YES, cancels its own requests when receives global cancel notification
- (BOOL)shouldCancelSelfRequests;

#pragma mark Retry handling

- (void)handleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector;
- (void)handleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector param1:(id)param1;
- (void)handleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector param1:(id)param1 param2:(id)param2;

@end
