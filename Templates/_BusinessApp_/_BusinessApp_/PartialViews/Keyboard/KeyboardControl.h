//
//  KeyboardControl.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/5/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "KeyboardControlProtocol.h"

@protocol KeyboardControlDelegate <NSObject>

- (NSString *)keyboardToolbarActionTitle;
- (void)didPressToolbarAction;
- (void)didPressGo; // When last text field is active then GO button is shown right+bottom on the keyboard and it should be used for handling action (Save, Send, Register, ...)

@optional

- (void)didPressToolbarCancel;

@end

@interface KeyboardControl : NSObject <KeyboardControlProtocol>

@property (nonatomic, weak) id<KeyboardControlDelegate> delegate;

@end
