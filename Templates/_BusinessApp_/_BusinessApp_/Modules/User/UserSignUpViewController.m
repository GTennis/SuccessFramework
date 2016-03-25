//
//  UserSignUpViewController.m
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

#import "UserSignUpViewController.h"
#import "UserSignUpModel.h"
#import "UILabel+Styling.h"
#import "UITextView+Styling.h"

#define kUserSignUpViewControllerEmailKey @"Email"
#define kUserSignUpViewControllerPasswordKey @"Password"
#define kUserSignUpViewControllerSalutationKey @"Salutation"
#define kUserSignUpViewControllerFirstNameKey @"First name"
#define kUserSignUpViewControllerLastNameKey @"Last name"
#define kUserSignUpViewControllerAddressKey @"Address"
#define kUserSignUpViewControllerAddressOptionalKey @"Address optional"
#define kUserSignUpViewControllerZipCodeKey @"Zip"
#define kUserSignUpViewControllerCountryCodeKey @"Country"
#define kUserSignUpViewControllerStateKey @"State"
#define kUserSignUpViewControllerCityKey @"City"
#define kUserSignUpViewControllerPhoneKey @"Phone"

#define kUserSignUpViewControllerIncorrectDataKey @"WrongDataWasProvided"

@interface UserSignUpViewController ()

@end

@implementation UserSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Log user behaviour
    [self.analyticsManager logScreen:kAnalyticsManagerScreenUserSignUp];
}

#pragma mark - Protected -

- (void)commonInit {
    
    [super commonInit];
    
    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    self.title = GMLocalizedString(kUserSignUpViewControllerTitle);
    
    [self adjustScrollVieWidthToFitScreen];
    [self setupTextFields];
    [self setupTappablePrivacyAndTermsTextView];
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
    
    user.salutation = _salutationTextField.text;
    user.firstName = _firstNameTextField.text;
    user.lastName =_lastNameTextField.text;
    user.address = _addressTextField.text;
    user.addressOptional = _addressOptionalTextField.text;
    user.zipCode = _zipCodeTextField.text;
    user.countryCode = _countryCodeTextField.text;
    user.stateCode = _stateCodeTextField.text;
    user.city = _cityTextField.text;
    user.phone = _phoneTextField.text;
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
    
    _salutationTextField.text = nil;
    _firstNameTextField.text = nil;
    _lastNameTextField.text = nil;
    _addressTextField.text = nil;
    _addressOptionalTextField.text = nil;
    _zipCodeTextField.text = nil;
    _countryCodeTextField.text = nil;
    _stateCodeTextField.text = nil;
    _cityTextField.text = nil;
    _phoneTextField.text = nil;
    _emailTextField.text = nil;
    _passwordTextField.text = nil;
    
    [_salutationTextField becomeFirstResponder];
}

#pragma mark IBActions

- (IBAction)countryPressed:(id)sender {
    
    BaseViewController *countryVC = [self.viewControllerFactory countryPickerViewControllerWithDelegate:self context:nil];
    
    [self presentModalViewController:countryVC animated:YES];
}

- (IBAction)signUpPressed:(id)sender {
    
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
        [_model signUp:^(BOOL success, id result, NSError *error){
            
            [weakSelf hideScreenActivityIndicator];
            
            if (success) {
                
                DDLogDebug(@"UserSignUpSuccess");
                
                [weakSelf clearTextFields];
                [_delegate didFinishSignUp];
            
            } else {
                
                DDLogDebug(@"UserSignUpFail: %@", error.localizedDescription);
            }
        }];
    }
}

#pragma mark - KeyboardControlDelegate -

- (void)didPressGo {
    
    [self signUpPressed:nil];
}

#pragma mark - CountryPickerViewControllerDelegate -

- (void)didSelectCountryCode:(NSString *)countryCode {
    
    _countryCodeTextField.text = countryCode;
}

#pragma mark - Private -

// Add toolbar with previous and next buttons for navigating between input fields
- (void)setupTextFields {
    
    // Add placeholders
    _salutationTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerSalutationKey);
    _firstNameTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerFirstNameKey);
    _lastNameTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerLastNameKey);
    _addressTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerAddressKey);
    _addressOptionalTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerAddressOptionalKey);
    _zipCodeTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerZipCodeKey);
    _countryCodeTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerCountryCodeKey);
    _stateCodeTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerStateKey);
    _cityTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerCityKey);
    _phoneTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerPhoneKey);
    _emailTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerEmailKey);
    _passwordTextField.placeholder = GMLocalizedString(kUserSignUpViewControllerPasswordKey);
    
    // Set required fields
    _salutationTextField.isRequired = YES;
    _firstNameTextField.isRequired = YES;
    _lastNameTextField.isRequired = YES;
    _addressTextField.isRequired = YES;
    _addressOptionalTextField.isRequired = YES;
    _zipCodeTextField.isRequired = YES;
    _countryCodeTextField.isRequired = YES;
    _stateCodeTextField.isRequired = YES;
    _cityTextField.isRequired = YES;
    _emailTextField.isRequired = YES;
    _passwordTextField.isRequired = YES;
    
    // Apply style
    _salutationTextField.position = kTextFieldPositionIsFirst;
    _firstNameTextField.position = kTextFieldPositionIsMiddle;
    _lastNameTextField.position = kTextFieldPositionIsMiddle;
    _addressTextField.position = kTextFieldPositionIsMiddle;
    _addressOptionalTextField.position = kTextFieldPositionIsMiddle;
    _zipCodeTextField.position = kTextFieldPositionIsMiddle;
    _countryCodeTextField.position = kTextFieldPositionIsMiddle;
    _stateCodeTextField.position = kTextFieldPositionIsMiddle;
    _cityTextField.position = kTextFieldPositionIsMiddle;
    _phoneTextField.position = kTextFieldPositionIsMiddle;
    _emailTextField.position = kTextFieldPositionIsMiddle;
    _passwordTextField.position = kTextFieldPositionIsLast;
    
    // Setup keyboard controls
    NSArray *textFields = @[_salutationTextField, _firstNameTextField, _lastNameTextField, _addressTextField, _addressOptionalTextField, _countryCodeTextField, _stateCodeTextField, _cityTextField, _zipCodeTextField, _phoneTextField, _emailTextField, _passwordTextField];
    [self setTextFieldsForKeyboard:textFields];
}

- (void)setupTappablePrivacyAndTermsTextView {
    
    // Add rich style elements to privacy and terms and conditions
    NSString *privacyString = @"privacy";
    NSString *termsString = @"terms and conditions";
    NSString *privacyAndTermsString = [NSString stringWithFormat:@"This is an example of %@ and %@.", privacyString, termsString];
    
    self.privacyAndTermsTextView.text = privacyAndTermsString;
    
    [self.privacyAndTermsTextView applyColorWithSubstring:privacyString color:kColorBlue];
    [self.privacyAndTermsTextView applyColorWithSubstring:termsString color:kColorBlue];
    
    //[_privacyAndTermsTextView applyBoldStyleWithSubstring:privacyString];
    //[_privacyAndTermsTextView applyBoldStyleWithSubstring:termsString];
    
    //[self.privacyAndTermsTextView applyUnderlineStyleWithSubstring:privacyString];
    //[self.privacyAndTermsTextView applyUnderlineStyleWithSubstring:termsString];
    
    [self.privacyAndTermsTextView addTapGestureWithSubstring:privacyString callback:^(BOOL success, id result, NSError *error) {
     
        DDLogDebug(@"Privacy clicked");
     }];
     
     [self.privacyAndTermsTextView addTapGestureWithSubstring:termsString callback:^(BOOL success, id result, NSError *error) {
     
         DDLogDebug(@"Terms clicked");
     }];
}

@end
