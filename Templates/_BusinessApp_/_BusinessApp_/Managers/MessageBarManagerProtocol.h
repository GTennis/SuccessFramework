//
//  MessageBarManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/12/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

typedef enum {
    
    MessageBarMessageTypeError,
    MessageBarMessageTypeSuccess,
    MessageBarMessageTypeInfo
    
} MessageBarMessageType;

@protocol MessageBarManagerProtocol <NSObject>

- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType;
- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType duration:(CGFloat)duration;
- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType callback:(void (^)())callback;
- (void)showMessageWithTitle:(NSString *)title description:(NSString *)description type:(MessageBarMessageType)messageType duration:(CGFloat)duration callback:(void (^)())callback;
- (void)hideAllAnimated:(BOOL)animated;

@end