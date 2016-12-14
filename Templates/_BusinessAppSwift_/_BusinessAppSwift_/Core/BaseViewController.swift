//
//  BaseViewController.swift
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

class BaseViewController: UIViewController, GenericViewControllerProtocol {

    var context: Any?
    var viewLoader: ViewLoaderProtocol?
    var crashManager: CrashManagerProtocol?
    var analyticsManager: AnalyticsManagerProtocol?
    var messageBarManager: MessageBarManagerProtocol?
    var viewControllerFactory: ViewControllerFactoryProtocol?
    var reachabilityManager: ReachabilityManagerProtocol?
    var localizationManager: LocalizationManagerProtocol?
    var userManager: UserManagerProtocol?
    
    deinit {
        
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self)
        
        self.reachabilityManager?.removeServiceObserver(observer: self as ReachabilityManagerObserver)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
