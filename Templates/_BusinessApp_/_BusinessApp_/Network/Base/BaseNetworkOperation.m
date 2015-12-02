//
//  BaseNetworkOperation.m
//  MyInsurrance
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

#import "BaseNetworkOperation.h"
#import "NSString+Validator.h"
#import "CustomAFJSONResponseSerializer.h"
#import "UserManager.h"

@implementation BaseNetworkOperation

@synthesize networkRequestObject = _networkRequestObject;
@synthesize context = _context;
@synthesize userManager = _userManager;

#pragma mark - Public -

// Forbit use of init
- (instancetype)init {
    
    NSAssert(NO, @"-init is not a valid initializer for the class %@. Use initWithNetworkRequestObject instead", NSStringFromClass([self class]));
    
    return nil;
}

- (instancetype)initWithNetworkRequestObject:(NetworkRequestObject *)networkRequestObject context:(id)context userManager:(id<UserManagerProtocol>)userManager {
    
    _context = context;
    _userManager = userManager;
    
    // Store request config
    _networkRequestObject = networkRequestObject;
    
    // Create network request url string
    NSString *urlString = [[self requestBaseUrl] stringByAppendingString:[self requestRelativeUrl]];
    
    // Add url params from the subclass if exist
    NSString *urlParamsString = [self requestUrlParams];
    if (urlParamsString.length > 0) {
        
        urlString = [[urlString stringByAppendingString:@"?"] stringByAppendingString:urlParamsString];
    }
    
    // Escape
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Create url request and proceed
    self = [self initWithUrlString:urlString networkRequestObject:networkRequestObject];
    if (self) {
        
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString networkRequestObject:(NetworkRequestObject *)networkRequestObject  {
    
    if (![urlString isValidUrlString]) {
        
        DDLogError(@"[%@]: Invalid url: %@", [self class], urlString);
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url) {
        
        DDLogError(@"[%@]: Unable to create url from: %@", [self class], urlString);
    }
    
    // Create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // Set method
    [request setHTTPMethod:[self requestMethod]];
    
    // Add custom headers
    [self setHTTPHeadersWithRequest:request];
    
    // Add body
    [self setHTTPBodyWithRequest:request];
    
    //#ifdef DEBUG
    // For internal local https environment with self signed certificate
    //self.securityPolicy.allowInvalidCertificates = YES;
    //#endif
    
    self = [super initWithRequest:request];
    if (self) {
        
        // Add custom response serializer
        self.responseSerializer = [CustomAFJSONResponseSerializer serializer];
        
        // Nothing more is needed
    }
    return self;
}

- (void)performWithCallback:(Callback)callback {
    
    void(^successCallback)(AFHTTPRequestOperation *operation, id responseObject) = [self successWrappedCallbackWithPassedCallback:callback];
    void(^failCallback)(AFHTTPRequestOperation *operation, NSError *error) = [self failWrappedCallbackWithPassedCallback:callback];
    
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successCallback(operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failCallback(operation, error);
    }];
    
    [self start];
}

#pragma mark - Protected -

- (NSString *)requestBaseUrl {
    
    return _networkRequestObject.baseUrl;
}

- (NSString *)requestRelativeUrl {
    
    return _networkRequestObject.relativeUrl;
}

- (NSString *)requestMethod {
    
    return _networkRequestObject.method;
}

- (NSDictionary *)requestHeaders {
    
    NSString *token = _userManager.user.token;
    
    if (token.length > 0) {
        
        return @{@"Authorization" : [@"Bearer " stringByAppendingString:token]};
        
    } else {
        
        return nil;
    }
}

- (NSDictionary *)requestBodyParams {
    
    return nil;
}

- (NSString *)requestUrlParams {
    
    return nil;
}

- (void)setHTTPHeadersWithRequest:(NSMutableURLRequest *)urlRequest {
    
    // Add common headers
    [urlRequest setHTTPShouldHandleCookies:NO];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Check for specific headers in subclass
    NSDictionary *customHeaders = [self requestHeaders];
    if (customHeaders) {
        
        for (NSString *header in [customHeaders allKeys]) {
            
            NSString *value = customHeaders[header];
            [urlRequest setValue:value forHTTPHeaderField:header];
        }
    }
}

- (void)setHTTPBodyWithRequest:(NSMutableURLRequest *)urlRequest {
    
    NSDictionary *bodyParams = [self requestBodyParams];
    
    if (bodyParams) {
        
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:bodyParams options:NSJSONWritingPrettyPrinted error:nil]];
    }
}

- (void)handleReceivedDataWithSuccess:(BOOL)success result:(id)result error:(NSError *)error callback:(Callback)callback {
    
    NSAssert(NO, @"handleReceivedDataWithSuccess:result:error:callback is not implemented in class: %@", NSStringFromClass([self class]));
}

#pragma mark - Private -

- (void(^)(AFHTTPRequestOperation *operation, id responseObject))successWrappedCallbackWithPassedCallback:(Callback)callback {
    
    __weak __typeof(self)weakSelf = self;
    
    void (^successCallback)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DDLogDebug(@"[%@]: success", [self class]);
        
        [weakSelf handleReceivedDataWithSuccess:YES result:responseObject error:nil callback:callback];
    };
    
    return successCallback;
}

- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failWrappedCallbackWithPassedCallback:(Callback)callback {
    
    __weak __typeof(self)weakSelf = self;
    
    void (^failCallback)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DDLogWarn(@"[%@]: failed with error: %@", [self class], error);
        
        if (error.code != kNetworkRequestErrorCanceledCode) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkRequestErrorNotification object:nil userInfo:@{kNetworkRequestErrorNotificationUserInfoKey:error}];
        }
        
        [weakSelf handleReceivedDataWithSuccess:NO result:nil error:error callback:callback];
    };
    
    return failCallback;
}

@end
