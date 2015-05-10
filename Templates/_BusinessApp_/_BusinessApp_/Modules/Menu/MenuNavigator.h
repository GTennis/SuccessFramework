//
//  MenuNavigator.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"

@protocol MenuNavigatorProtocol <NSObject>

- (instancetype)initWithMenuViewControler:(UIViewController *)menuViewController contentViewController:(UIViewController *)contentViewController;
- (void)toggleMenu;
- (void)setViewController:(UIViewController *)viewController;

@end

@interface MenuNavigator : MFSideMenuContainerViewController <MenuNavigatorProtocol>

@end
