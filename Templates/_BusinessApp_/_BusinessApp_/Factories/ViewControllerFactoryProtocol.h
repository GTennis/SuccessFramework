//
//  ViewControllerFactoryProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/15/14.
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

#import "CountryPickerViewController.h"

@class LaunchViewController;
@class WalkthroughViewController;
@class HomeViewController;
@class UserContainerViewController;
@class UserLoginViewController;
@class UserSignUpViewController;
@class UserResetPasswordViewController;

@class SettingsViewController;
@class TermsConditionsViewController;
@class MenuViewController;
@class UserProfileViewController;
@class ContactViewController;
@class TableViewExampleViewController;
@class ScrollViewExampleViewController;
@class PhotoDetailsViewController;

@protocol ViewControllerFactoryProtocol <NSObject>

// Lauching related
- (LaunchViewController *)launchViewControllerWithContext:(id)context;
- (WalkthroughViewController *)walkthroughViewControllerWithContext:(id)context;

// User related
- (UserContainerViewController *)userContainerViewControllerWithContext:(id)context;
- (UserSignUpViewController *)userSignUpViewControllerWithContext:(id)context;
- (UserResetPasswordViewController *)userForgotPasswordViewControllerWithContext:(id)context;
- (UserLoginViewController *)userLoginViewControllerWithContext:(id)context;

// Settings
- (SettingsViewController *)settingsViewControllerWithContext:(id)context;

// Menu
- (MenuViewController *)menuViewControllerWithContext:(id)context;

// User profile
- (UserProfileViewController *)userProfileViewControllerWithContext:(id)context;

// Home related
- (HomeViewController *)homeViewControllerWithContext:(id)context;

- (PhotoDetailsViewController *)photoDetailsViewControllerWithContext:(id)context;

// Terms and Conditions
- (TermsConditionsViewController *)termsConditionsViewControllerWithContext:(id)context;

// Contact Us
- (ContactViewController *)contactsViewControllerWithContext:(id)context;

// Country picker
- (CountryPickerViewController *)countryPickerViewControllerWithDelegate:(id<CountryPickerViewControllerDelegate>)delegate context:(id)context;

// Demo
- (TableViewExampleViewController *)tableViewExampleViewControllerWithContext:(id)context;
- (ScrollViewExampleViewController *)scrollViewExampleViewControllerWithContext:(id)context;

@end
