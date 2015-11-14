//
//  ConfigNetworkOperation.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 26/08/15.
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

#import "ConfigNetworkOperation.h"
#import "AppConfigObject.h"
#import "NSString+Utils.h"

@implementation ConfigNetworkOperation

#pragma mark - Protected -

#pragma mark Override

- (NSString *)requestUrlParams {
    
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *action = [NSString stringWithFormat:@"?ios-%@", appVersion];
    
    return action;
}

- (void)handleReceivedDataWithSuccess:(BOOL)success result:(id)result error:(NSError *)error callback:(Callback)callback {
    
    if (success) {
        
        AppConfigObject *appConfig = [[AppConfigObject alloc] initWithDict:result];
            callback(YES, appConfig, nil);
        
    } else {
        
        callback(NO, nil, error);
    }
}

// For local config testing
/*- (void)performWithCallback:(Callback)callback {
    
    NSDictionary *dict = [@"config" readJsonFile];
    AppConfigObject *config = [[AppConfigObject alloc] initWithDict:dict];
    
    callback(YES, config, nil);
}*/

@end
