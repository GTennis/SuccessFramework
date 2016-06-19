//
//  MenuModel.m
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

#import "MenuModel.h"
#import "ViewControllerFactory.h"
#import "MenuItemObject.h"

@interface MenuModel () {
    
    Callback _loadModelCallback;
}

@end

@implementation MenuModel

- (void)dealloc {
    
    [self.userManager removeServiceObserver:self];
}

#pragma mark - Public -

- (BOOL)isUserLoggedIn {
    
    return self.userManager.isUserLoggedIn;
}

- (void)logoutUser {
    
    [self.userManager logout];
}

#pragma mark - Protected -

- (void)commonInit {
    
    [super commonInit];
    
    // Add user state observing
    [self.userManager addServiceObserver:self];
}

- (void)willStartModelLoading:(Callback)callback {
    
    // Save for login/signup/logout callbacks later
    _loadModelCallback = callback;
    
    NSArray *itemList = nil;
    
    if (self.userManager.isUserLoggedIn) {
        
        itemList = [self menuItemsForLoggedInUserState];
        
    } else {
        
        itemList = [self menuItemsForNotLoggedInUserState];
    }
    
    // Done
    callback(YES, itemList, nil);
}

- (void)didFinishModelLoadingWithData:(id)data error:(NSError *)error {
    
    // Store menu items
    _menuItems = data;
}

#pragma mark - UserManagerObserver -

- (void)didLoginUser:(UserObject *)userObject {
    
    _menuItems = [self menuItemsForLoggedInUserState];
    
    // Notify view controler
    // Adding protection because was crashing upon opening app with 401
    if (_loadModelCallback) {
        
        _loadModelCallback(YES, _menuItems, nil);
    }
}

- (void)didSignUpUser:(UserObject *)userObject {
    
    _menuItems = [self menuItemsForLoggedInUserState];
    
    // Notify view controler
    // Adding protection because was crashing upon opening app with 401
    if (_loadModelCallback) {
        
        _loadModelCallback(YES, _menuItems, nil);
    }
}

- (void)didLogoutUser:(UserObject *)userObject {
    
    _menuItems = [self menuItemsForNotLoggedInUserState];
    
    // Notify view controler
    // Adding protection because was crashing upon opening app with 401
    if (_loadModelCallback) {
        
        _loadModelCallback(YES, _menuItems, nil);
    }
}

#pragma mark - Private -

// For mocking in unit tests
- (id<ViewControllerFactoryProtocol>)viewControllerFactory {
    
    ViewControllerFactory *factory = [REGISTRY getObject:[ViewControllerFactory class]];
    
    return factory;
}

- (NSMutableArray *)menuItemsForNotLoggedInUserState {
    
    // Create menu items
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    
    // Create menu items
    id<ViewControllerFactoryProtocol> viewControllerFactory = [self viewControllerFactory];
    
    // Home
    MenuItemObject *item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemMapKey);
    item.viewController = self.context;
    [itemList addObject:item];
    
    // Settings
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemSettingsKey);
    item.viewController = (BaseViewController *) [viewControllerFactory settingsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // User login
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemLoginKey);
    item.viewController = (BaseViewController *) [viewControllerFactory userContainerViewControllerWithContext:nil];
    item.isPresentedModally = YES;
    [itemList addObject:item];
    
    // TermsConditions
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemTermsConditionsKey);
    item.viewController = (BaseViewController *) [viewControllerFactory termsConditionsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Privacy policy
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemPrivacyPolicyKey);
    item.viewController = (BaseViewController *) [viewControllerFactory privacyPolicyViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TableViewExample
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewExampleKey);
    item.viewController = (BaseViewController *) [viewControllerFactory tableViewExampleViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TableView with search
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewWithSearchKey);
    item.viewController = (BaseViewController *) [viewControllerFactory tableWithSearchViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Map
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemMapWithSearchKey);
    item.viewController = (BaseViewController *) [viewControllerFactory mapsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Return
    return itemList;
}

- (NSMutableArray *)menuItemsForLoggedInUserState {
    
    // Create menu items
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    
    // Create menu items
    id<ViewControllerFactoryProtocol> viewControllerFactory = [self viewControllerFactory];
    
    // Home
    MenuItemObject *item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemMapKey);
    item.viewController = self.context;
    [itemList addObject:item];
    
    // Settings
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemSettingsKey);
    item.viewController = (BaseViewController *) [viewControllerFactory settingsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TermsConditions
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemTermsConditionsKey);
    item.viewController = (BaseViewController *) [viewControllerFactory termsConditionsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Privacy policy
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemPrivacyPolicyKey);
    item.viewController = (BaseViewController *) [viewControllerFactory privacyPolicyViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TableViewExample
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewExampleKey);
    item.viewController = (BaseViewController *) [viewControllerFactory tableViewExampleViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TableView with search
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewWithSearchKey);
    item.viewController = (BaseViewController *) [viewControllerFactory tableWithSearchViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Map
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(kMenuModelMenuItemMapWithSearchKey);
    item.viewController = (BaseViewController *) [viewControllerFactory mapsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Return
    return itemList;
}

@end
