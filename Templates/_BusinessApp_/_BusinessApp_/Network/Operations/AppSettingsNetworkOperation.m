//
//  AppSettingsNetworkOperation.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "AppSettingsNetworkOperation.h"
#import "SettingObject.h"

@implementation AppSettingsNetworkOperation

- (NSString *)method {
    
    return @"GET";
}

- (NSString *)urlString {
    
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *urlString = [NSString stringWithFormat:@"%@/mvc-api/applications/v1/settings/ios-%@", [self baseUrl], appVersion];
    
    return urlString;
}

- (void)handleReceivedDataWithSuccess:(BOOL)success result:(id)result error:(NSError *)error callback:(Callback)callback {
    
    if (success) {
        
        NSError *errorDeserializationError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&errorDeserializationError];
        
        if (errorDeserializationError) {
            
            callback(NO, nil, errorDeserializationError);
            
        } else {
            
            SettingObject *setting = [[SettingObject alloc] initWithDict:dict];
            callback(YES, setting, nil);
        }
        
    } else {
        
        callback(NO, nil, error);
    }
}

@end
