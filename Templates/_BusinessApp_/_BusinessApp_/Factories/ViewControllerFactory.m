//
//  ViewControllerFactory.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/15/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "SettingsManager.h"
#import "UserManager.h"
#import "CrashManager.h"
#import "AnalyticsManager.h"
#import "ReachabilityManager.h"
#import "BackendAPIClient.h"
#import "MessageBarManager.h"

// Home related
#import "HomeViewController.h"
#import "HomeModel.h"
#import "PhotoDetailsViewController.h"
#import "PhotoDetailsModel.h"

// User container
#import "UserContainerViewController.h"
#import "UserContainerModel.h"

// User login
#import "UserLoginViewController.h"
#import "UserLoginModel.h"

// User sign up
#import "UserSignUpViewController.h"
#import "UserSignUpModel.h"

// User resetPassword
#import "UserForgotPasswordViewController.h"
#import "UserForgotPasswordModel.h"

// Settings
#import "SettingsViewController.h"
#import "SettingsModel.h"

// Menu
#import "MenuViewController.h"
#import "MenuModel.h"

// User Profile
#import "UserProfileViewController.h"
#import "UserProfileModel.h"

// Contact us
#import "ContactsViewController.h"
#import "ContactsModel.h"

// Terms and Conditions
#import "TermsConditionsViewController.h"
#import "TermsConditionsModel.h"

// Demo
#import "ScrollViewExampleViewController.h"
#import "TableViewExampleViewController.h"

// Pickers
#import "CountryPickerViewController.h"

@implementation ViewControllerFactory

#pragma mark - Home related

- (HomeViewController *)homeViewControllerWithContext:(id)context {
    
    HomeModel *homeModel = (HomeModel *)[self modelWithClass:[HomeModel class] context:context];
    HomeViewController *homeViewController = (HomeViewController *)[self viewControllerWithClass:[HomeViewController class] context:context];
    homeViewController.model = homeModel;

    return homeViewController;
}

- (PhotoDetailsViewController *)photoDetailsViewControllerWithContext:(id)context {
    
    PhotoDetailsModel *model = (PhotoDetailsModel *)[self modelWithClass:[PhotoDetailsModel class] context:context];
    PhotoDetailsViewController *viewController = (PhotoDetailsViewController *)[self viewControllerWithClass:[PhotoDetailsViewController class] context:context];
    viewController.model = model;
    
    return viewController;
}

#pragma mark - User related

- (UserContainerViewController *)userContainerViewControllerWithContext:(id)context {
    
    UserContainerModel *userModel = (UserContainerModel *)[self modelWithClass:[UserContainerModel class] context:context];
    UserContainerViewController *userContainerViewController = (UserContainerViewController *)[self viewControllerWithClass:[UserContainerViewController class] context:context];
    userContainerViewController.model = userModel;
    
    userModel.delegate = userContainerViewController;
    
    return userContainerViewController;
}

- (UserLoginViewController *)userLoginViewControllerWithContext:(id)context {
    
    UserLoginModel *userLoginModel = (UserLoginModel *)[self modelWithClass:[UserLoginModel class] context:context];
    UserLoginViewController *userLoginViewController = (UserLoginViewController *)[self viewControllerWithClass:[UserLoginViewController class] context:context];
    userLoginViewController.model = userLoginModel;
    
    userLoginModel.delegate = userLoginViewController;
    
    return userLoginViewController;
}

- (UserSignUpViewController *)userSignUpViewControllerWithContext:(id)context {
    
    UserSignUpModel *userSignUpModel = (UserSignUpModel *)[self modelWithClass:[UserSignUpModel class] context:context];
    UserSignUpViewController *userSignUpViewController = (UserSignUpViewController *)[self viewControllerWithClass:[UserSignUpViewController class] context:context];
    userSignUpViewController.model = userSignUpModel;
    
    userSignUpModel.delegate = userSignUpViewController;
    
    return userSignUpViewController;
}

- (UserForgotPasswordViewController *)userForgotPasswordViewControllerWithContext:(id)context {
    
    UserForgotPasswordModel *userForgotPasswordModel = (UserForgotPasswordModel *)[self modelWithClass:[UserForgotPasswordModel class] context:context];

    UserForgotPasswordViewController *userResetPasswordViewController = (UserForgotPasswordViewController *)[self viewControllerWithClass:[UserForgotPasswordViewController class] context:context];
    userResetPasswordViewController.model = userForgotPasswordModel;
    
    userForgotPasswordModel.delegate = userResetPasswordViewController;
    
    return userResetPasswordViewController;
}

#pragma mark - Settings

- (SettingsViewController *)settingsViewControllerWithContext:(id)context {
    
    SettingsModel *settingsModel = (SettingsModel *)[self modelWithClass:[SettingsModel class] context:context];
    SettingsViewController *settingsViewController = (SettingsViewController *)[self viewControllerWithClass:[SettingsViewController class] context:context];
    settingsViewController.model = settingsModel;
    
    return settingsViewController;
}

#pragma mark - Menu

- (MenuViewController *)menuViewControllerWithContext:(id)context {

    MenuModel *menuModel = (MenuModel *)[self modelWithClass:[MenuModel class] context:context];
    //[menuModel.userManager addServiceObserver:menuModel];
    MenuViewController *menuViewController = (MenuViewController *)[self viewControllerWithClass:[MenuViewController class] context:context];
    menuViewController.model = menuModel;
    menuModel.delegate = menuViewController;

    return menuViewController;
}

#pragma mark - User Profile

- (UserProfileViewController *)userProfileViewControllerWithContext:(id)context {

    UserProfileModel *userProfileModel = (UserProfileModel *)[self modelWithClass:[UserProfileModel class] context:context];
    UserProfileViewController *userProfileViewController = (UserProfileViewController *)[self viewControllerWithClass:[UserProfileViewController class] context:context];
    userProfileViewController.model = userProfileModel;

    return userProfileViewController;
}

#pragma mark - Terms and Conditions

- (TermsConditionsViewController *)termsConditionsViewControllerWithContext:(id)context {

    TermsConditionsModel *termsConditionsModel = (TermsConditionsModel *)[self modelWithClass:[TermsConditionsModel class] context:context];
    TermsConditionsViewController *termsConditionsViewController = (TermsConditionsViewController *)[self viewControllerWithClass:[TermsConditionsViewController class] context:context];
    termsConditionsViewController.model = termsConditionsModel;

    return termsConditionsViewController;
}

#pragma mark - Contacts

- (ContactsViewController *)contactsViewControllerWithContext:(id)context {

    ContactsModel *contactsModel = (ContactsModel *)[self modelWithClass:[ContactsModel class] context:context];
    ContactsViewController *contactsViewController = (ContactsViewController *)[self viewControllerWithClass:[ContactsViewController class] context:context];
    contactsViewController.model = contactsModel;

    return contactsViewController;
}

#pragma mark - Demos

- (ScrollViewExampleViewController *)scrollViewExampleViewControllerWithContext:(id)context {
    
    ScrollViewExampleViewController *scrollViewExampleViewController = (ScrollViewExampleViewController *)[self viewControllerWithClass:[ScrollViewExampleViewController class] context:context];
    
    return scrollViewExampleViewController;
}

- (TableViewExampleViewController *)tableViewExampleViewControllerWithContext:(id)context {
    
    TableViewExampleViewController *tableViewExampleViewController = (TableViewExampleViewController *)[self viewControllerWithClass:[TableViewExampleViewController class] context:context];
    
    return tableViewExampleViewController;
}

#pragma mark - Pickers

// Country list
- (CountryPickerViewController *)countryPickerViewControllerWithDelegate:(id<CountryPickerViewControllerDelegate>)delegate context:(id)context {
    
    CountryPickerViewController *countryPickerVC = (CountryPickerViewController *) [self viewControllerWithClass:[CountryPickerViewController class] context:context];
    
    return countryPickerVC;
}

#pragma mark - Helpers

// For creating view controllers with default dependencies
- (BaseViewController *)viewControllerWithClass:(Class)class context:(id)context {
    
    BaseViewController *viewController = [[class alloc] initWithCrashManager:[self crashManager] analyticsManager:[self analyticsManager] messageBarManager:[self messageBarManager] viewControllerFactory:self context:context];
    
    return viewController;
}

// For creating models of view controllers with default dependencies
- (BaseModel *)modelWithClass:(Class)class context:(id)context {
    
    BaseModel *model = [[class alloc] initWithUserManager:[self userManager] backendAPIClient:[self backendAPIClient] settingsManager:[self settingsManager] reachabilityManager:[self reachabilityManager] analyticsManager:[self analyticsManager] context:context];
    
    return model;
}

- (UserManager *)userManager {
    
    UserManager *userManager = [REGISTRY getObject:[UserManager class]];
    return userManager;
}

- (SettingsManager *)settingsManager {
    
    SettingsManager *settingsManager = [REGISTRY getObject:[SettingsManager class]];
    return settingsManager;
}

- (CrashManager *)crashManager {
    
    CrashManager *crashManager = [REGISTRY getObject:[CrashManager class]];
    return crashManager;
}

- (AnalyticsManager *)analyticsManager {
    
    AnalyticsManager *analyticsManager = [REGISTRY getObject:[AnalyticsManager class]];
    return analyticsManager;
}

- (MessageBarManager *)messageBarManager {
    
    MessageBarManager *messageBarManager = [REGISTRY getObject:[MessageBarManager class]];
    return messageBarManager;
}


- (ReachabilityManager *)reachabilityManager {
    
    ReachabilityManager *reachabilityManager = [REGISTRY getObject:[ReachabilityManager class]];
    return reachabilityManager;
}

- (BackendAPIClient *)backendAPIClient {
    
    BackendAPIClient *backendAPIClient = [REGISTRY getObject:[BackendAPIClient class]];
    return backendAPIClient;
}

@end
