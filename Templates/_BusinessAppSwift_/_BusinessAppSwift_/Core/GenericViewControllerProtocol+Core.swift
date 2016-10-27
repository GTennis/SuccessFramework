//
//  GenericViewControllerProtocol+Core.swift
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

extension GenericViewControllerProtocol {
    
    // Override in subclasses to use functionality
    var refreshControl: GMRefreshControl? {
        
        get {
            
            return nil
        }
        set {
            //...
        }
    }
    
    // Override in subclasses to use functionality
    weak var modalContainerView4Ipad: UIView? {
        
        get {
            
            return nil
        }
        set {
            //...
        }
    }
    
    // TODO: Not ported: but actually could be added manually on every ipad vc, not a big problem. This way outlets are explicitly declared in each vc, and not hidden somewhere
    // @property (nonatomic, strong) IBOutlet UIView *modalContainerView; <-- for ipad containerView centered as iphoneView
    
    func className()->String {
        
        let className = "\(type(of: self))"
        
        return className
    }
    
    // MARK: Modal screen handling
    
    func isModal() -> Bool {
        
        let vc = self as! UIViewController
        
        if vc.presentingViewController != nil {
            
            return true
            
        } else if vc.navigationController?.presentingViewController?.presentedViewController == vc.navigationController  {
            
            return true
            
        } else if vc.tabBarController?.presentingViewController is UITabBarController {
            
            return true
        }
        
        return false
    }
    
    func presentModal(viewController:UIViewController, animated: Bool) {
        
        let vc = self as! UIViewController
        var navController: UINavigationController
        
        if (viewController is UINavigationController) {
            
            navController = viewController as! UINavigationController
            
        } else {
            
            navController = UINavigationController.init(rootViewController: viewController)
        }
        
        if (isIpad /*&& (genericViewController?.shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad)!*/) {
            
            navController.navigationBar.isHidden = true;
        }
        
        navController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        if (self.isModal()) {
            
            vc.present(navController, animated: animated, completion: {
                //...
            })
            
        } else {
            
            // For TabBar application
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(navController, animated: animated, completion: {
                //...
            })
        }
    }
    
    func dismissModalViewController(animated: Bool) {
        
        let vc = self as! UIViewController
        vc.presentingViewController?.dismiss(animated: animated, completion: {
            //...
        })
    }
    
    // MARK: Progress indicators
    
    func showScreenActivityIndicator() {
        
        let vc = self as! UIViewController
        self.viewLoader?.showScreenActivityIndicator(containerView: vc.view)
    }
    
    func hideScreenActivityIndicator() {
        
        let vc = self as! UIViewController
        self.viewLoader?.hideScreenActivityIndicator(containerView: vc.view)
    }
    
    // MARK: Xib loading
    
    func loadViewFromXib(classType: AnyClass) -> UIView? {
        
        let view: UIView? = self.viewLoader?.loadViewFromXib(classType: classType)
        
        return view
    }
    
    // MARK: Navigation handling
    
    func showNavigationBar() {
        
        let vc = self as! UIViewController
        vc.navigationController?.navigationBar.isTranslucent = false
        vc.navigationController?.isNavigationBarHidden = false
    }
    
    func hideNavigationBar() {
        
        let vc = self as! UIViewController
        vc.navigationController?.navigationBar.isTranslucent = true
        vc.navigationController?.isNavigationBarHidden = true
    }
    
    func hasNavigationBar() -> Bool {
        
        let vc = self as! UIViewController
        let isHidden = vc.navigationController?.isNavigationBarHidden
        
        return !isHidden!
    }
    
    // MARK: Screen title
    func setTitle(title: String) {
        
        let vc = self as! UIViewController
        
        vc.title = title
        vc.navigationItem.title = title;
        
        // Setting title for top main or modal navigation bar
        let navigationBar: BaseNavigationBar = vc.navigationItem.titleView as! BaseNavigationBar
        navigationBar.titleLabel?.text = title;
    }
    
    // MARK: Logout
    
    func logoutAndGoBackToAppStart(error: ErrorEntity) {
        
        let theError = error
        
        self.userManager?.logout(callback: { (success, result, context, error) in
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showWalkthrough(error: theError)
        })
    }
    
    // MARK: Observing
    func removeFromAllFromObserving() {
        
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self)
        
        self.reachabilityManager?.removeServiceObserver(observer: self as ReachabilityManagerObserver)
    }
    
    // MARK: Refresh control
    // TODO: Refactor: refresh control should be added transparently internally on the whole scroll/table/collection view with greyed full width/height inside container
    // Also, this needs to go into BaseDetailsViewController
    // But, it makes sense to split BaseDetailsViewController into 2: BaseListViewController (for scroll/) and for details (scroll) but hmm.... need to think
    func addRefreshControl(containerView: UIView) {
        
        if (self.refreshControl == nil) {
            
            self.refreshControl = GMRefreshControl.init(callback: {
                
                self.loadModel()
            })
            
            if let refreshControl = self.refreshControl {
                
                containerView.addSubview(refreshControl.view)
            }
        }
    }
    
    func loadModel() {
        
        // ...
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
    
        let vc = self as! UIViewController
        vc.dismiss(animated: true, completion: nil)
    }
    
    internal func didPressedBackModal() {
        
        let vc = self as! UIViewController
        let topModalNavigationBar: TopNavigationBarModal = vc.navigationItem.titleView as! TopNavigationBarModal
        
        topModalNavigationBar.showCancelButton()
    }
    
    // MARK: TopNavigationBarDelegate
    
    internal func didPressedContacts() {
        
        let vc = self as! UIViewController
        let contactVC: UIViewController = (self.viewControllerFactory?.contactViewController(context: nil))!
        
        vc.present(contactVC, animated: true, completion: nil)
    }
    
    internal func didPressedBack() {
        
        let vc = self as! UIViewController
        let navCon: UINavigationController? = vc.navigationController
        
        if let navCon = navCon {
            
            navCon.popViewController(animated: true)
        }
    }
    
    // MARK:
    func commonViewDidLoad() {
        
        if (self.isModal()) {
            
            self.addCustomModalNavigationBar()
            
        } else {
            
            self.addCustomNavigationBar()
        }
        
        viewLoader?.prepareAccesibility(viewController: self as! UIViewController)
        
        self.localizationManager?.addServiceObserver(observer: self, notificationType: LocalizationManagerNotificationType.didChangeLang, callback: { [weak self] (success, result, context, error) in
            
            DDLogDebug(log: (self?.className())! + ": prepareUI")
            self?.prepareUI()
            
            DDLogDebug(log: (self?.className())! + ": loadModel")
            self?.loadModel()
            
            }, context: nil)
        
        
        //Adding environment switch buttons for DEBUG only
        #if DEBUG
            
            //self.addNetworkSwitches()
            
        #endif
    }
    
    func commonViewWillAppear(_ animated: Bool) {
     
        DDLogDebug(log: self.className() + ": viewWillAppear")
        
        // Enable user interaction
        (self as! UIViewController).view.isUserInteractionEnabled = true
        
        // Log current screen
        self.crashManager?.logScreenAction(log: self.className())
        
        // Listen for notifications
        //self.subcribeForGeneralNotifications()
    }
    
    func commonViewWillDisappear(_ animated: Bool) {
        
        DDLogDebug(log: self.className() + ": viewWillDisappear")
        
        // Disable user interaction
        (self as! UIViewController).view.isUserInteractionEnabled = false
        
        // Stop listening for notifications
        //self.unsubcribeFromGeneralNotifications()
    }
    
    func commonDidReceiveMemoryWarning() {

        DDLogDebug(log: self.className() + ": didReceiveMemoryWarning")
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
    
    // MARK: navigation bars
    
    internal func addCustomNavigationBar() {
        
        let vc = self as! UIViewController
        
        // No need to add navCtrl for screens without nagivation (for example menuVC)
        
        if (vc.navigationController == nil) {
            
            return;
        }
        
        // Creating and adding custom navigation bar
        let navigationBar: TopNavigationBar? = self.loadViewFromXib(classType: TopNavigationBar.self) as! TopNavigationBar?
        
        if navigationBar == nil {
            
            return
        }
        
        navigationBar!.delegate = self
        
        // Add navigation bar style
        // Could be applied blogaly in AppDelegate didFinish launch
        // UINavigationBar.appearance().isTranslucent = true
        vc.navigationController?.navigationBar.isTranslucent = true
        
        vc.navigationItem.titleView = navigationBar!
        
        // Hides default 1px gray bottom separator line
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        
        // This is a work around to get rid of ellipsis when navigating back
        // Taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        
        // Hide back button if it's root view controller
        if ((vc.navigationController?.viewControllers.count)! > 1) {
            
            navigationBar!.showBackButton()
            
        } else {
            
            //[navigationBar showMenuButton];
        }
    }
    
    internal func addCustomModalNavigationBar() {
        
        let vc = self as! UIViewController
        
        // Creating and adding custom navigation bar
        let navigationBar: TopNavigationBarModal? = self.loadViewFromXib(classType: TopNavigationBarModal.self) as! TopNavigationBarModal?
        
        if navigationBar == nil {
            
            return
        }
        
        navigationBar!.delegate = self;
        
        // Add navigation bar style
        vc.navigationController?.navigationBar.isTranslucent = false
        
        if (/*self.shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad && */isIpad) {
            
            // Add separator line
            navigationBar!.showHoritontalSeparatorLineView()
            
            // Add view and constraints
            self.modalContainerView4Ipad?.addSubview(navigationBar!)
            navigationBar!.viewAddLeadingSpace(0, containerView: self.modalContainerView4Ipad!)
            navigationBar!.viewAddTrailingSpace(0, containerView: self.modalContainerView4Ipad!)
            navigationBar!.viewAddBottomSpace(0, containerView: self.modalContainerView4Ipad!)
            
        } else {
            
            // This will add navigation bar onto navigation controller's bar
            vc.navigationItem.titleView = navigationBar;
            // this is a work around to get rid of ellipsis when navigating back
            // taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        }
        
        // Show cancel by default
        navigationBar!.showCancelButton()
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
