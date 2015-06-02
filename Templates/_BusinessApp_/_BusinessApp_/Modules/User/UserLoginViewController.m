//
//  UserLoginViewController.m
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

#import "UserLoginViewController.h"
#import "UserLoginModel.h"

#define kUserLoginViewControllerUserNameKey @"Email"
#define kUserLoginViewControllerPasswordKey @"Password"
#define kUserLoginViewControllerIncorrectDataKey @"WrongEmailOrPasswordWasProvided"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (IBAction)showSignUpPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressSignUp)]) {
        
        [_delegate didPressSignUp];
    }
}

- (IBAction)resetPasswordPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressForgotPasswordWithEmail:)]) {
        
#warning TODO: pass entered email
        [_delegate didPressForgotPasswordWithEmail:nil];
    }
}

- (void)clearTextFields {
    
    [_model clearData];
    
    _usernameTextField.text = nil;
    _passwordTextField.text = nil;
    
    [_usernameTextField becomeFirstResponder];
}

#pragma mark - Base methods

- (void)commonInit {
    
    [super commonInit];

    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    [self configureScrollView];
    [self setupTextFields];
}

- (void)renderUI {
    
    [super renderUI];
    
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    // ...
}

- (void)updateModel {
    
    _model.user.email = _usernameTextField.text;
    _model.user.password = _passwordTextField.text;
}

#pragma mark - IBActions

- (IBAction)loginPressed:(id)sender {
    
    [self updateModel];
    
    if (![_model isValidData]) {
        
        // Mark required but empty fields in red
        [self applyStyleForMissingRequiredFields];
        
        GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:self title:nil message:GMLocalizedString(kUserLoginViewControllerIncorrectDataKey) cancelButtonTitle:GMLocalizedString(kOkKey) otherButtonTitles:nil];
        alertView.accessibilityLabel = [NSString stringWithFormat:@"%@WrongEmailOrPassword", [self class]];
        alertView.accessibilityIdentifier = alertView.accessibilityLabel;
        [alertView show];
        
    } else {
        
        // Reset previous warnings from fields
        [self resetStyleForMissingRequiredFields];
        
        __weak typeof(self) weakSelf = self;
        [weakSelf showScreenActivityIndicator];
        
        // Do login
        [_model login:^(BOOL success, id result, NSError *error){
            
            [weakSelf hideScreenActivityIndicator];
            
            if (success) {
                
                [weakSelf clearTextFields];
                [_delegate dismissLogin];
            }
        }];
    }
}

#pragma mark - KeyboardControlDelegate

- (void)didPressGo {
    
    [self loginPressed:nil];
}

#pragma mark - Helpers

- (void)configureScrollView {
    
    //self.contentScrollView.scrollEnabled = NO;
    self.shouldReturnToZeroScrollOffset = YES;
    
    // Adjust scrollView width
    self.usernameWidthConstraint.constant = [_delegate containerViewSizeForLogin].width;
}

// Add toolbar with previous and next buttons for navigating between input fields
- (void)setupTextFields {
    
    // Add placeholders
    _usernameTextField.placeholder = GMLocalizedString(kUserLoginViewControllerUserNameKey);
    _passwordTextField.placeholder = GMLocalizedString(kUserLoginViewControllerPasswordKey);
    
    // Set required fields
    _usernameTextField.isRequired = YES;
    _passwordTextField.isRequired = YES;
    
    // Apply style
    _usernameTextField.position = kTextFieldPositionIsFirst;
    _passwordTextField.position = kTextFieldPositionIsLast;
    
    // Setup keyboard controls
    NSArray *textFields = @[_usernameTextField, _passwordTextField];
    [self setTextFieldsForKeyboard:textFields];
}

@end
