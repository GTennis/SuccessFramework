//
//  BackendAPIClient.m
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

#import "BackendAPIClient.h"
#import "ImagesObject.h"

@interface BackendAPIClient () {
    
    NSInteger _configFailCount;
}

@end

@implementation BackendAPIClient

#pragma mark - Protected -

#pragma mark Override

- (BOOL)shouldCancelSelfRequests {
    
    return YES;
}

#pragma mark - BackendAPIClientProtocol -

- (void)getAppSettingsWithParam1:(id)param1 callback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    // Prepare parameters
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    
    if (param1) {
        
        [paramsDic setObject:param1 forKey:@"SomeParam"];
    }
    
    // Perform request
    [self GET:@"config.jsona" parameters:paramsDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        DLog(@"[%@]: getConfig success", [self class]);
        
        // Resetting
        _configFailCount = 0;
        
        // Perform data parsing
        //...
        
        // Callback
        callback(YES, responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        // Fail
        [weakSelf handleFailWithError:error failCounter:&_configFailCount callback:callback retrySelector:@selector(getAppSettingsWithParam1:callback:) param1:param1];
    }];
}

- (void)getTopImagesWithTag:(id)tag callback:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    // Prepare parameters
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    
    if (tag) {
        
        [tag setObject:tag forKey:@"Tag"];
    }
    
    // Perform request
    [self GET:@"/ws/v1/flickrImages.json" parameters:paramsDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        DLog(@"[%@]: getTopImagesWithTag success", [self class]);
        
        // Resetting
        _configFailCount = 0;
        
        // Perform data parsing
        ImagesObject *images = [[ImagesObject alloc] initWithDict:responseObject];
        
        // Callback
        callback(YES, images, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        // Fail
        [weakSelf handleFailWithError:error failCounter:&_configFailCount callback:callback retrySelector:@selector(getTopImagesWithTag:callback:) param1:tag];
    }];
}

// User related methods

- (void)loginUserWithData:(UserObject *)user callback:(Callback)callback {
    
    callback(YES, nil, nil);
}

- (void)signUpUserWithData:(UserObject *)user callback:(Callback)callback {
    
    callback(YES, nil, nil);
}

- (void)resetPasswordWithData:(UserObject *)user callback:(Callback)callback {
    
    callback(YES, nil, nil);
}

- (void)getUserWithData:(UserObject *)user callback:(Callback)callback {
    
    callback(YES, nil, nil);
}

@end
