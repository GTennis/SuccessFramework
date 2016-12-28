//
//  AppDelegate.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 06/09/16.
//  Copyright © 2016 Gytenis Mikulėnas
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

import UIKit
import iVersion
import UserNotifications

let kAppConfigRetryDelayDuration = 1.5
let kTabHomeItemTitle = "TabItemHome"
let kTabMenuItemTitle = "TabItemMenu"

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, WalkthroughViewControllerDelegate, UserContainerViewControllerDelegate {

    // Common
    var window: UIWindow?
    
    // Configuration
    var backendEnvironment: BackendEnvironmentType!
    var appConfig: AppConfigEntity!
    
    // Dependencies
    
    lazy var viewControllerFactory: ViewControllerFactoryProtocol = {
        
        return ViewControllerFactory.init(managerFactory: self.managerFactory)
    }()

    var managerFactory: ManagerFactoryProtocol = ManagerFactory.shared()
    var userManager: UserManagerProtocol = ManagerFactory.shared().userManager
    var keychainManager: KeychainManagerProtocol = ManagerFactory.shared().keychainManager
    var settingsManager: SettingsManagerProtocol = ManagerFactory.shared().settingsManager
    var crashManager: CrashManagerProtocol = ManagerFactory.shared().crashManager
    var analyticsManager: AnalyticsManagerProtocol = ManagerFactory.shared().analyticsManager
    var messageBarManager: MessageBarManagerProtocol = ManagerFactory.shared().messageBarManager
    var reachabilityManager: ReachabilityManagerProtocol = ManagerFactory.shared().reachabilityManager
    var networkOperationFactory: NetworkOperationFactoryProtocol = ManagerFactory.shared().networkOperationFactory
    var localizationManager: LocalizationManagerProtocol = ManagerFactory.shared().localizationManager
    var logManager: LogManagerProtocol = ManagerFactory.shared().logManager
    var pushNotificationManager: PushNotificationManagerProtocol = ManagerFactory.shared().pushNotificationManager
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
 
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = self.viewControllerFactory.launchViewController(context: nil);
        
        // Setting app new app version detection and alerting functionality
        self.setupIVersion()
        
        // Setup push notifications
        self.registerForPushNotifications(application: application)
        
        // Get app configuration
        self.getAppConfig(isAppLaunch:true)
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        analyticsManager.endSession()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        self.getAppConfig(isAppLaunch:false)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Reset badges if any exists upong opening the app
        if (application.applicationIconBadgeNumber > 0) {
            
            application.applicationIconBadgeNumber = 0
        }
        
        // Start GA session
        analyticsManager.startSession()
        
        // Track user status for crash reports
        if (userManager.isUserLoggedIn()) {
            
            crashManager.updateUserWith(isLoggedIn: true)
            
        } else {
            
            crashManager.updateUserWith(isLoggedIn: false)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if (isIpad) {
            
            return [UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.landscapeLeft]
            
        } else if (isIphone) {
            
            return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.portraitUpsideDown]
            
        } else {
            
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    // MARK: WalkthroughViewControllerDelegate
    
    func didFinishShowingWalkthrough() {
        
        // Proceed to the app after user completes walkthrough
        self.continueLaunchTheApp()
    }
    
    // MARK: UserContainerViewControllerDelegate
    
    func didAuthentificateUser() {
        
        // Proceed to the app after user completes walkthrough
        self.proceedToTheApp()
    }
    
    // MARK: Push and local Notifications
    // Source1: http://stackoverflow.com/a/39618207/597292
    // Source2: https://makeapppie.com/2016/08/08/how-to-make-local-notifications-in-ios-10/
    
    func registerForPushNotifications(application: UIApplication) {
        
        DispatchQueue.main.async {
            
            let options: UNAuthorizationOptions = [.badge, .sound, .alert]
            
            UNUserNotificationCenter.current().delegate = self
            
            // This in general asks a user if he wants to be bored with any type of notifications (both push and local notifications
            UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: { [weak self] (granted, error) in
                
                // Store user's preference
                self?.settingsManager.isGrantedNotificationAccess = granted
                
                DDLogDebug(log: "AppDelegate: registerForPushNotifications, user granted: " + stringify(object: granted))
                
                if (granted) {
                    
                    // This registers for push notifications
                    application.registerForRemoteNotifications()
                    
                } else {
                    
                    // ...
                }
            })
        }
    }
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        var message: String = "AppDelegate: center:willPresent:notification"
        
        if let responseValue = notification.request.content.userInfo["myDictKey"] as? String {
            
            message = message + " passedValue: " + responseValue
        }
        
        DDLogDebug(log: message)
    }
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
     
        var message: String = "AppDelegate: center:didReceive:response"
        
        if let responseValue = response.notification.request.content.userInfo["myDictKey"] as? String {
            
            message = message + " passedValue: " + responseValue
        }
        
        DDLogDebug(log: message)
    }
    
    // Interactive notifications
    // http://www.thinkandbuild.it/interactive-notifications-with-notification-actions/
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        
        DDLogDebug(log: "AppDelegate: handleActionWithIdentifierForRemoteNotification :" + identifier! + userInfo.description)
        
        //handle the actions
        if (identifier?.isEqual("declineAction"))!{
            
            // ...
            
        } else if (identifier?.isEqual("answerAction"))! {
            
            // ...
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        DDLogDebug(log: "AppDelegate: didRegisterForRemoteNotificationsWithDeviceToken :" + deviceToken.description)
        
        self.pushNotificationManager.registerPushNotification(token: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        DDLogDebug(log: "AppDelegate: didFailToRegisterForRemoteNotificationsWithError: " + error.localizedDescription);
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        DDLogDebug(log: "AppDelegate: didReceiveRemoteNotification: " + userInfo.description);
        
        let topVC: UIViewController = UIApplication.topViewController()!
        pushNotificationManager.handleReceivedPushNotification(userInfo: userInfo, application: application, topViewController: topVC)
        
        // Check if force app reload notification was received
        let shouldAppReload: Bool? = userInfo["appShouldReload"] as? Bool
        
        if shouldAppReload != nil {
            
            if (application.applicationState == UIApplicationState.active) {
                
                self.performForceReload()
            }
        }
    }
    
    // MARK: iVersionDelegate
    
    func iVersionDidDetect(newVersion: String, details: String) {
                
        messageBarManager.showMessage(title: localizedString(key:"New app version is available"), description: localizedString(key:"New app version is available"), type: MessageBarMessageType.info, duration: 5) { () in
            
            iVersion.sharedInstance().lastChecked = Date()
            iVersion.sharedInstance().lastReminded = Date()
            iVersion.sharedInstance().openAppPageInAppStore()
        }
    }
    
    func iVersionShouldDisplay(newVersion: String, details: String) -> Bool {
        
        return true
    }
    
    func setupIVersion() {
    
        // More info on configuration: http://www.binpress.com/app/iversion-automatic-update-tracking-for-your-apps/615
    
        //Checking period is set to 1 day
        iVersion.sharedInstance().checkPeriod = 1;
        //[iVersion sharedInstance].displayAppUsingStorekitIfAvailable = NO;
    }

    // MARK : Force to update and reload
    
    // Method performs request to the backend and passes current app version. Backend returns bool indicating app should be updated or not. If yes then user is shown alert, navigated to app store for update and app is closed. Sometimes we need such functionality because of:
    //
    //  1. Previously released app contains critical errors and we need to update ASAP.
    //  2. We released new app version which uses new backend API which is not backwards compatible with the old app
    //  3. We have released a new app version which introduces major changes and there's no profit in allowing a users to continue to use old app.
    //
    //  A good example of such force to update is Clash of clans game app.
    //
    
    func getAppConfig(callback: @escaping Callback) {
    
        // Read hardcoded default config: which backend to use in this build
        if let backendEnvironment = Bundle.plistValue(key: kAppConfigBackendEnvironmentPlistKey) as? Int {
            
            // Store
            self.backendEnvironment = BackendEnvironmentType(rawValue: backendEnvironment)
            
            // Request
            let request: NetworkRequestEntity = NetworkRequestEntity.init(backendEnvironment: BackendEnvironmentType(rawValue: backendEnvironment)!)
            let configOperation = networkOperationFactory.configNetworkOperation(context: request as Any)
            
            // Perform
            configOperation.perform(callback: callback)
        }
    }
    
    // Solution used from http://stackoverflow.com/questions/355168/proper-way-to-exit-iphone-
    func closeTheApp() {
        
        //let app: UIApplication = UIApplication.shared
        //app.perform(#selector(UIApplication.suspend))
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        
        //wait 2 seconds while app is going background
        Thread.sleep(forTimeInterval: 2.0)
        
        //exit app when app is in background
        exit(EXIT_SUCCESS);
    }
    
    func performForceUpdate(appConfig: AppConfigEntity) {
        
        DDLogDebug(log: "App needs update...")
        
        self.messageBarManager.showAlertOkWithTitle(title: "", description: localizedString(key:"AppNeedsUpdate"), okTitle: "Update") { [weak self] () in
            
            let iTunesLink: String = appConfig.appStoreUrlString
            UIApplication.shared.open(NSURL(string:iTunesLink) as! URL, options: [:], completionHandler: nil)
            
            self?.closeTheApp()
        }
    }
    
    // It's a backdoor for critical cases. If app config request will return param indicating appConfigVersion has changed AND app is already running THEN app will close and therefore will reload itself (all the backend URLs)
    func performForceReload() {
    
        DDLogDebug(log: "App needs reload...")
        
        self.messageBarManager.showAlertOkWithTitle(title: "", description: "AppNeedsReload", okTitle: "Reload") { [weak self] () in
            
            self?.closeTheApp()
        }
    }
    
    // MARK: App config
    
    func setAppConfig(appConfig: AppConfigEntity) {
        
        // Store app config
        self.appConfig = appConfig;
        
        // Set config to point to backend environment which is defined in main plist
        appConfig.setCurrentRequests(backendEnvironment: self.backendEnvironment)
        
        // Update global log level
        self.logManager.set(logLevel: appConfig.logLevel)
        
        // Update with new appConfig
        self.networkOperationFactory = NetworkOperationFactory.init(appConfig: appConfig, settingsManager: self.settingsManager)
        self.networkOperationFactory.userManager = self.userManager
        self.userManager.networkOperationFactory = self.networkOperationFactory
        self.managerFactory.networkOperationFactory = self.networkOperationFactory
    }
    
    func getAppConfig(isAppLaunch: Bool) {

        // Check if app needs force update
        self.getAppConfig { [weak self] (success, result, context, error) in
            
            let newAppConfig: AppConfigEntity? = result as? AppConfigEntity
            
            // If for any reason app config fails then retry (unlimited)
            if (!success || newAppConfig == nil) {
                
                self?.perform(#selector(AppDelegate.getAppConfig(isAppLaunch:)), with: isAppLaunch, afterDelay: kAppConfigRetryDelayDuration)
                
            } else {
                
                if (newAppConfig?.isAppNeedUpdate)! {
                    
                    self?.performForceUpdate(appConfig: newAppConfig!)
                    
                } else {
                    
                    // If app is already launched and we just received app config upon returning from background
                    if (!isAppLaunch) {
                        
                        // Check if backend tells APIs has changed and app needs to reload
                        if ((self?.appConfig?.appConfigVersion)! < (newAppConfig?.appConfigVersion)! || !(newAppConfig?.isConfigForIosPlatform)!) {
                            
                            self?.performForceReload()
                            
                        } else {
                            
                            // TODO: Disabling config update when app returns from bg. It causes to create new UserManager object while UserContainer and LoginVC will hold reference to previous UserManager object which will perform login and store token. However, new VC will use new UserManager from Registry, which is empty and doesn't have a token
                            // Update config
                            //[weakSelf setAppConfig:newAppConfig];
                        }
                        
                        // Else continue launching app...
                    } else {
                        
                        // Store config
                        self?.setAppConfig(appConfig: newAppConfig!)
                        
                        self?.checkAndOverrideGeneralSettingsLanguageIfNotSupported()
                        
                        // Continue
                        
                        // Check if app runs the very first time
                        if let settingsManager = self?.settingsManager {
                            
                            if (settingsManager.isFirstTimeAppLaunch) {
                                
                                self?.showWalkthrough()
                                
                            } else {
                                
                                self?.continueLaunchTheApp()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 
    // MARK: Internal
    // MARK:
    
    internal func tabBar() -> BaseTabBarController {
        
        let tab0Vc: HomeViewController = viewControllerFactory.homeViewController(context: nil)
        let tab1Vc: MenuViewController = viewControllerFactory.menuViewController(context: nil)

        let tab0NavCtrl: BaseNavigationController = BaseNavigationController.init(rootViewController: tab0Vc)
        let tab1NavCtrl: BaseNavigationController = BaseNavigationController.init(rootViewController: tab1Vc)
        
        let tabBarController: BaseTabBarController = BaseTabBarController()
        
        tabBarController.viewControllers = [tab0NavCtrl, tab1NavCtrl]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : kColorGray], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : kColorBlue], for: UIControlState.selected)
        
        //------ Configure first tab -------//
        let tabBarItem0 = tabBarController.tabBar.items?[0]
        
        var deselectedImage: UIImage = (UIImage(named:"iconTabHomeInactive")?.withRenderingMode(.alwaysOriginal))!
        var selectedImage: UIImage = (UIImage(named:"iconTabHomeActive")?.withRenderingMode(.alwaysOriginal))!
        
        tabBarItem0?.title = localizedString(key: kTabHomeItemTitle)
        tabBarItem0?.image = deselectedImage
        tabBarItem0?.selectedImage = selectedImage
        
        //------ Configure second tab -------//
        let tabBarItem1 = tabBarController.tabBar.items?[1]
        
        deselectedImage = (UIImage(named:"iconTabMenuInactive")?.withRenderingMode(.alwaysOriginal))!
        selectedImage = (UIImage(named:"iconTabMenuActive")?.withRenderingMode(.alwaysOriginal))!
        
        tabBarItem1?.title = localizedString(key: kTabMenuItemTitle)
        tabBarItem1?.image = deselectedImage
        tabBarItem1?.selectedImage = selectedImage
        
        return tabBarController
    }
    
    internal func continueLaunchTheApp() {
        
        //if (self.userManager.isUserLoggedIn()) {
            
            // Or jump straight to the app
            self.proceedToTheApp()
            
        /*} else {
            
            // Show tutorial
            self.showLogin(error: nil)
        }*/
    }
    
    internal func showWalkthrough() {
        
        // Protection: don't show twice
        if (!(self.window?.rootViewController is WalkthroughViewController)) {
            
            let walkthroughVC: WalkthroughViewController = viewControllerFactory.walkthroughViewController(context: nil)
            walkthroughVC.delegate = self
            
            self.window?.rootViewController = walkthroughVC            
        }
    }
    
    internal func showLogin(error: ErrorEntity?) {
        
        // Protection: don't show twice
        if (!(self.window?.rootViewController is UserContainerViewController)) {
            
            let userContainerVc: UserContainerViewController = viewControllerFactory.userContainerViewController(context: nil)
            userContainerVc.delegate_ = self
            
            self.window?.rootViewController = userContainerVc
            
            if let error = error {
                
                self.messageBarManager .showMessage(title: "", description: error.message, type: MessageBarMessageType.error)
            }
        }
    }
    
    internal func proceedToTheApp() {
        
        // set as the root window
        let rootVc: BaseTabBarController = self.tabBar()
        
        self.animateTransitioning(newView: rootVc.view, newRootViewController: rootVc, callback: nil)
    }

    // TODO: temporary
    internal func animateTransitioning(newView: UIView, newRootViewController: UIViewController, callback: Callback?) {
        
        self.window?.rootViewController = newRootViewController
        
        // Override
        /*UIViewAnimationOptions options = UIViewAnimationOptionTransitionCurlUp;//UIViewAnimationOptionTransitionFlipFromTop;//UIViewAnimationOptionTransitionCrossDissolve;
        
        newView.frame = [UIScreen mainScreen].bounds;
        
        UIView *oldView = nil;
        
        if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *oldNavCon = (UINavigationController *)self.window.rootViewController;
            oldView = oldNavCon.topViewController.view;
            
        } else if ([self.window.rootViewController isKindOfClass:[UIViewController class]]) {
            
            oldView = self.window.rootViewController.view;
            
        } else if ([self.window.rootViewController isKindOfClass:[MenuNavigator class]]) {
            
            MenuNavigator *menuNavCon = (MenuNavigator *)self.window.rootViewController;
            UIViewController *centerVC = (UIViewController *)menuNavCon.centerViewController;
            oldView = centerVC.view;
        }
        
        // Perform animation
        __weak typeof(self) weakSelf = self;
        
        [UIView transitionFromView:oldView
            toView:newView
            duration:0.65f
            options:options
            completion:^(BOOL finished) {
            
            weakSelf.window.rootViewController = newRootViewControler;
            
            if (callback) {
            
            callback(YES, nil, nil);
            }
            }];*/

    }
    
    internal func checkAndOverrideGeneralSettingsLanguageIfNotSupported() {
        
        if let language = settingsManager.language {
            
            if (language != ConstLangKeys.langEnglish && language != ConstLangKeys.langGerman){
                
                settingsManager.setLanguageGerman()
            }
            
        } else {
            
            settingsManager.setLanguageGerman()
        }
    }
}

