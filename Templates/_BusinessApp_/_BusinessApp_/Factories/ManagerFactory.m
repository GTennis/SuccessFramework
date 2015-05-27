//
//  ManagerFactory.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/16/14.
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
