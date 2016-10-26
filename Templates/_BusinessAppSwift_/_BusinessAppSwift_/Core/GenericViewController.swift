//
//  GenericViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 26/10/2016.
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

class GenericViewController: ReachabilityManagerObserver, LocalizationManagerObserver, TopNavigationBarModalDelegate, TopNavigationBarDelegate/*: ViewControllerModelDelegate, UIGestureRecognizerDelegate <- for network switch */ {
    
    var viewLoader: ViewLoaderProtocol?
    var viewController: UIViewController
    var viewControllerProtocol: GenericViewControllerProtocol
    var context: Any?
    var crashManager: CrashManagerProtocol?
    var analyticsManager: AnalyticsManagerProtocol?
    var messageBarManager: MessageBarManagerProtocol?
    var viewControllerFactory: ViewControllerFactoryProtocol?
    var reachabilityManager: ReachabilityManagerProtocol?
    var localizationManager: LocalizationManagerProtocol?
    var userManager: UserManagerProtocol?
    
    // iPad related setting
    var shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad: Bool
    
    deinit {
        
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self)
        
        self.reachabilityManager?.removeServiceObserver(observer: self)
    }
    
    // Dependency injection
    init(viewController: UIViewController, viewControllerProtocol: GenericViewControllerProtocol, context: Any?, crashManager: CrashManagerProtocol, analyticsManager: AnalyticsManagerProtocol, messageBarManager: MessageBarManagerProtocol, viewControllerFactory: ViewControllerFactoryProtocol, viewLoader: ViewLoaderProtocol, reachabilityManager: ReachabilityManagerProtocol, localizationManager: LocalizationManagerProtocol, userManager: UserManagerProtocol) {
        
        self.viewController = viewController //as! UIViewControllerAndGenericViewControllerProtocol
        self.viewControllerProtocol = viewControllerProtocol
        self.context = context
        self.crashManager = crashManager
        self.analyticsManager = analyticsManager
        self.messageBarManager = messageBarManager
        self.viewControllerFactory = viewControllerFactory
        self.reachabilityManager = reachabilityManager
        self.localizationManager = localizationManager
        self.userManager = userManager
        
        self.viewLoader = viewLoader
        
        // iPad related setting
        shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad = true
    }
    
    // MARK: UIVIewController
    
    func viewDidLoad() {
        
        // TODO: not calling after second on/off switch
        self.reachabilityManager?.addServiceObserver(observer: self, notificationType: ReachabilityManagerNotificationType.internetDidBecomeOn, callback: { [weak self] (success, result, context, error) in
            
            // Check for error and only handle once, inside last screen
            if (self?.viewController.navigationController?.viewControllers.last == self?.viewController) {
                
                self?.viewLoader?.hideNoInternetConnectionLabel(containerView: (self?.viewController.view)!)
            }
            }, context: nil)
        
        self.reachabilityManager?.addServiceObserver(observer: self
            , notificationType: ReachabilityManagerNotificationType.internetDidBecomeOff, callback: { [weak self] (success, result, context, error) in
                
                self?.viewLoader?.showNoInternetConnectionLabel(containerView: (self?.viewController.view)!)
                
            }, context: nil)
        
        // Subscribe and handle network errors
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: NetworkRequestError.notification, object: self, queue: nil) { [weak self] (notification) in
            
            if let info = notification.userInfo as? Dictionary<String,Error> {
                
                let error: ErrorEntity? = info[NetworkRequestError.notificationUserInfoErrorKey] as? ErrorEntity
                
                if let error = error {
                    
                    // Check for error and only handle once, inside last screen
                    if (self?.viewController.navigationController?.viewControllers.last == self?.viewController) {
                        
                        if (error.code == NetworkRequestError.unauthorized.code) {
                            
                            // Go to start
                            self?.logoutAndGoBackToAppStart(error: error)
                            
                        } else {
                            
                            self?.messageBarManager?.showMessage(title: " ", description: error.message, type: MessageBarMessageType.error, duration: kMessageBarManagerMessageDuration)
                        }
                    }
                }
            }
        }
        
        
        if (viewControllerProtocol.isModal()) {
            
            self.addCustomModalNavigationBar()
            
        } else {
            
            self.addCustomNavigationBar()
        }
        
        viewLoader?.prepareAccesibility(viewController: viewController)
        
        self.localizationManager?.addServiceObserver(observer: self, notificationType: LocalizationManagerNotificationType.didChangeLang, callback: { [weak self] (success, result, context, error) in
            
            self?.prepareUI()
            self?.loadModel()
            
            }, context: nil)
        
        
        //Adding environment switch buttons for DEBUG only
        #if DEBUG
            
            //self.addNetworkSwitches()
            
        #endif
    }
    
    func viewWillAppear(_ animated: Bool) {
        
        DDLogDebug(log: self.viewControllerProtocol.className() + ": viewWillAppear")
        
        // Enable user interaction
        self.viewController.view.isUserInteractionEnabled = true
        
        // Log current screen
        self.crashManager?.logScreenAction(log: self.viewControllerProtocol.className())
        
        // Listen for notifications
        //self.subcribeForGeneralNotifications()
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
        DDLogDebug(log: self.viewControllerProtocol.className() + ": viewWillDisappear")
        
        // Disable user interaction
        self.viewController.view.isUserInteractionEnabled = false
        
        // Stop listening for notifications
        //self.unsubcribeFromGeneralNotifications()
    }
    
    func didReceiveMemoryWarning() {
        
        DDLogDebug(log: self.viewControllerProtocol.className() + ": didReceiveMemoryWarning")
    }
    
    // MARK: Rotation
    
    func shouldAutorotate()->Bool {
        
        return true
    }
    
    // This method is needed when we support several orientations but screen looks best for one particular rotation. This is good when need to present screen in specific exceptional orientation. However, in our partical case we don't have and it causes screens to flip upside when app launched in not prefered orientation.
    /*func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
     
     if (isIpad) {
     
     return UIInterfaceOrientation.landscapeLeft
     
     } else if (isIphone) {
     
     return UIInterfaceOrientation.portrait
     }
     }*/
    
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        if (isIpad) {
            
            return [UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.landscapeLeft]
            
        } else if (isIphone) {
            
            return [UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.landscapeLeft]
            
        } else {
            
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _refreshControl: UIRefreshControl?
    
    // MARK: Common functionality
    
    /*func commonInit() {
     
     // ...
     }*/
    
    internal func prepareUI() {
        
        DDLogDebug(log: self.viewControllerProtocol.className() + ": prepareUI")
        
        self.viewControllerProtocol.prepareUI()
    }
    
    internal func renderUI() {
        
        DDLogDebug(log: self.viewControllerProtocol.className() + ": renderUI")
    }
    
    @objc func loadModel() {
        
        DDLogDebug(log: self.viewControllerProtocol.className() + ": loadModel")
        
        self.viewControllerProtocol.loadModel()
    }
    
    // MARK: navigation bars
    
    internal func addCustomNavigationBar() {
        
        // No need to add navCtrl for screens without nagivation (for example menuVC)
        
        if (self.viewController.navigationController == nil) {
            
            return;
        }
        
        // Creating and adding custom navigation bar
        let navigationBar: TopNavigationBar? = self.viewControllerProtocol.loadViewFromXib(classType: TopNavigationBar.self) as! TopNavigationBar?
        
        if navigationBar == nil {
            
            return
        }
        
        navigationBar!.delegate = self
        
        // Add navigation bar style
        // Could be applied blogaly in AppDelegate didFinish launch
        // UINavigationBar.appearance().isTranslucent = true
        self.viewController.navigationController?.navigationBar.isTranslucent = true
        
        self.viewController.navigationItem.titleView = navigationBar!
        
        // Hides default 1px gray bottom separator line
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        
        // This is a work around to get rid of ellipsis when navigating back
        // Taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
        self.viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        
        // Hide back button if it's root view controller
        if ((self.viewController.navigationController?.viewControllers.count)! > 1) {
            
            navigationBar!.showBackButton()
            
        } else {
            
            //[navigationBar showMenuButton];
        }
        
    }
    
    internal func addCustomModalNavigationBar() {
        
        // Creating and adding custom navigation bar
        let navigationBar: TopNavigationBarModal? = self.viewControllerProtocol.loadViewFromXib(classType: TopNavigationBarModal.self) as! TopNavigationBarModal?
        
        if navigationBar == nil {
            
            return
        }
        
        navigationBar!.delegate = self;
        
        // Add navigation bar style
        self.viewController.navigationController?.navigationBar.isTranslucent = false
        
        if (self.shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad && isIpad) {
            
            // Add separator line
            navigationBar!.showHoritontalSeparatorLineView()
            
            // Add view and constraints
            self.viewControllerProtocol.modalContainerView4Ipad?.addSubview(navigationBar!)
            navigationBar!.viewAddLeadingSpace(0, containerView: self.viewControllerProtocol.modalContainerView4Ipad!)
            navigationBar!.viewAddTrailingSpace(0, containerView: self.viewControllerProtocol.modalContainerView4Ipad!)
            navigationBar!.viewAddBottomSpace(0, containerView: self.viewControllerProtocol.modalContainerView4Ipad!)
            
        } else {
            
            // This will add navigation bar onto navigation controller's bar
            self.viewController.navigationItem.titleView = navigationBar;
            // this is a work around to get rid of ellipsis when navigating back
            // taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
            self.viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        }
        
        // Show cancel by default
        navigationBar!.showCancelButton()
    }
    
    internal func logoutAndGoBackToAppStart(error: ErrorEntity) {
        
        let theError = error
        
        self.userManager?.logout(callback: { (success, result, context, error) in
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showWalkthrough(error: theError)
        })
    }
    
    // MARK: Refresh control
    // TODO: Refactor: refresh control should be added transparently internally on the whole scroll/table/collection view with greyed full width/height inside container
    // Also, this needs to go into BaseDetailsViewController
    // But, it makes sense to split BaseDetailsViewController into 2: BaseListViewController (for scroll/) and for details (scroll) but hmm.... need to think
    internal func addRefreshControl(containerView: UIView, callback: Callback) {
        
        if (_refreshControl == nil) {
            
            _refreshControl = UIRefreshControl()
            _refreshControl?.addTarget(self, action: #selector(loadModel), for: UIControlEvents.valueChanged)
            containerView.addSubview(_refreshControl!)
        }
    }
    
    // MARK: Empty list label
    
    internal func addEmptyListLabel(containerView: UIView, message: String, callback: @escaping Callback) {
        
        self.viewLoader?.addEmptyListLabel(containerView: containerView, message: message, refreshCallback: callback)
    }
    
    internal func removeEmptyListLabelIfWasAddedBeforeOnView(containerView: UIView) {
        
        self.viewLoader?.removeEmptyListLabelIfWasAddedBefore(containerView: containerView)
    }
    
    // MARK: TopModalNavigationBarDelegate
    
    internal func didPressedCancelModal() {
        
        self.viewControllerProtocol.dismiss(animated: true, completion: nil)
    }
    
    internal func didPressedBackModal() {
        
        let topModalNavigationBar: TopNavigationBarModal = self.viewController.navigationItem.titleView as! TopNavigationBarModal
        
        topModalNavigationBar.showCancelButton()
    }
    
    // MARK: TopNavigationBarDelegate
    
    internal func didPressedContacts() {
        
        let vc: UIViewController = (self.viewControllerFactory?.contactViewController(context: nil))!
        
        self.viewControllerProtocol.present(vc, animated: true, completion: nil)
    }
    
    internal func didPressedBack() {
        
        let navCon: UINavigationController? = self.viewController.navigationController
        
        if let navCon = navCon {
            
            navCon.popViewController(animated: true)
        }
    }
    
    #if DEBUG
    
    /*
     
     NetworkEnvironmentSwitch4Testing *_networkSwitch4Testing;
     UITapGestureRecognizer *_networkChangeGestureRecognizer;
     BOOL _isVisibleDebugNetworkEnvironmentSwich;
     
     ConsoleLogViewController *_consoleLoggerVC;
     UILongPressGestureRecognizer *_consoleLoggerGestureRecognizer;
     BOOL _isVisibleConsoleLogger;
     
     - (void)addNetworkSwitches {
     
     // Add network change switch
     _networkSwitch4Testing = [[NetworkEnvironmentSwitch4Testing alloc] init];
     _networkSwitch4Testing.delegate = (id<NetworkEnvironmentSwitch4TestingDelegate>) self;
     //_networkChangeGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNetworkChangeSwitch)];
     //_networkChangeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
     //_networkChangeGestureRecognizer.numberOfTapsRequired = 3;
     
     //[self.navigationItem.titleView addGestureRecognizer:_networkChangeGestureRecognizer];
     
     UIButton *networkChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
     networkChangeButton.frame = CGRectMake(54, 5, 40, 30);
     networkChangeButton.backgroundColor = [UIColor grayColor]; //[UIColor greenColor];
     [networkChangeButton setTitle:@"Env" forState:UIControlStateNormal];
     [networkChangeButton addTarget:self action:@selector(handleNetworkChangeSwitch) forControlEvents:UIControlEventTouchUpInside];
     [self.navigationItem.titleView addSubview:networkChangeButton];
     
     // Add console log
     //_consoleLoggerGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleConsoleLog:)];
     //_consoleLoggerGestureRecognizer.minimumPressDuration = 0.5f;
     //_consoleLoggerGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
     //[self.navigationItem.titleView addGestureRecognizer:_consoleLoggerGestureRecognizer];
     
     UIButton *consoleLoggerButton = [UIButton buttonWithType:UIButtonTypeCustom];
     consoleLoggerButton.frame = CGRectMake(95, 5, 40, 30);
     consoleLoggerButton.backgroundColor = [UIColor grayColor]; //[UIColor magentaColor];
     [consoleLoggerButton setTitle:@"Log" forState:UIControlStateNormal];
     [consoleLoggerButton addTarget:self action:@selector(handleConsoleLog:) forControlEvents:UIControlEventTouchUpInside];
     [self.navigationItem.titleView addSubview:consoleLoggerButton];
     }
     
     - (void)handleNetworkChangeSwitch {
     
     if (!_isVisibleDebugNetworkEnvironmentSwich) {
     
     [_networkSwitch4Testing addNetworkEnvironmentChangeButtonsInsideView:self.view];
     
     _isVisibleDebugNetworkEnvironmentSwich = YES;
     
     } else {
     
     [_networkSwitch4Testing removeNetworkEnvironmentChangeButtons];
     
     _isVisibleDebugNetworkEnvironmentSwich = NO;
     }
     }
     
     - (void)didChangeNetworkEnvironment {
     
     [self loadModel];
     }
     
     - (void)handleConsoleLog:(UILongPressGestureRecognizer*)sender {
     
     //if (sender.state != UIGestureRecognizerStateEnded) {
     
     //return;
     //}
     
     if (!_isVisibleConsoleLogger) {
     
     _consoleLoggerVC = [self.viewControllerFactory consoleLogViewControllerWithContext:nil];
     _consoleLoggerVC.view.frame = self.view.bounds;
     
     [self.view addSubview:_consoleLoggerVC.view];
     
     // Need to showing alert/email sending
     [self addChildViewController:_consoleLoggerVC];
     [_consoleLoggerVC didMoveToParentViewController:self];
     
     _isVisibleConsoleLogger = YES;
     
     } else {
     
     [_consoleLoggerVC.view removeFromSuperview];
     [_consoleLoggerVC removeFromParentViewController];
     _consoleLoggerVC = nil;
     
     _isVisibleConsoleLogger = NO;
     }
     }*/
    
    #endif
}
