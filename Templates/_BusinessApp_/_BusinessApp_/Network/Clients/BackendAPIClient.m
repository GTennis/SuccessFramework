//
//  BackendAPIClient.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BackendAPIClient.h"
#import "ImagesObject.h"

@interface BackendAPIClient () {
    
    NSInteger _configFailCount;
}

@end

@implementation BackendAPIClient

- (BOOL)shouldCancelSelfRequests {
    
    return YES;
}

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
    [self GET:@"/flickrImages.json" parameters:paramsDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
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

#pragma mark - User related methods

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
