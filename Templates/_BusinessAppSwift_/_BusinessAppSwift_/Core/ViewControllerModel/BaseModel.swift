//
//  BaseModel.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 21/10/16.
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

let networkEnvironmentChangeNotification = Notification.Name("NetworkEnvironmentChangeNotification")

class BaseModel: ViewControllerModelProtocol {

    // Dependencies
    var userManager: UserManagerProtocol!
    var settingsManager: SettingsManagerProtocol!
    var networkOperationFactory: NetworkOperationFactoryProtocol!
    var reachabilityManager: ReachabilityManagerProtocol!
    var analyticsManager: AnalyticsManagerProtocol!
    
    var context: Any?
    
    var isLoaded: Bool {
        
        get {
            
            return _isLoaded
        }
    }
    
    var delegate: ViewControllerModelDelegate?

    func commonInit() {
        
        // ...
    }
    
    func loadData(callback: @escaping Callback) {
        
        let wrappedCallback: Callback = { [weak self] (_ success: Bool, _ result: Any?, _ context: Any?, _ error: ErrorEntity?) -> Void in
            
            if (success) {
                
                self?._isLoaded = true
                
            } else {
                
                self?._isLoaded = false
            }
            
            var message = className(object: self!) + ": didFinishModelLoading"
            if let error = error {
                
                message = message + " error: " + error.message
            }
            DDLogDebug(log: message)
            
            self?.didFinishModelLoading(data: result, error: error)
            
            callback(success, result, context, error);
        }
        
        DDLogDebug(log: className(object: self) + ": willStartModelLoading")
        
        self.willStartModelLoading(callback: wrappedCallback)
    }
    
    deinit {
        
        DDLogDebug(log: className(object: self) + ": dealloc")
        
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    required init() {
        
        #if DEBUG
        
            let notificationCenter: NotificationCenter = NotificationCenter.default
            
            notificationCenter.addObserver(forName: networkEnvironmentChangeNotification, object: nil, queue: nil, using: { [weak self] (notification) in
                
                if let callback = self?._callback {
                    
                    self?.loadData(callback: callback)
                }
            })
        
        #endif
    }
    
    // MARK: ViewControllerModelProtocol
    
    func willStartModelLoading(callback: @escaping Callback) {
        
        fatalError("willStartModelLoading is not implemented in class: " + className(object: self))
    }
    
    func didFinishModelLoading(data: Any?, error: ErrorEntity?) {
        
        fatalError("didFinishModelLoading is not implemented in class: " + className(object: self))
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _callback: Callback?
    internal var _isLoaded: Bool = false
}
