//
//  MenuNavigator.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "MenuNavigator.h"

@interface MenuNavigator ()

@end

@implementation MenuNavigator

#pragma mark - MenuNavigatorProtocol

- (instancetype)initWithMenuViewControler:(UIViewController *)menuViewController contentViewController:(UIViewController *)contentViewController {
    
    self = [super init];
    
    if (self) {
    
        self.leftMenuViewController = menuViewController;
        self.centerViewController = contentViewController;
        self.rightMenuViewController = nil;
        
    }
    return self;
}

- (void)toggleMenu {
    
    [self toggleLeftSideMenuCompletion:^{}];
}

- (void)setViewController:(UIViewController *)viewController {
    
    self.centerViewController = viewController;
    self.menuState = MFSideMenuStateClosed;
}

@end
