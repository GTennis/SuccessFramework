//
//  AppDelegate.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/12/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "AppDelegate.h"

#import "MenuNavigator.h"

#import "HomeViewController.h"
#import "TopNavigationBar.h"
#import "MenuViewController.h"
#import "LaunchViewController.h"

#import "AnalyticsManager.h"
#import "UserManager.h"
#import "CrashManager.h"
#import "MessageBarManager.h"
#import "SettingsManager.h"
#import "ReachabilityManager.h"

#import "BackendAPIClient.h"
#import "AppSettingsNetworkOperation.h"
#import "SettingObject.h"
#import "ConstNetworkConfig.h"

#import "GMAlertView.h"

#import <iVersion.h>

#warning Update this link before releasing to the app store!
#define kAppItunesLink @"yourAppStoreLink"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Setting app new app version detection and alerting functionality
    [self setupIVersion];
    
    // Show launch screen first.
    self.window.rootViewController = [[LaunchViewController alloc] init];
    
    // Initializing all the managers and registering them on Registry
    [self initializeManagers];
    
    // Setting app new app version detection and alerting functionality
    [self setupIVersion];
    
    // Injecting managers needed for AppDelegate later
    _analyticsManager = [REGISTRY getObject:[AnalyticsManager class]];
    _userManager = [REGISTRY getObject:[UserManager class]];
    _crashManager = [REGISTRY getObject:[CrashManager class]];
    _messageBarManager = [REGISTRY getObject:[MessageBarManager class]];
    
    [self checkAndOverrideGeneralSettingsLanguageIfNotSupported];
    
    // Creating and registering shared factory
    ViewControllerFactory *viewControllerFactory = [[ViewControllerFactory alloc] init];
    [REGISTRY registerObject:viewControllerFactory];
    
#warning Push notifications
    // Register for push notifications
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    
    NSDictionary *remoteNotificationLaunchOptions = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    // Check if application was opened through notification with passed data
    id passedId = remoteNotificationLaunchOptions[@"passedId"];
    if (remoteNotificationLaunchOptions && passedId) {
        
        // Check and open related screen with
        // [self openScreenWithId:passedId];
        // ...
    }
    
    // Check if app needs force update
    [self checkForAppUpdate];
    
    // Show the stuff :)
    [self.window makeKeyAndVisible];
    
    // Return
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [_analyticsManager endSession];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // Check if app needs force update
    [self checkForAppUpdate];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Reset badges if any exists upong opening the app
    if (application.applicationIconBadgeNumber) {
        
        application.applicationIconBadgeNumber = 0;
    }
    
    // Start GA session
    [_analyticsManager startSession];
    
    // Track user status for crash reports
    if ([_userManager isUserLoggedIn]) {
        
        [_crashManager setUserHasLoggedIn:YES];
        
    } else {
        
        [_crashManager setUserHasLoggedIn:NO];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    if (isIpad) {
        
        return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
        
    } else if (isIphone) {
      
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
        
    } else {
     
        return UIInterfaceOrientationMaskPortrait;
    }
}

#pragma mark - Apple Push Notifications

// Handle received APN token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Remove spaces and other symbols
    /*NSString *deviceTokenString = [[[deviceToken.description stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                    stringByReplacingOccurrencesOfString:@" " withString:@""]
                                   stringByReplacingOccurrencesOfString:@">" withString:@""];*/
    
    // TODO:
    
    // 1) Send to backend
    // 2) Store token localy: add set/get methods in SettingsManager
}

// Handle received push notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSString *someId = userInfo[@"someId"];
    
    if (someId) {
    
        if (application.applicationState == UIApplicationStateActive) {
            
            // TODO:
            // [self showMeSomeScreenWhenAppIsActive]
            
        } else {
            
            // TODO:
            // [self showMeSomeScreenWhenAppIsNotActive]
        }
    }
}

#pragma mark - Force to update

- (void)checkForAppUpdate {
    
    AppSettingsNetworkOperation *appSettingsNetworkOperation = [[AppSettingsNetworkOperation alloc] init];
    
    [appSettingsNetworkOperation getDataWithCallback:^(BOOL success, id result, NSError *error) {
        
        SettingObject *setting = result;
        
        if (setting.isAppNeedUpdate) {
            
            DLog(@"App needs update...");
            
            GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:_rootViewController title:nil message:GMLocalizedString(@"AppNeedsUpdate") cancelButtonTitle:GMLocalizedString(@"Update") otherButtonTitles:nil];
            
            alertView.completion = ^(BOOL firstButtonPressed, NSInteger buttonIndex) {
                
                if (firstButtonPressed) {
                    
                    NSString *iTunesLink = kAppItunesLink;
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
                    
                    [self closeTheApp];
                }
            };
            
            [alertView show];
            
        } else {
            
            DLog(@"App is up to date.");
        }
    }];
}

// Solution used from http://stackoverflow.com/questions/355168/proper-way-to-exit-iphone-application
- (void)closeTheApp {
    
    //home button press programmatically
    UIApplication *app = [UIApplication sharedApplication];
    [app performSelector:@selector(suspend)];
    
    //wait 2 seconds while app is going background
    [NSThread sleepForTimeInterval:2.0];
    
    //exit app when app is in background
    exit(EXIT_SUCCESS);
}

#pragma mark - iVersionDelegate

- (void)iVersionDidDetectNewVersion:(NSString *)version details:(NSString *)versionDetails {
    
    [_messageBarManager showMessageWithTitle:GMLocalizedString(@"New app version is available") description:GMLocalizedString(@"New app version is available")
                                        type:MessageBarMessageTypeInfo
                                    duration:5.0
                                    callback:^{
                                        
                                        [iVersion sharedInstance].lastChecked = [NSDate date];
                                        [iVersion sharedInstance].lastReminded = [NSDate date];
                                        [[iVersion sharedInstance] openAppPageInAppStore];
                                    }];
}

- (BOOL)iVersionShouldDisplayNewVersion:(NSString *)version details:(NSString *)versionDetails {
    
    return YES;//NO;
}

#pragma mark - Helpers

- (void)initializeManagers {
    
    // Create managers and other shared single objects
    AnalyticsManager *analyticsManager = [[AnalyticsManager alloc] init];
    BackendAPIClient *backendAPIClient = [[BackendAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL] analyticsManager:analyticsManager];
    SettingsManager *settingsManager = [[SettingsManager alloc] init];
    UserManager *userManager = [[UserManager alloc] initWithSettingsManager:settingsManager backendAPIClient:backendAPIClient analyticsManager:analyticsManager];
    MessageBarManager *messageBarManager = [[MessageBarManager alloc] init];
    ReachabilityManager *reachabilityManager = [[ReachabilityManager alloc] init];
    CrashManager *crashManager = [[CrashManager alloc] init];
    
    // Set initial value for crash reports
    [crashManager setUserLanguage:settingsManager.language];
    
    // Register managers
    [REGISTRY registerObject:settingsManager];
    [REGISTRY registerObject:userManager];
    [REGISTRY registerObject:analyticsManager];
    [REGISTRY registerObject:messageBarManager];
    [REGISTRY registerObject:reachabilityManager];
    [REGISTRY registerObject:crashManager];
    
    // Register API clients
    [REGISTRY registerObject:backendAPIClient];
}

- (void)closeLaunchScreenAndProceed {
    
    // Create root view controller
    ViewControllerFactory *factory = [REGISTRY getObject:[ViewControllerFactory class]];
    
    MenuViewController *menuVC = [factory menuViewControllerWithContext:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[factory homeViewControllerWithContext:nil]];

    // Create and configure side menu component (width, shadow, panning speed and etc.)
    _menuNavigator = [[MenuNavigator alloc] initWithMenuViewControler:menuVC contentViewController:navigationController];
    [REGISTRY registerObject:_menuNavigator];
    
    // Assign side menu component as main app navigator
    self.window.rootViewController = _menuNavigator;
    
    // Load user if logged in before
    UserManager *userManager = [REGISTRY getObject:[UserManager class]];
    [userManager loadUser];

    // Apply style
    //[AppNavigationBar applyStyleForNavigationBar:_navigationController.navigationBar];
}

// Currently the app supports 2 languages only - "en" and "de". If user has selected other language than those two then "en" will be set as default
- (void)checkAndOverrideGeneralSettingsLanguageIfNotSupported {
    
    SettingsManager *settingsManager = [REGISTRY getObject:[SettingsManager class]];
    
    if (![settingsManager.language isEqualToString:kLanguageEnglish] && ![settingsManager.language isEqualToString:kLanguageGerman]) {
        
        [settingsManager setLanguageEnglish];
    }
}

- (void)setupIVersion {
    
    // More info on configuration: http://www.binpress.com/app/iversion-automatic-update-tracking-for-your-apps/615
    
    //Checking period is set to 1 day
    [iVersion sharedInstance].checkPeriod = 1;
    [iVersion sharedInstance].displayAppUsingStorekitIfAvailable = NO;
}

@end
