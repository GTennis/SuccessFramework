//
//  SettingsViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 03/11/2016.
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

class SettingsViewController: UIViewController, GenericViewControllerProtocol {

    var context: Any?
    var viewLoader: ViewLoaderProtocol?
    var crashManager: CrashManagerProtocol?
    var analyticsManager: AnalyticsManagerProtocol?
    var messageBarManager: MessageBarManagerProtocol?
    var viewControllerFactory: ViewControllerFactoryProtocol?
    var reachabilityManager: ReachabilityManagerProtocol?
    var localizationManager: LocalizationManagerProtocol?
    var userManager: UserManagerProtocol?
    @IBOutlet weak var modalContainerView4Ipad: UIView?
    
    var model: SettingsModel?
    
    deinit {
        
        self.removeFromAllFromObserving()
    }
    
    /*required init() {
     
     super.init(nibName: nil, bundle: nil);
     }
     
     required init(coder aDecoder: NSCoder) {
     
     super.init(coder: aDecoder)!
     }*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.commonViewDidLoad()
        
        self.prepareUI()
        self.loadModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.commonViewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.commonViewWillDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        self.commonDidReceiveMemoryWarning()
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
}
