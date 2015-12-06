//
//  PhoneCallCommand.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 20/05/15.
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

#import "PhoneCallCommand.h"

#define kPhoneCallCommandNotSupportedOnDeviceDomain @"kPhoneCallCommandNotSupportedOnDeviceDomain"
#define kPhoneCallCommandNotSupportedOnDeviceAlertTextKey @"kPhoneCallCommandNotSupportedOnDeviceAlertTextKey"

@interface PhoneCallCommand () {
    
    NSString *_phoneNumberString;
}

@end

@implementation PhoneCallCommand

#pragma mark - Public -

- (instancetype)initWithPhoneNumberString:(NSString *)phoneNumberString {
    
    self = [super init];
    
    if (self) {
        
        _phoneNumberString = phoneNumberString;
    }
    
    return self;
}

#pragma mark - CommandProtocol -

- (void)executeWithCallback:(Callback)callback {
    
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

#pragma mark - Private -

- (NSURL *)phoneNumberUrl {
    
    // Prepare url
    NSString *cleanedString = [[_phoneNumberString componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", cleanedString]];
    
    return url;
}

@end
