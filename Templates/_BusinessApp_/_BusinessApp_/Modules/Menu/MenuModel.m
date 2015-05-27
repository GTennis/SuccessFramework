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

@implementation MenuModel

- (void)dealloc {
    
    [self.userManager removeServiceObserver:self];
}

- (void)commonInit {
    
    [super commonInit];
    
    // Add user state observing
    [self.userManager addServiceObserver:self];
}

- (void)willStartModelLoading:(Callback)callback {
    
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

- (void)didFinishModelLoadingWithData:(id)data {
    
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
