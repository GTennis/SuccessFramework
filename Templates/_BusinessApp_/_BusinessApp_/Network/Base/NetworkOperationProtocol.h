//
//  NetworkOperationProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 25/08/15.
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

#import "NetworkRequestObject.h"

@protocol UserManagerProtocol;

@protocol NetworkOperationProtocol <NSObject>

#pragma mark - Public -

@property (readonly, nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NetworkRequestObject *networkRequestObject;
@property (nonatomic, strong) id params;

- (instancetype)initWithNetworkRequestObject:(NetworkRequestObject *)networkRequestObject params:(id)params userManager:(id<UserManagerProtocol>)userManager;

// Params accepts any type of object. This means data objects could be passed for convenience. However, inside subclass we need to transform passed "params" data object and return NSDictionary. See protected "- (NSDictionary *)params;" method
- (void)performWithCallback:(Callback)callback;

#pragma mark - Protected -

- (NSString *)requestBaseUrl;
- (NSString *)requestRelativeUrl;
- (NSString *)requestMethod;
- (NSDictionary *)requestHeaders;
- (NSDictionary *)requestBodyParams;
- (NSString *)requestUrlParams;
- (void)handleReceivedDataWithSuccess:(BOOL)success result:(id)result error:(NSError *)error callback:(Callback)callback;

@property (nonatomic, weak) id <UserManagerProtocol> userManager;

@end
