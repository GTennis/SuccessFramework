//
//  ViewControllerFactoryProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/15/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "CountryPickerViewController.h"

@class LaunchScreenViewController;
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

@protocol ViewControllerFactoryProtocol <NSObject>

// User related
- (UserContainerViewController *)userContainerViewControllerWithContext:(id)params;
- (UserSignUpViewController *)userSignUpViewControllerWithContext:(id)params;
- (UserResetPasswordViewController *)userForgotPasswordViewControllerWithContext:(id)params;
- (UserLoginViewController *)userLoginViewControllerWithContext:(id)context;

// Settings
- (SettingsViewController *)settingsViewControllerWithContext:(id)context;

// Menu
- (MenuViewController *)menuViewControllerWithContext:(id)context;

// User profile
- (UserProfileViewController *)userProfileViewControllerWithContext:(id)context;

// Main
- (HomeViewController *)homeViewControllerWithContext:(id)context;

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
