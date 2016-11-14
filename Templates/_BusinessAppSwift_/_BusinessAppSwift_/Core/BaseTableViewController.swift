//
//  BaseTableViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 06/11/16.
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

class BaseTableViewController: UITableViewController, GenericViewControllerProtocol, GenericDetailsViewControllerProtocol, KeyboardControlDelegate {
    
    var context: Any?
    var viewLoader: ViewLoaderProtocol?
    var crashManager: CrashManagerProtocol?
    var analyticsManager: AnalyticsManagerProtocol?
    var messageBarManager: MessageBarManagerProtocol?
    var viewControllerFactory: ViewControllerFactoryProtocol?
    var reachabilityManager: ReachabilityManagerProtocol?
    var localizationManager: LocalizationManagerProtocol?
    var userManager: UserManagerProtocol?
    
    var keyboardControls: KeyboardControlProtocol?
    
    deinit {
        
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self)
        
        self.reachabilityManager?.removeServiceObserver(observer: self as ReachabilityManagerObserver)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        // Add navigation bar
        if self.isModal() {
            
            let navigatioBar = self.viewLoader?.addDefaultModalNavigationBar(viewController: self)
            navigatioBar?.delegate = self
            
        } else {
            
            let navigatioBar = self.viewLoader?.addDefaultNavigationBar(viewController: self)
            navigatioBar?.delegate = self
        }
        
        // Prepare for functional tests
        self.viewLoader?.prepareAccesibility(viewController: self)
        
        // Add language change observing
        self.localizationManager?.addServiceObserver(observer: self, notificationType: LocalizationManagerNotificationType.didChangeLang, callback: { [weak self] (success, result, context, error) in
            
            DDLogDebug(log: className(object: self) + ": prepareUI")
            self?.prepareUI()
            
            DDLogDebug(log: className(object: self) + ": loadModel")
            self?.loadModel()
            
            }, context: nil)
        
        //Adding environment switch buttons for DEBUG only
        #if DEBUG
            
            //self.addNetworkSwitches()
            
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        DDLogDebug(log: className(object: self) + ": viewWillAppear")
        
        // Enable user interaction
        self.view.isUserInteractionEnabled = true
        
        // Log current screen
        self.crashManager?.logScreenAction(log: className(object: self))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        super.viewWillDisappear(animated)
        
        DDLogDebug(log: className(object: self) + ": viewWillDisappear")
        
        // Disable user interaction
        self.view.isUserInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        DDLogDebug(log: className(object: self) + ": didReceiveMemoryWarning")
    }
    
    // MARK: GenericViewControllerProtocol
    
    func prepareUI() {
        
        // ...
    }
    
    func renderUI() {
        
        // ...
    }
    
    func loadModel() {
        
        self.renderUI()
    }
    
    // MARK: KeyboardControlDelegate
    
    func didPressGo() {
        
        
    }
    
    // MARK: Rotation
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    // This method is needed when we support several orientations but screen looks best for one particular rotation. This is good when need to present screen in specific exceptional orientation. However, in our partical case we don't have and it causes screens to flip upside when app launched in not prefered orientation.
    /*func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
     
     if (isIpad) {
     
     return UIInterfaceOrientation.landscapeLeft
     
     } else if (isIphone) {
     
     return UIInterfaceOrientation.portrait
     }
     }*/
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if (isIpad) {
            
            return [UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.landscapeLeft]
            
        } else if (isIphone) {
            
            return [UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.landscapeLeft]
            
        } else {
            
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    // MARK: ViewControllerModelDelegate
    
    func modelHasChangedWithData(data: Any?, context: Any?) {
        
        // Override
        // ...
    }
    
    func modelHasFailedToChangeDataWithError(error: Error, context: Any?) {
        
        // Override
        // ...
    }
}
