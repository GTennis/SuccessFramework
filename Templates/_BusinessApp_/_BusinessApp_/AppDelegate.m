//
//  AppDelegate.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/12/14.
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

#import "AppDelegate.h"

// Navigation
#import "MenuNavigator.h"
#import "TopNavigationBar.h"

// ViewControllers
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "LaunchViewController.h"
#import "WalkthroughViewController.h"

// Dependencies
#import "AnalyticsManager.h"
#import "UserManager.h"
#import "CrashManager.h"
#import "MessageBarManager.h"
#import "SettingsManager.h"
#import "ReachabilityManager.h"
#import "PushNotificationManager.h"
#import "KeychainManager.h"

// Network
#import "NetworkOperationFactory.h"
#import "ConfigNetworkOperation.h"
#import "AppConfigObject.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

// Logging
#import "GMLoggingConfig.h"

// Other
#import <iVersion.h>

#define kAppConfigRetryDelayDuration 1.5f

@interface AppDelegate () <WalkthroughViewControllerDelegate>

@end

@implementation AppDelegate

#pragma mark - Main

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Setup logging
    [GMLoggingConfig initializeLoggers];

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Setting app new app version detection and alerting functionality
    [self setupIVersion];
    
    // Show launch screen first
    LaunchViewController *launchVC = [[[ViewControllerFactory alloc] init] launchViewControllerWithContext:nil];
    self.window.rootViewController = launchVC;
    
    // Setup push notifications
    [self initializePushNotificationsWithinApplication:application launchOptions:launchOptions];
    
    // Get app configuration
    [self getAppConfigIsAppLaunch:@(YES)];
    
    // Show the stuff :)
    [self.window makeKeyAndVisible];
    
    // Return
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [_analyticsManager endSession];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self getAppConfigIsAppLaunch:@(NO)];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
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

- (void)applicationWillTerminate:(UIApplication *)application {
    
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

#pragma mark - Push Notifications

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    DDLogDebug(@"didRegisterUserNotificationSettings: %@", notificationSettings);
    
    // Register to receive push notifications
    [application registerForRemoteNotifications];
}

// For interactive notification only
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    
    DDLogDebug(@"handleActionWithIdentifier:%@ forRemoteNotification:%@", identifier, userInfo);
    
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
      
        // ...
        
    } else if ([identifier isEqualToString:@"answerAction"]){
        
        // ...
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    DDLogDebug(@"didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    
    PushNotificationManager *pushNotificationManager = [REGISTRY getObject:[PushNotificationManager class]];
    [pushNotificationManager registerPushNotificationToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    DDLogDebug(@"didReceiveRemoteNotification: %@", userInfo);
    
    PushNotificationManager *pushNotificationManager = [REGISTRY getObject:[PushNotificationManager class]];
    [pushNotificationManager handleReceivedPushNotificationWithUserInfo:userInfo application:application];
    
    // Check if force app reload notification was received
    BOOL shouldAppReload = [userInfo[@"appShouldReload"] boolValue];
    
    if (shouldAppReload) {
        
        if (application.applicationState == UIApplicationStateActive) {
            
            [self performForceReload];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    DDLogDebug(@"didFailToRegisterForRemoteNotificationsWithError: %@", error.localizedDescription);
}

- (void)initializePushNotificationsWithinApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    
    // Create push notification manager
    PushNotificationManager *pushNotificationManager = [REGISTRY getObject:[PushNotificationManager class]];
    if (!pushNotificationManager) {
        
        pushNotificationManager = [[PushNotificationManager alloc] init];
        [REGISTRY addObject:pushNotificationManager];
    }
    
    // Handle push notifications:
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        
    // Check if application was opened from push notification
    NSDictionary *notificationDict = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notificationDict) {
        
        // Forward push notification handling
        [self application:application didReceiveRemoteNotification:notificationDict];
    }
}

#pragma mark - WalkthroughViewControllerDelegate

- (void)didFinishShowingWalkthrough {
    
    // Proceed to the app after user completes walkthrough
    [self proceedToTheApp];
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
    
    return YES;
}

- (void)setupIVersion {
    
    // More info on configuration: http://www.binpress.com/app/iversion-automatic-update-tracking-for-your-apps/615
    
    //Checking period is set to 1 day
    [iVersion sharedInstance].checkPeriod = 1;
    //[iVersion sharedInstance].displayAppUsingStorekitIfAvailable = NO;
}

#pragma mark - Force to update and reload

// Method performs request to the backend and passes current app version. Backend returns bool indicating app should be updated or not. If yes then user is shown alert, navigated to app store for update and app is closed. Sometimes we need such functionality because of:
//
//  1. Previously released app contains critical errors and we need to update ASAP.
//  2. We released new app version which uses new backend API which is not backwards compatible with the old app
//  3. We have released a new app version which introduces major changes and there's no profit in allowing a users to continue to use old app.
//
//  A good example of such force to update is Clash of clans game app.
//
- (void)getAppConfigWithCallback:(Callback)callback {
    
    // Read the setting from plist. Will be read only once during app launch
    if (_backendEnvironment == kBackendEnvironmentNone) {
        
        _backendEnvironment = [[[[NSBundle mainBundle] infoDictionary] valueForKey:kAppConfigBackendEnvironmentPlistKey] integerValue];
        
        // Protection against plist bug - will auto pick production by default if no plist key value exist OR wrong provided
        if (_backendEnvironment == kBackendEnvironmentNone) {
            
            _backendEnvironment = kBackendEnvironmentProduction;
        }
    }

    // Create config network operation
    NetworkRequestObject *request = [[NetworkRequestObject alloc] initWithBackendEnvironment:_backendEnvironment];
    ConfigNetworkOperation *configOperation = [[ConfigNetworkOperation alloc] initWithNetworkRequestObject:request params:nil userManager:nil];
    
    // Perform
    [configOperation performWithCallback:^(BOOL success, id result, NSError *error) {
        
        callback(success, result, error);
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

- (void)performForceUpdate {
    
    DDLogDebug(@"App needs update...");
    
    GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:self.window.rootViewController title:nil message:GMLocalizedString(@"AppNeedsUpdate") cancelButtonTitle:GMLocalizedString(@"Update") otherButtonTitles:nil];
    
    __weak typeof(self) weakSelf = self;
    
    alertView.completion = ^(BOOL firstButtonPressed, NSInteger buttonIndex) {
        
        if (firstButtonPressed) {
            
            NSString *iTunesLink = weakSelf.appConfig.appStoreUrlString;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
            
            [self closeTheApp];
        }
    };
    
    [alertView show];
}

// It's a backdoor for critical cases. If app config request will return param indicating appConfigVersion has changed AND app is already running THEN app will close and therefore will reload itself (all the backend URLs)
- (void)performForceReload {
    
    DDLogDebug(@"App needs reload...");
    
    GMAlertView *alertView = [[GMAlertView alloc] initWithViewController:self.window.rootViewController title:nil message:GMLocalizedString(@"AppNeedsReload") cancelButtonTitle:GMLocalizedString(@"Reload") otherButtonTitles:nil];
    
    alertView.completion = ^(BOOL firstButtonPressed, NSInteger buttonIndex) {
        
        if (firstButtonPressed) {
            
            [self closeTheApp];
        }
    };
    
    [alertView show];
}

#pragma mark - App config

- (void)setAppConfig:(AppConfigObject *)appConfig {
    
    // Store app config
    _appConfig = appConfig;

    // Update global log level
    [GMLoggingConfig updateLogLevel:_appConfig.logLevel];
    
    // Set config to point to backend environment which is defined in main plist
    [_appConfig setCurrentRequestsWithBackendEnvironment:_backendEnvironment];
}

- (void)getAppConfigIsAppLaunch:(NSNumber *)isAppLaunching {
    
    __weak typeof(self) weakSelf = self;
    
    // Check if app needs force update
    [self getAppConfigWithCallback:^(BOOL success, id result, NSError *error) {
       
        AppConfigObject *newAppConfig = (AppConfigObject *)result;
        
        // If for any reason app config fails then retry (unlimited)
        if (!success || !newAppConfig) {
            
            [weakSelf performSelector:@selector(getAppConfigIsAppLaunch:) withObject:isAppLaunching afterDelay:kAppConfigRetryDelayDuration];
            
        } else {
            
            if (newAppConfig.isAppNeedUpdate) {
                
                [weakSelf performForceUpdate];
                
            } else {
                
                // If app is already launched and we just received app config upon returning from background
                if (![isAppLaunching boolValue]) {
                    
                    // Check if backend tells APIs has changed and app needs to reload
                    if (weakSelf.appConfig.appConfigVersion < newAppConfig.appConfigVersion) {
                        
                        [weakSelf performForceReload];
                        
                    } else {
                        
                        // Update config
                        [weakSelf setAppConfig:newAppConfig];
                    }
                    
                // Else continue launching app...
                } else {
                    
                    // Store config
                    [weakSelf setAppConfig:newAppConfig];
                    
                    // Continue
                    [weakSelf continueLaunchTheApp];
                }
            }
        }
    }];
}

#pragma mark - Helpers

- (UINavigationController *)navigationController {
    
    return _menuNavigator.centerViewController;
}

- (void)initializeSharedComponentsWithAppConfig:(AppConfigObject *)appConfig {
    
    // Creating and registering shared factory
    ViewControllerFactory *viewControllerFactory = [[ViewControllerFactory alloc] init];
    [REGISTRY addObject:viewControllerFactory];
    
    // Creating and registering main factory for producing network operations
    NetworkOperationFactory *networkOperationFactory = [[NetworkOperationFactory alloc] initWithAppConfig:appConfig];
    [REGISTRY addObject:networkOperationFactory];
    
    // Initializing all the managers and registering them on Registry
    [self initializeManagersWithAppConfig:appConfig networkOperationFactory:networkOperationFactory];
    
    // Injecting managers needed for AppDelegate later
    _analyticsManager = [REGISTRY getObject:[AnalyticsManager class]];
    _userManager = [REGISTRY getObject:[UserManager class]];
    _crashManager = [REGISTRY getObject:[CrashManager class]];
    _messageBarManager = [REGISTRY getObject:[MessageBarManager class]];
    _settingsManager = [REGISTRY getObject:[SettingsManager class]];
    
    networkOperationFactory.userManager = _userManager;
}

- (void)initializeManagersWithAppConfig:(AppConfigObject *)appConfig networkOperationFactory:(id<NetworkOperationFactoryProtocol>)networkOperationFactory {
    
    // Create shared managers and other shared single objects
    AnalyticsManager *analyticsManager = [[AnalyticsManager alloc] init];
    SettingsManager *settingsManager = [[SettingsManager alloc] init];
    KeychainManager *keychainManager = [[KeychainManager alloc] init];
    
    UserManager *userManager = [[UserManager alloc] initWithSettingsManager:settingsManager networkOperationFactory:networkOperationFactory analyticsManager:analyticsManager keychainManager:keychainManager];
    MessageBarManager *messageBarManager = [[MessageBarManager alloc] init];
    ReachabilityManager *reachabilityManager = [[ReachabilityManager alloc] init];
    CrashManager *crashManager = [[CrashManager alloc] init];
    
    // Set initial value for crash reports
    [crashManager setUserLanguage:settingsManager.language];
    
    // Register managers
    [REGISTRY addObject:settingsManager];
    [REGISTRY addObject:userManager];
    [REGISTRY addObject:analyticsManager];
    [REGISTRY addObject:messageBarManager];
    [REGISTRY addObject:reachabilityManager];
    [REGISTRY addObject:crashManager];
    
    // Register API clients
    // ...
}

- (void)continueLaunchTheApp {
    
    // Create main app components
    [self initializeSharedComponentsWithAppConfig:self.appConfig];
    
    // Check if app runs the very first time
    if (self.settingsManager.isFirstTimeAppLaunch) {
        
        // Show tutorial
        [self showWalkthroughWithError:nil];
        
    } else {
        
        // Or jump straight to the app
        [self proceedToTheApp];
    }
}

- (void)showWalkthroughWithError:(NSError *)error {
    
    // Protection: don't show twice
    if (![self.window.rootViewController isKindOfClass:[WalkthroughViewController class]]) {
        
        ViewControllerFactory *viewControllerFactory = [REGISTRY getObject:[ViewControllerFactory class]];
        WalkthroughViewController *walkthroughVC = [viewControllerFactory walkthroughViewControllerWithContext:nil];
        walkthroughVC.delegate = self;
        self.window.rootViewController = walkthroughVC;
        
        if (error) {
            
            [self.messageBarManager showMessageWithTitle:@"" description:error.localizedDescription type:MessageBarMessageTypeError duration:kMessageBarManagerMessageDuration];
        }
    }
}

- (void)proceedToTheApp {
    
    ViewControllerFactory *factory = [REGISTRY getObject:[ViewControllerFactory class]];
    
    MenuViewController *menuVC = [factory menuViewControllerWithContext:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[factory homeViewControllerWithContext:nil]];
    
    // Create and configure side menu component (width, shadow, panning speed and etc.)
    _menuNavigator = [[MenuNavigator alloc] initWithMenuViewControler:menuVC contentViewController:navigationController];
    [REGISTRY addObject:_menuNavigator];
    
    // Assign side menu component as main app navigator
    self.window.rootViewController = _menuNavigator;
        
    // Apply common style
    [TopNavigationBar applyStyleForNavigationBar:self.navigationController.navigationBar];
}

@end
