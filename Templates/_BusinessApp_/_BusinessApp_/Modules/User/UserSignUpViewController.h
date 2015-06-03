//
//  UserSignUpViewController.h
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

@class UserSignUpModel;

@protocol UserSignUpViewControllerDelegate <NSObject>

- (void)didFinishSignUp;
- (CGSize)containerViewSizeForSignUp;

@end

@interface UserSignUpViewController : BaseDetailsViewController <KeyboardControlDelegate, CountryPickerViewControllerDelegate>

@property (nonatomic, strong) UserSignUpModel *model;
@property (nonatomic, weak) id<UserSignUpViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet NormalTextField *emailTextField;
@property (weak, nonatomic) IBOutlet PasswordTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *salutationTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *addressTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *addressOptionalTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *countryCodeTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *stateCodeTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *cityTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet NormalTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *privacyAndTermsTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *salutatationTextFieldWidthConstraint;

- (IBAction)signUpPressed:(id)sender;
- (void)clearTextFields;

@end
