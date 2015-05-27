//
//  MessageBarManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/12/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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

#import "MessageBarManager.h"
#import <TWMessageBarManager.h>

#define kMessageBarManagerDefaultDuration 3.0f

@interface MessageBarManager () <TWMessageBarStyleSheet> {
    
    TWMessageBarManager *_messageBarManager;
}

@end

@implementation MessageBarManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _messageBarManager = [TWMessageBarManager sharedInstance];
        _messageBarManager.styleSheet = self;
    }
    return self;
}

// Add needed methods and wrap inside this class methods. Encapsulate and expose wrapped ones only.
// https://github.com/terryworona/TWMessageBarManager

- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType {
    
    TWMessageBarMessageType convertedMessageType = [self convertedMessageTypeForType:messageType];
    
    [self showTWMessageWithTitle:title description:description type:convertedMessageType duration:kMessageBarManagerDefaultDuration];
}

- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType duration:(CGFloat)duration {
    
    TWMessageBarMessageType convertedMessageType = [self convertedMessageTypeForType:messageType];
    
    [self showTWMessageWithTitle:title description:description type:convertedMessageType duration:duration];
}

- (void)hideAllAnimated:(BOOL)animated {
    
    [_messageBarManager hideAllAnimated:animated];
}

- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType callback:(void (^)())callback {
    
    TWMessageBarMessageType convertedMessageType = [self convertedMessageTypeForType:messageType];
    
    [_messageBarManager showMessageWithTitle:title
                                 description:description
                                        type:convertedMessageType callback:callback];
}

- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType duration:(CGFloat)duration callback:(void (^)())callback {
    
    TWMessageBarMessageType convertedMessageType = [self convertedMessageTypeForType:messageType];
    
    [_messageBarManager showMessageWithTitle:title
                                 description:description
                                        type:convertedMessageType duration:duration callback:callback];
    
}

#pragma mark - private

// Converts and maps public enum to private enum
- (TWMessageBarMessageType)convertedMessageTypeForType:(MessageBarMessageType)messageType {
    
    TWMessageBarMessageType convertedType = TWMessageBarMessageTypeInfo;
    
    switch (messageType) {
            
        case MessageBarMessageTypeError:
            
            convertedType = TWMessageBarMessageTypeError;
            break;
            
        case MessageBarMessageTypeSuccess:
            
            convertedType = TWMessageBarMessageTypeSuccess;
            break;
            
        case MessageBarMessageTypeInfo:
            
            convertedType = TWMessageBarMessageTypeInfo;
            break;
    }
    
    return convertedType;
}

- (void)showTWMessageWithTitle:(NSString *)title description:(NSString *)description type:(TWMessageBarMessageType)messageType duration:(CGFloat)duration {
    
    [_messageBarManager showMessageWithTitle:title description:description type:messageType duration:duration];
}

#pragma mark - TWMessageBarStyleSheet

- (UIColor *)backgroundColorForMessageType:(TWMessageBarMessageType)type {
    
    if(type == TWMessageBarMessageTypeSuccess)
        return kColorGreen;
    else if(type == TWMessageBarMessageTypeError)
        return kColorRed;
    
    return kColorGray;
}

- (UIColor *)strokeColorForMessageType:(TWMessageBarMessageType)type {
    
    if(type == TWMessageBarMessageTypeSuccess)
        return kColorGreen;
    else if(type == TWMessageBarMessageTypeError)
        return kColorRed;
    
    return kColorGray;
}

- (UIImage *)iconImageForMessageType:(TWMessageBarMessageType)type {
    
    if(type == TWMessageBarMessageTypeSuccess)
        return [UIImage imageNamed:@"icon-success"];
    else if(type == TWMessageBarMessageTypeError)
        return [UIImage imageNamed:@"icon-error"];
    
    //TODO: choose icon for info type
    return [UIImage imageNamed:@"icon-info"];
}

@end
