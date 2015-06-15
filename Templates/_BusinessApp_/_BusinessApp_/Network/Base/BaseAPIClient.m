//
//  BaseAPIClient.m
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

#import "BaseAPIClient.h"
#import "NSObject+Selectors.h"
#import "ConstNetworkConfig.h"
#import "GMAFJSONResponseSerializer.h"
#import "UserManager.h"
#import "UserObject.h"
#import "SettingsManager.h"
#import "AppDelegate.h"
#import "GMAlertView.h"
#import "ErrorObject.h"

#define kNetworkRequestsCancellationNotification @"CancellNetworkRequestsNotification"

#define kBaseAPIClientRetryCount 0

@implementation BaseAPIClient

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithBaseURL:(NSURL *)url analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager {
    
    self = [super initWithBaseURL:url];
    if (self) {
        
        if (self) {
            
            _analyticsManager = analyticsManager;
            
            self.responseSerializer = [GMAFJSONResponseSerializer serializer];
            self.requestSerializer = [AFJSONRequestSerializer serializer];
            [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [self.requestSerializer setHTTPShouldHandleCookies:NO];
            
#ifndef RELEASE_BUILD
            self.securityPolicy.allowInvalidCertificates = YES;
#endif
        }
    }
    
    if ([self shouldCancelSelfRequests]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAllRequests:) name:kNetworkRequestsCancellationNotification object:nil];
    }
    
    
    // Protection against showing alert two times when no internet occurs
    static BOOL isShownAlert;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable && !isShownAlert) {
            
            isShownAlert = YES;
            
            UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            if (viewController) {
                
                GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:viewController title:nil message:AFStringFromNetworkReachabilityStatus(status) cancelButtonTitle:GMLocalizedString(@"Ok") otherButtonTitles:nil];
                [alertView show];
            }
        } else {
            
            isShownAlert = NO;
        }
    }];
    
    return self;
}

- (void)clearCookies {
    
    //Clear cookies
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        
        [cookieStorage deleteCookie:each];
    }
}

// Adds listening for common error codes and handles them all in one place. Notifications are broadcasted to observers upon request success or failure
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self shouldCancelAllOtherRequests]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkRequestsCancellationNotification object:self];
    }
    
    // Every backend request should accept passed app version and return forceToUpdate if needed. In that case we would use code line below. However, we are performing a separate request in AppDelegate, therefore this code won't be used currently.
    // Append version number:
    // NSMutableDictionary *paramsDict = (NSMutableDictionary *)parameters;
    // [self appendVersionForParams:paramsDict];
    
    // Perform request
    return [super GET:URLString parameters:parameters success:[self successWrapperBlockWithSuccessBlock:success andFailureBlock:failure] failure:[self failureWrapperBlockWithFailureBlock:failure]];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self shouldCancelAllOtherRequests]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkRequestsCancellationNotification object:self];
    }
    
    // Every backend request should accept passed app version and return forceToUpdate if needed. In that case we would use code line below. However, we are performing a separate request in AppDelegate, therefore this code won't be used currently.
    // Append version number:
    // NSMutableDictionary *paramsDict = (NSMutableDictionary *)parameters;
    // [self appendVersionForParams:paramsDict];
    
    // Perform request
    return [super POST:URLString parameters:parameters success:[self successWrapperBlockWithSuccessBlock:success andFailureBlock:failure] failure:[self failureWrapperBlockWithFailureBlock:failure]];
}

/*- (void)appendVersionForParams:(NSMutableDictionary *)params {
 
 params[@"version"] = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
 }*/

#pragma mark - Protected

- (BOOL)shouldCancelAllOtherRequests {
    
    return YES;
}
- (BOOL)shouldCancelSelfRequests {
    
    return YES;
}

// For retries with method using callback as param only
- (void)handleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector {
    
    [self coreHandleFailWithError:error failCounter:failCounter callback:callback retrySelector:retrySelector param1:nil param2:nil];
}

// For retries with method using callback and one additional param
- (void)handleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector param1:(id)param1 {
    
    [self coreHandleFailWithError:error failCounter:failCounter callback:callback retrySelector:retrySelector param1:param1 param2:nil];
}

// For retries with method using callback and two additional params
- (void)handleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector param1:(id)param1 param2:(id)param2 {
    
    [self coreHandleFailWithError:error failCounter:failCounter callback:callback retrySelector:retrySelector param1:param1 param2:param2];
}

// Core method for handling retries
- (void)coreHandleFailWithError:(NSError *)error failCounter:(NSInteger *)failCounter callback:(Callback)callback retrySelector:(SEL)retrySelector param1:(id)param1 param2:(id)param2 {
    
    DLog(@"[%@]: Failed %@. Error: %@", NSStringFromClass([self class]), NSStringFromSelector(retrySelector), error.localizedDescription);
    
    // Count number of fails
    (*failCounter)++;
    
    // Retry
    if ((*failCounter) <= kBaseAPIClientRetryCount && error.code != kNetworkRequestBadInputDataError) {
        
        DLog(@"[%@]: Retrying %@ ...%ld", NSStringFromClass([self class]), NSStringFromSelector(retrySelector), (long)(*failCounter));
        
        // These pragma clang directives supresses a warning - "PerformSelector may cause a leak because its selector is unknown". Because by a convention, retrySelector will always call network based method with void return type. Therefore LLVM doesn't need to handle release of return objects because there's nothing to release
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        if (param2) {
            
            [self performSelectorOnMainThread:retrySelector onTarget:self withObject:param1 withObject:param2 withObject:callback waitUntilDone:YES];
            
        } else if (param1) {
            
            [self performSelector:retrySelector withObject:param1 withObject:callback];
            
        } else {
            
            [self performSelector:retrySelector withObject:callback];
        }
        
#pragma clang diagnostic pop
        
    } else {
        
        DLog(@"[%@]: Max number of retries reached (%d) for %@", NSStringFromClass([self class]), kBaseAPIClientRetryCount, NSStringFromSelector(retrySelector));
        
        // Resetting
        (*failCounter) = 0;
        
        callback(NO, nil, error);
    }
}

#pragma mark - Private

- (void)cancelAllRequests:(NSNotification *)networkRequestsCancellationNotification {
    
    if (self.operationQueue.operationCount) {
        
        [self.operationQueue cancelAllOperations];
    }
}

- (void (^)(NSURLSessionDataTask *task, id responseObject))successWrapperBlockWithSuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))success andFailureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    // Wrap passed success block inside wraping block so we could attach notifications
    void (^successWrapperBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *responseDic = nil;
        
        // if response contains valid data or is empty then consider success
        if ([responseObject isKindOfClass:[NSDictionary class]] || !responseObject) {
            
            responseDic = (NSDictionary *)responseObject;
            
            ErrorObject *errorObject = [[ErrorObject alloc] initWithDict:responseDic];
            
            // Check if response contains error
            if (errorObject) {
                
                NSError *error = [NSError errorWithDomain:kEmptyString code:error.code userInfo:@{NSLocalizedDescriptionKey:errorObject.message}];
                
                // Perform passed block
                void (^failureWrapperBlock)(NSURLSessionDataTask *task, NSError *error) = [self failureWrapperBlockWithFailureBlock:failure];
                failureWrapperBlock(task, error);
            }
            else {
                
                // Notify observers about success
                [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkRequestSuccessNotification object:nil];
                
                success(task, responseObject);
            }
            
        } else {
            
            NSError *error = [NSError errorWithDomain:kEmptyString code:0 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(@"Unable to parse response body")}];
            
            // Perform passed block
            void (^failureWrapperBlock)(NSURLSessionDataTask *task, NSError *error) = [self failureWrapperBlockWithFailureBlock:failure];
            failureWrapperBlock(task, error);
        }
    };
    
    return successWrapperBlock;
}

- (void (^)(NSURLSessionDataTask *task, NSError *error))failureWrapperBlockWithFailureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    // Wrap passed failure block inside wraping block so we could attach notifications
    void (^failureWrapperBlock)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error) {
        
        DLog(@"Request failed: %@", error.localizedDescription);
        
        NetworkRequestErrorType errorCase = kNetworkRequestNoError;
        
        switch (error.code) {
                
                // If request has not reached our server because of very slow internet (time out on app side)
            case kNetworkRequestErrorTimeoutCode:
                
                errorCase = kNetworkRequestTimeoutError;
                
                break;
                
                // If internet dissapeared in the middle of a request
            case kNetworkRequestErrorIsOfflineCode:
                
                errorCase = kNetworkRequestIsOfflineError;
                
                break;
                
                // Standard case when SERVER returns errors about bad data in request
            case kNetworkRequestErrorBadInputDataErrorCode:
                
                
                errorCase = kNetworkRequestBadInputDataError;
                break;
                
                
            default:
                
                // Sometimes we will cancel previous requests if user goes outside the screen or performs the new request because previous is not needed. In this case iOS we will receive kNetworkRequestErrorCanceledCode from the previous request and we need to ignore it. Otherwise log
                if (error.code != kNetworkRequestErrorCanceledCode) {
                    
                    //#warning TODO: log other http status code responses as errors
                    
                    errorCase = kNetworkRequestServerError;
                }
                
                break;
        }
        
        //Post notification in all cases except cancelation of the request
        if (error.code != kNetworkRequestErrorCanceledCode) {
            
            error = [NSError errorWithDomain:error.domain code:errorCase userInfo:error.userInfo];
            
            // Notify observers about failure with error code
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkRequestErrorNotification object:nil userInfo:@{kNetworkRequestErrorNotificationUserInfoKey:error}];
        }
        
        // Perform passed block
        failure(task, error);
    };
    
    return failureWrapperBlock;
}

- (NSString *)setAuthorizationHeader {
    
    UserManager *userManager = [REGISTRY getObject:[UserManager class]];
    NSString *token = userManager.user.token;
    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@", token] forHTTPHeaderField:@"Authorization"];
    return token;
}

- (NSString *)currentLanguage {
    
    SettingsManager *settingsManager = [REGISTRY getObject:[SettingsManager class]];
    
    return settingsManager.language;
}

@end
