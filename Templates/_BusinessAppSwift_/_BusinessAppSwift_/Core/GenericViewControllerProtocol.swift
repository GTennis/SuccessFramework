//
//  GenericViewControllerProtocol.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 21/10/2016.
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

protocol GenericViewControllerProtocol: class, ReachabilityManagerObserver, LocalizationManagerObserver, TopNavigationBarModalDelegate, TopNavigationBarDelegate, ViewControllerModelDelegate /*: UIGestureRecognizerDelegate <- for network switch */ {
    
    // MARK: Dependencies
    
    var context: Any? {get set}
    var viewLoader: ViewLoaderProtocol? {get set}
    var crashManager: CrashManagerProtocol? {get set}
    var analyticsManager: AnalyticsManagerProtocol? {get set}
    var messageBarManager: MessageBarManagerProtocol? {get set}
    var viewControllerFactory: ViewControllerFactoryProtocol? {get set}
    var reachabilityManager: ReachabilityManagerProtocol? {get set}
    var localizationManager: LocalizationManagerProtocol? {get set}
    var userManager: UserManagerProtocol? {get set}
        
    // MARK: Common module loading flow
    
    func prepareUI()
    func renderUI()
    func loadModel()
        
    // MARK: Logout
    func logoutAndGoBackToAppStart(error: ErrorEntity?)
    
    // MARK: Convenience utils
    func isModal() -> Bool
    func presentModal(viewController:UIViewController, animated: Bool)
    func dismissModalViewController(animated: Bool)
}

extension GenericViewControllerProtocol {
    
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
    
    // MARK: Logout
    
    func logoutAndGoBackToAppStart(error: ErrorEntity?) {
        
        let theError = error
        
        self.userManager?.logout(callback: { (success, result, context, error) in
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showLogin(error: theError)
        })
    }
    
    // MARK: TopModalNavigationBarDelegate
    
    func didPressedCancelModal() {
        
        let vc = self as! UIViewController
        vc.dismiss(animated: true, completion: nil)
    }
    
    func didPressedBackModal() {
        
        let vc = self as! UIViewController
        let topModalNavigationBar: TopNavigationBarModal = vc.navigationItem.titleView as! TopNavigationBarModal
        
        topModalNavigationBar.showCancelButton()
    }
    
    // MARK: TopNavigationBarDelegate
    
    func didPressedContacts() {
        
        let contactVC: UIViewController = (self.viewControllerFactory?.contactViewController(context: nil))!
        
        self.presentModal(viewController:contactVC, animated: true)
    }
    
    internal func didPressedBack() {
        
        let vc = self as! UIViewController
        let navCon: UINavigationController? = vc.navigationController
        
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
