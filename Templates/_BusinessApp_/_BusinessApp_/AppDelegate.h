//
//  AppDelegate.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/12/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrashManagerProtocol.h"
#import "AnalyticsManagerProtocol.h"
#import "MessageBarManagerProtocol.h"
#import "UserManagerProtocol.h"

@class MenuNavigator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) MenuNavigator *menuNavigator;
@property (strong, nonatomic) UIViewController *rootViewController;

@property (strong, nonatomic) id<CrashManagerProtocol> crashManager;
@property (strong, nonatomic) id<AnalyticsManagerProtocol> analyticsManager;
@property (strong, nonatomic) id<UserManagerProtocol> userManager;
@property (strong, nonatomic) id<MessageBarManagerProtocol> messageBarManager;

- (void)closeLaunchScreenAndProceed;

@end
