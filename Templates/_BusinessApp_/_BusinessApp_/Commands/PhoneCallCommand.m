//
//  PhoneCallCommand.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 20/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "PhoneCallCommand.h"

#define kPhoneCallCommandNotSupportedOnDeviceDomain @"kPhoneCallCommandNotSupportedOnDeviceDomain"
#define kPhoneCallCommandNotSupportedOnDeviceAlertTextKey @"kPhoneCallCommandNotSupportedOnDeviceAlertTextKey"

@interface PhoneCallCommand () {
    
    NSString *_phoneNumberString;
}

@end

@implementation PhoneCallCommand

- (instancetype)initWithPhoneNumberString:(NSString *)phoneNumberString {
    
    self = [super init];
    
    if (self) {
        
        _phoneNumberString = phoneNumberString;
    }
    
    return self;
}

#pragma mark - CommandProtocol

- (void)execute {
    
    NSError *error = nil;
    
    if ([self canExecute:&error]) {
        
        [[UIApplication sharedApplication] openURL:[self phoneNumberUrl]];
    }
}

- (BOOL)canExecute:(NSError **)error {
    
    if ([[UIApplication sharedApplication] canOpenURL:[self phoneNumberUrl]]) {
        
        return YES;
        
    } else {
        
        NSDictionary *userInfoDict = @{NSLocalizedDescriptionKey:GMLocalizedString(kPhoneCallCommandNotSupportedOnDeviceAlertTextKey)};
        (*error) = [NSError errorWithDomain:kPhoneCallCommandNotSupportedOnDeviceDomain code:0 userInfo:userInfoDict];
        
        return NO;
    }
}

#pragma mark - Helpers

- (NSURL *)phoneNumberUrl {
    
    // Prepare url
    NSString *cleanedString = [[_phoneNumberString componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", cleanedString]];
    
    return url;
}

@end
