//
//  UserLoginViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
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

#import "BaseDetailsViewController.h"
#import "KeyboardControl.h"

@class UserLoginModel;

@protocol UserLoginViewControllerDelegate <NSObject>

- (void)dismissLogin;

- (void)didPressSignUp;
- (void)didPressForgotPasswordWithEmail:(NSString *)email;
- (CGSize)containerViewSizeForLogin;

@end

@interface UserLoginViewController : BaseDetailsViewController <KeyboardControlDelegate>

@property (nonatomic, strong) UserLoginModel *model;
@property (nonatomic, weak) id<UserLoginViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet NormalTextField *usernameTextField;
@property (weak, nonatomic) IBOutlet PasswordTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usernameWidthConstraint;

- (IBAction)loginPressed:(id)sender;
- (void)clearTextFields;

@end
