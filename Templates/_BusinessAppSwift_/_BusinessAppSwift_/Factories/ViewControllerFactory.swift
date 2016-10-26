//
//  ViewControllerFactory.swift
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

class ViewControllerFactory: ViewControllerFactoryProtocol {

    func launchViewController(context: Any?)->LaunchViewController {
        
        let vc = viewController(classType: LaunchViewController.self, context: context) as! LaunchViewController
        vc.model = LaunchModel()
        vc.model?.userManager = self.userManager()
        vc.model?.settingsManager = self.settingsManager()
        vc.model?.networkOperationFactory = self.networkOperationFactory()
        vc.model?.reachabilityManager = self.reachabilityManager()
        vc.model?.analyticsManager = self.analyticsManager()
        vc.model?.context = context
        
        return vc
    }
    
    /*func walkthroughViewController(context: Any?)->WalkthroughViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
        
        return vc;
    }*/
    
    func homeViewController(context: Any?)->HomeViewController {
        
        let vc = viewController(classType: HomeViewController.self, context: context) as! HomeViewController
        vc.model = HomeModel()
        vc.model?.userManager = self.userManager()
        vc.model?.settingsManager = self.settingsManager()
        vc.model?.networkOperationFactory = self.networkOperationFactory()
        vc.model?.reachabilityManager = self.reachabilityManager()
        vc.model?.analyticsManager = self.analyticsManager()
        vc.model?.context = context
        
        return vc
    }
    
    func contactViewController(context: Any?)->ContactViewController {
        
        let vc = viewController(classType: LaunchViewController.self, context: context) as! ContactViewController
        vc.model = ContactModel()
        vc.model?.userManager = self.userManager()
        vc.model?.settingsManager = self.settingsManager()
        vc.model?.networkOperationFactory = self.networkOperationFactory()
        vc.model?.reachabilityManager = self.reachabilityManager()
        vc.model?.analyticsManager = self.analyticsManager()
        vc.model?.context = context
        
        return vc
    }
    
    func walkthroughViewController(context: Any?)->WalkthroughViewController {
        
        let vc = viewController(classType: WalkthroughViewController.self, context: context) as! WalkthroughViewController
        vc.model = WalkthroughModel()
        vc.model?.userManager = self.userManager()
        vc.model?.settingsManager = self.settingsManager()
        vc.model?.networkOperationFactory = self.networkOperationFactory()
        vc.model?.reachabilityManager = self.reachabilityManager()
        vc.model?.analyticsManager = self.analyticsManager()
        vc.model?.context = context
        
        return vc
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    internal
    
    func viewController(classType: AnyClass, context: Any?)->UIViewController {
        
        var viewControllerClassName: String = NSStringFromClass(classType);
        
        // Autopick device class
        
        if isIpad {
            
            viewControllerClassName = viewControllerClassName + "_ipad";
            
        } else if isIphone {
            
            viewControllerClassName = viewControllerClassName + "_iphone";
        }
        
        //let deviceClass: AnyClass? = NSClassFromString(viewControllerClassName);
        let deviceClass = NSClassFromString(viewControllerClassName) as! UIViewController.Type

        let viewController: UIViewController = deviceClass.init()
        var genericViewController = viewController as! GenericViewControllerProtocol
        
        genericViewController.genericViewController = GenericViewController.init(viewController: genericViewController as! UIViewController, viewControllerProtocol: genericViewController, context: context, crashManager: self.crashManager(), analyticsManager: self.analyticsManager(), messageBarManager: self.messageBarManager(), viewControllerFactory: self, viewLoader: self.viewLoader(), reachabilityManager: self.reachabilityManager(), localizationManager: self.localizationManager(), userManager: self.userManager())
        
        // Injecting all dependencies
        //self.injectDependencies(viewController: &genericViewController);
        
        return viewController
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var vc = segue.destination as! GenericViewControllerProtocol;
        self.injectDependencies(viewController: &vc);
        
        //if (segue.identifier == "Load View") {
        // pass data to next view
        //}
    }*/
    
    /*func injectDependencies(viewController: inout GenericViewControllerProtocol){
        
        viewController.genericViewController?.userManager = self.userManager()
        viewController.genericViewController?.viewManager = self.viewManager()
        viewController.genericViewController?.crashManager = self.crashManager()
        viewController.genericViewController?.analyticsManager = self.analyticsManager()
        viewController.genericViewController?.messageBarManager = self.messageBarManager()
        viewController.genericViewController?.reachabilityManager = self.reachabilityManager()
    }*/
    
    // Every view controller should have its own viewManager because it will store references to the view controller and its views (Except ViewManager)
    
    func viewLoader()->ViewLoader {
        
        let loader: ViewLoader = ViewLoader()
        return loader
    }
    
    func userManager()->UserManager {
    
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.userManager as! UserManager
    }
    
    func keychainManager()->KeychainManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.keychainManager as! KeychainManager
    }
    
    func settingsManager()->SettingsManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.settingsManager as! SettingsManager
    }
    
    func crashManager()->CrashManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.crashManager as! CrashManager
    }
    
    func analyticsManager()->AnalyticsManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.analyticsManager as! AnalyticsManager
    }
    
    func messageBarManager()->MessageBarManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.messageBarManager as! MessageBarManager
    }
    
    func reachabilityManager()->ReachabilityManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.reachabilityManager as! ReachabilityManager
    }
    
    func networkOperationFactory()->NetworkOperationFactory {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.networkOperationFactory as! NetworkOperationFactory
    }
    
    func localizationManager()->LocalizationManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.localizationManager as! LocalizationManager
    }
}
