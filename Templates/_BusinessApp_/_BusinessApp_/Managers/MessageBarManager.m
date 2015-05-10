//
//  MessageBarManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/12/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
