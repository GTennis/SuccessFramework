//
//  KeyboardControlPrevNext.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/5/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "KeyboardControlProtocol.h"

@protocol KeyboardControlPrevNextDelegate <NSObject>

@property (nonatomic,readonly) UIView *view;

- (void)scrollToActiveField:(UIView *)textField;
- (void)didPressGo;

@optional

- (void)didPressToolbarCancel;

@end

@interface KeyboardControlPrevNext : NSObject <KeyboardControlProtocol>

@property (nonatomic, weak) id<KeyboardControlPrevNextDelegate> delegate;

@end
