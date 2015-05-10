//
//  PasswordTextField.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseTextField.h"

@protocol PasswordTextFieldDelegate <NSObject>

- (void)didPressedTogglePassword;

@end

@interface PasswordTextField : BaseTextField

@property (nonatomic, weak) id<PasswordTextFieldDelegate> toggleDelegate;
@property (nonatomic) BOOL isPasswordShown;

- (void)togglePasswordReveal;

@end