//
//  BaseNetworkOperation.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseNetworkOperation.h"
#import "NSString+Validator.h"
#import "ConstNetworkConfig.h"

@implementation BaseNetworkOperation

- (instancetype)init {
    
    self = [self initWithUrlString:[self urlString]];
    if (self) {
        
    }
    return self;
}

- (NSString *)baseUrl {
    
    return BASE_URL;
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

#pragma mark - wrapper callbacks

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

#pragma mark - Should be overrided in child classes

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
     
@end
