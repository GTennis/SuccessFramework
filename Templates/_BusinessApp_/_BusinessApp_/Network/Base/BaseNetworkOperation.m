//
//  BaseNetworkOperation.m
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

#import "BaseNetworkOperation.h"
#import "NSString+Validator.h"

@implementation BaseNetworkOperation

#pragma mark - Public -

- (instancetype)init {
    
    self = [self initWithUrlString:[self urlString]];
    if (self) {
        
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString {
    
    if (![urlString isValidUrlString]) {
        
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url) {
        
        return nil;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:[self method]];
    
    self = [super initWithRequest:request];
    if (self) {
        
        // Nothing more is needed
    }
    return self;
}

- (void)getDataWithCallback:(Callback)callback {
    
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

- (NSString *)baseUrl {
    
    // Implement in child classes
    NSAssert(NO, @"baseUrl is not implemented in class: %@", NSStringFromClass([self class]));
    
    return nil;
}

- (void)handleReceivedDataWithSuccess:(BOOL)success result:(id)result error:(NSError *)error callback:(Callback)callback {
    
    NSAssert(NO, @"handleReceivedDataWithSuccess:result:error:callback is not implemented in class: %@", NSStringFromClass([self class]));
}

- (NSString *)method {
    
    NSAssert(NO, @"method is not implemented in class: %@", NSStringFromClass([self class]));
    
    return nil;
}

- (NSString *)urlString {
    
    NSAssert(NO, @"urlString is not implemented in class: %@", NSStringFromClass([self class]));
    
    return nil;
}

#pragma mark - Private -

- (void(^)(AFHTTPRequestOperation *operation, id responseObject))successWrappedCallbackWithPassedCallback:(Callback)callback {
    
    __weak __typeof(self)weakSelf = self;
    
    void (^successCallback)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [weakSelf handleReceivedDataWithSuccess:YES result:responseObject error:nil callback:callback];
    };
    
    return successCallback;
}

- (void(^)(AFHTTPRequestOperation *operation, NSError *error))failWrappedCallbackWithPassedCallback:(Callback)callback {
    
    __weak __typeof(self)weakSelf = self;
    
    void (^failCallback)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [weakSelf handleReceivedDataWithSuccess:NO result:nil error:error callback:callback];
    };
    
    return failCallback;
}
     
@end
