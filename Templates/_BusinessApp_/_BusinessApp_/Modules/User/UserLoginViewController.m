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
#import "KeyboardControlProtocol.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Log user behaviour
    [self.analyticsManager logScreen:kAnalyticsManagerScreenUserLogin];
}

#pragma mark - Protected -

- (void)commonInit {
    
    [super commonInit];

    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    self.title = GMLocalizedString(kUserLoginViewControllerTitle);
    _subTitleLabel.text = GMLocalizedString(kUserLoginViewControllerSubTitle);
    _orLabel.text = GMLocalizedString(kUserLoginViewControllerLoginOrLabel);
    [_loginButton setTitle:GMLocalizedString(kUserLoginViewControllerLoginButtonKey) forState:UIControlStateNormal];
    [_signUpButton setTitle:GMLocalizedString(kUserLoginViewControllerLoginSignUpButtonKey) forState:UIControlStateNormal];
    
    [self adjustScrollVieWidthToFitScreen];
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
    
    UserObject *user = [[UserObject alloc] init];
    user.email = _emailTextField.text;
    user.password = _passwordTextField.text;
    
    [_model updateModelWithData:user];
}

#pragma mark Language change handling

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
}

#pragma mark - Public -

- (void)clearTextFields {
    
    [_model clearData];
    
    _emailTextField.text = nil;
    _passwordTextField.text = nil;
    
    [self.keyboardControls.activeField resignFirstResponder];
}

#pragma mark IBActions

- (IBAction)loginPressed:(id)sender {
    
    [self updateModel];
    
    NSError *validationError = [_model validateData];
    
    if (validationError) {
        
        // Mark required but empty fields in red
        [self applyStyleForMissingRequiredFields];
        
        DDLogDebug(@"SignUpPressedWithWrongData");
        
        [self.messageBarManager showMessageWithTitle:@"" description:validationError.localizedDescription type:MessageBarMessageTypeError duration:kMessageBarManagerMessageDuration];
        
    } else {
        
        // Reset previous warnings from fields
        [self resetStyleForMissingRequiredFields];
        
        __weak typeof(self) weakSelf = self;
        [weakSelf showScreenActivityIndicator];
        
        // Do login
        [_model login:^(BOOL success, id result, NSError *error){
            
            [weakSelf hideScreenActivityIndicator];
            
            if (success) {
                
                DDLogDebug(@"UserLoginSuccess");
                
                [weakSelf clearTextFields];
                [_delegate didFinishLogin];
            
            } else {
                
                DDLogDebug(@"UserLoginFail: %@", error.localizedDescription);
            }
        }];
    }
}

- (IBAction)signUpPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressSignUp)]) {
        
        [_delegate didPressSignUp];
    }
}

- (IBAction)resetPasswordPressed:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(didPressForgotPasswordWithEmail:)]) {
        
    // TODO.. pass email
        [_delegate didPressForgotPasswordWithEmail:nil];
    }
}

#pragma mark - KeyboardControlDelegate -

- (void)didPressGo {
    
    [self loginPressed:nil];
}

#pragma mark - Private -

// Add toolbar with previous and next buttons for navigating between input fields
- (void)setupTextFields {
    
    // Add placeholders
    _emailTextField.placeholder = GMLocalizedString(kUserLoginViewControllerLoginUsernameKey);
    _passwordTextField.placeholder = GMLocalizedString(kUserLoginViewControllerLoginPasswordKey);
    
    // Set required fields
    _emailTextField.isRequired = YES;
    _passwordTextField.isRequired = YES;
    
    // Apply style
    _emailTextField.position = kTextFieldPositionIsFirst;
    _passwordTextField.position = kTextFieldPositionIsLast;
    
    // Setup keyboard controls
    NSArray *textFields = @[_emailTextField, _passwordTextField];
    [self setTextFieldsForKeyboard:textFields];
}

@end
