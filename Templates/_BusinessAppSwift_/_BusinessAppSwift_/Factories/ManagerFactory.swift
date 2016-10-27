//
//  ManagerFactory.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 31/10/2016.
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

class ManagerFactory: ManagerFactoryProtocol {

    // MARK: ManagerFactoryProtocol
    
    static func shared() -> ManagerFactoryProtocol {
        
        return _shared
    }
    
    var userManager: UserManagerProtocol {
        
        get {
            
            return self._userManager
        }
    }
    
    var keychainManager: KeychainManagerProtocol {
        
        get {
            
            return self._keychainManager
        }
    }
    
    var settingsManager: SettingsManagerProtocol {
        
        get {
            
            return self._settingsManager
        }
    }
    
    var crashManager: CrashManagerProtocol {
        
        get {
            
            return self._crashManager
        }
    }

    var analyticsManager: AnalyticsManagerProtocol {
        
        get {
            
            return self._analyticsManager
        }
    }
    
    var messageBarManager: MessageBarManagerProtocol {
        
        get {
            
            return self._messageBarManager
        }
    }
    
    var reachabilityManager: ReachabilityManagerProtocol {
        
        get {
            
            return self._reachabilityManager
        }
    }
    
    var networkOperationFactory: NetworkOperationFactoryProtocol {
        
        get {
            
            return self._networkOperationFactory
        }
    }
    
    var localizationManager: LocalizationManagerProtocol {
        
        get {
            
            return self._localizationManager
        }
    }
    
    var logManager: LogManagerProtocol {
        
        get {
            
            return self._logManager
        }
    }
    
    var pushNotificationManager: PushNotificationManagerProtocol {
        
        get {
            
            return self._pushNotificationManager
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal static let _shared: ManagerFactoryProtocol = ManagerFactory()
    
    internal lazy var _reachabilityManager: ReachabilityManagerProtocol = ReachabilityManager()
    internal lazy var _crashManager: CrashManagerProtocol = CrashManager()
    internal lazy var _analyticsManager: AnalyticsManagerProtocol = AnalyticsManager()
    internal lazy var _messageBarManager: MessageBarManagerProtocol = MessageBarManager()    
    internal lazy var _keychainManager: KeychainManagerProtocol = KeychainManager()
    internal lazy var _pushNotificationManager: PushNotificationManagerProtocol = PushNotificationManager()
    internal lazy var _logManager: LogManagerProtocol = LogManager()
    internal lazy var _userManager: UserManagerProtocol = {
        
        self._networkOperationFactory = NetworkOperationFactory.init(appConfig: nil, settingsManager: self._settingsManager)
        let userManager: UserManagerProtocol = UserManager.init(settingsManager: self._settingsManager, networkOperationFactory: self._networkOperationFactory!, analyticsManager: self._analyticsManager, keychainManager: self._keychainManager)
        self._networkOperationFactory.userManager = userManager
        
        return userManager
    }()
    internal lazy var _settingsManager: SettingsManagerProtocol = {
        
        let settingsManager = SettingsManager.init(localizationManager: self._localizationManager)
        
        return settingsManager
    }()
    internal var _networkOperationFactory: NetworkOperationFactoryProtocol!
    internal lazy var _localizationManager: LocalizationManagerProtocol = {
        
        return LocalizationManager()
    }()
}
