//
//  ViewControllerFactory.m
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

#import "ViewControllerFactory.h"
#import "NetworkOperationFactory.h"
#import "ViewManager.h"
#import "SettingsManager.h"
#import "UserManager.h"
#import "CrashManager.h"
#import "AnalyticsManager.h"
#import "ReachabilityManager.h"
#import "BackendAPIClient.h"
#import "MessageBarManager.h"

// Launch related
#import "LaunchViewController.h"
#import "WalkthroughViewController.h"
#import "WalkthroughModel.h"

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

// User forgotPassword
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

// Legal
#import "TermsConditionsViewController.h"
#import "TermsConditionsModel.h"
#import "PrivacyPolicyViewController.h"
#import "PrivacyPolicyModel.h"

// Demo
#import "TableViewExampleViewController.h"

// Pickers
#import "CountryPickerViewController.h"

#ifdef DEBUG 

#import "ConsoleLogViewController.h"

#endif

@implementation ViewControllerFactory

#pragma mark - ViewControllerFactoryProtocol -

#pragma mark Launch related

- (LaunchViewController *)launchViewControllerWithContext:(id)context {
    
    LaunchViewController *viewController = (LaunchViewController *)[self viewControllerWithClass:[LaunchViewController class] context:context];
    
    return viewController;
}

- (WalkthroughViewController *)walkthroughViewControllerWithContext:(id)context {
    
    WalkthroughModel *model = (WalkthroughModel *)[self modelWithClass:[WalkthroughModel class] context:context];
    WalkthroughViewController *viewController = (WalkthroughViewController *)[self viewControllerWithClass:[WalkthroughViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

#pragma mark Home related

- (HomeViewController *)homeViewControllerWithContext:(id)context {
    
    HomeModel *model = (HomeModel *)[self modelWithClass:[HomeModel class] context:context];
    HomeViewController *viewController = (HomeViewController *)[self viewControllerWithClass:[HomeViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;

    return viewController;
}

- (PhotoDetailsViewController *)photoDetailsViewControllerWithContext:(id)context {
    
    PhotoDetailsModel *model = (PhotoDetailsModel *)[self modelWithClass:[PhotoDetailsModel class] context:context];
    PhotoDetailsViewController *viewController = (PhotoDetailsViewController *)[self viewControllerWithClass:[PhotoDetailsViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

#pragma mark User related

- (UserContainerViewController *)userContainerViewControllerWithContext:(id)context {
    
    UserContainerModel *model = (UserContainerModel *)[self modelWithClass:[UserContainerModel class] context:context];
    UserContainerViewController *viewController = (UserContainerViewController *)[self viewControllerWithClass:[UserContainerViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

- (UserLoginViewController *)userLoginViewControllerWithContext:(id)context {
    
    UserLoginModel *model = (UserLoginModel *)[self modelWithClass:[UserLoginModel class] context:context];
    UserLoginViewController *viewController = (UserLoginViewController *)[self viewControllerWithClass:[UserLoginViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

- (UserSignUpViewController *)userSignUpViewControllerWithContext:(id)context {
    
    UserSignUpModel *model = (UserSignUpModel *)[self modelWithClass:[UserSignUpModel class] context:context];
    UserSignUpViewController *viewController = (UserSignUpViewController *)[self viewControllerWithClass:[UserSignUpViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

- (UserForgotPasswordViewController *)userForgotPasswordViewControllerWithContext:(id)context {
    
    UserForgotPasswordModel *model = (UserForgotPasswordModel *)[self modelWithClass:[UserForgotPasswordModel class] context:context];
    UserForgotPasswordViewController *viewController = (UserForgotPasswordViewController *)[self viewControllerWithClass:[UserForgotPasswordViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

- (UserProfileViewController *)userProfileViewControllerWithContext:(id)context {
    
    UserProfileModel *model = (UserProfileModel *)[self modelWithClass:[UserProfileModel class] context:context];
    UserProfileViewController *viewController = (UserProfileViewController *)[self viewControllerWithClass:[UserProfileViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

#pragma mark Settings related

- (SettingsViewController *)settingsViewControllerWithContext:(id)context {
    
    SettingsModel *model = (SettingsModel *)[self modelWithClass:[SettingsModel class] context:context];
    SettingsViewController *viewController = (SettingsViewController *)[self viewControllerWithClass:[SettingsViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

#pragma mark Menu related

- (MenuViewController *)menuViewControllerWithContext:(id)context {

    MenuModel *model = (MenuModel *)[self modelWithClass:[MenuModel class] context:context];
    //[menuModel.userManager addServiceObserver:menuModel];
    MenuViewController *viewController = (MenuViewController *)[self viewControllerWithClass:[MenuViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;

    return viewController;
}

#pragma mark Legal related

- (TermsConditionsViewController *)termsConditionsViewControllerWithContext:(id)context {

    TermsConditionsModel *model = (TermsConditionsModel *)[self modelWithClass:[TermsConditionsModel class] context:context];
    TermsConditionsViewController *viewController = (TermsConditionsViewController *)[self viewControllerWithClass:[TermsConditionsViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;

    return viewController;
}

- (PrivacyPolicyViewController *)privacyPolicyViewControllerWithContext:(id)context {
    
    PrivacyPolicyModel *model = (PrivacyPolicyModel *)[self modelWithClass:[PrivacyPolicyModel class] context:context];
    PrivacyPolicyViewController *viewController = (PrivacyPolicyViewController *)[self viewControllerWithClass:[PrivacyPolicyViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;
    
    return viewController;
}

#pragma mark Contacts related

- (ContactsViewController *)contactsViewControllerWithContext:(id)context {

    ContactsModel *model = (ContactsModel *)[self modelWithClass:[ContactsModel class] context:context];
    ContactsViewController *viewController = (ContactsViewController *)[self viewControllerWithClass:[ContactsViewController class] context:context];
    viewController.model = model;
    model.delegate = viewController;

    return viewController;
}

#pragma mark Demos

- (TableViewExampleViewController *)tableViewExampleViewControllerWithContext:(id)context {
    
    TableViewExampleViewController *viewController = (TableViewExampleViewController *)[self viewControllerWithClass:[TableViewExampleViewController class] context:context];
    
    return viewController;
}

#pragma mark Pickers

// Country list
- (CountryPickerViewController *)countryPickerViewControllerWithDelegate:(id<CountryPickerViewControllerDelegate>)delegate context:(id)context {
    
    CountryPickerViewController *viewController = (CountryPickerViewController *) [self viewControllerWithClass:[CountryPickerViewController class] context:context];
    viewController.delegate = delegate;
    
    return viewController;
}

#pragma mark Debug

#ifdef DEBUG

- (ConsoleLogViewController *)consoleLogViewControllerWithContext:(id)context {
    
    ConsoleLogViewController *viewController = (ConsoleLogViewController *)[self viewControllerWithClass:[ConsoleLogViewController class] context:context];
    
    return viewController;
}

#endif

#pragma mark - Private -

// For creating view controllers with default dependencies
- (BaseViewController *)viewControllerWithClass:(Class)class context:(id)context {
    
    // Autopick device class
    
    NSString *viewControllerClassName = NSStringFromClass(class);
    
    if (isIpad) {
        
        viewControllerClassName = [NSString stringWithFormat:@"%@_ipad", viewControllerClassName];
        
    } else {
        
        viewControllerClassName = [NSString stringWithFormat:@"%@_iphone", viewControllerClassName];
    }
    
    Class deviceClass = NSClassFromString(viewControllerClassName);
    
    // Create view controller
    BaseViewController *viewController = [[deviceClass alloc] initWithViewManager:[self viewManager] crashManager:[self crashManager] analyticsManager:[self analyticsManager] messageBarManager:[self messageBarManager] viewControllerFactory:self reachabilityManager:[self reachabilityManager] context:context];
    
    return viewController;
}

// For creating models of view controllers with default dependencies
- (BaseModel *)modelWithClass:(Class)class context:(id)context {
    
    BaseModel *model = [[class alloc] initWithUserManager:[self userManager] networkOperationFactory:[self networkOperationFactory] settingsManager:[self settingsManager] reachabilityManager:[self reachabilityManager] analyticsManager:[self analyticsManager] context:context];
    
    return model;
}

#pragma mark Injectable

// Every view controller should have its own viewManager because it will store references to the view controller and its views
- (ViewManager *)viewManager {
    
    ViewManager *viewManager = [[ViewManager alloc] init];
    return viewManager;
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

- (NetworkOperationFactory *)networkOperationFactory {
    
    NetworkOperationFactory *networkOperationFactory = [REGISTRY getObject:[NetworkOperationFactory class]];
    return networkOperationFactory;
}

@end
