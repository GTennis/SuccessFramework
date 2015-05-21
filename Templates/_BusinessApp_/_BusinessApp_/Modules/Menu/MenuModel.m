//
//  MenuModel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "MenuModel.h"
#import "ViewControllerFactory.h"
#import "MenuItemObject.h"

@implementation MenuModel

- (void)dealloc {
    
    [self.userManager removeServiceObserver:self];
}

- (void)commonInit {
    
    [super commonInit];
    
    // Add user state observing
    [self.userManager addServiceObserver:self];
}

- (void)onDataLoading:(Callback)callback {
    
    // Create menu items
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    
    // Create menu items
    id<ViewControllerFactoryProtocol> viewControllerFactory = [self viewControllerFactory];
    
    // Home
    MenuItemObject *item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(@"Home");
    item.viewController = (UIViewController *) [viewControllerFactory homeViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Settings
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(@"Settings");
    item.viewController = (UIViewController *) [viewControllerFactory settingsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TermsConditions
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(@"TermsConditions");
    item.viewController = (UIViewController *) [viewControllerFactory termsConditionsViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // ScrollViewExample
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(@"ScrollViewExample");
    item.viewController = (UIViewController *) [viewControllerFactory scrollViewExampleViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // TableViewExample
    item = [[MenuItemObject alloc] init];
    item.menuTitle = GMLocalizedString(@"TableViewExample");
    item.viewController = (UIViewController *) [viewControllerFactory tableViewExampleViewControllerWithContext:nil];
    [itemList addObject:item];
    
    // Done
    callback(YES, itemList, nil);
}

- (void)onDataLoaded:(id)data {
    
    // Store menu items
    _menuItems = data;
}

#pragma mark - UserManagerObserver

// ...

#pragma mark - Helpers

// For mocking in unit tests
- (id<ViewControllerFactoryProtocol>)viewControllerFactory {
    
    ViewControllerFactory *factory = [REGISTRY getObject:[ViewControllerFactory class]];
    
    return factory;
}

@end
