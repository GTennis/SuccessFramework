//
//  ManagerFactory.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ManagerFactory.h"
/*#import "BackendAPIClient.h"
#import "UserManager.h"
#import "GoogleAnalyticsManager.h"
#import "CrashManager.h"
#import "SettingsManager.h"
#import "UserManager.h"
#import "MessageBarManager.h"*/

@implementation ManagerFactory

+ (void)initialize {
    
    // This implementation causes leaks. After moving it to AppDelegate, cleaning build and removing app from simulator leaks dissapearred
    
    // Create managers and other shared single objects
    /*BackendAPIClient *backendAPIClient = [[BackendAPIClient alloc] init];
    SettingsManager *settingsManager = [[SettingsManager alloc] init];
    UserManager *userManager = [[UserManager alloc] initWithSettingsManager:settingsManager backendAPIClient:backendAPIClient];
    GoogleAnalyticsManager *googleAnalyticsManager = [[GoogleAnalyticsManager alloc] init];
    CrashManager *crashManager = [[CrashManager alloc] init];
    MessageBarManager *messageBarManager = [[MessageBarManager alloc] init];
    
    // Register managers
    [REGISTRY registerObject:backendAPIClient];
    [REGISTRY registerObject:settingsManager];
    [REGISTRY registerObject:userManager];
    [REGISTRY registerObject:googleAnalyticsManager];
    [REGISTRY registerObject:crashManager];
    [REGISTRY registerObject:messageBarManager];*/
}

@end
