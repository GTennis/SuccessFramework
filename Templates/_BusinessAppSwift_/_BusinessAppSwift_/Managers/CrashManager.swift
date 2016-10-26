//
//  CrashManager.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 18/10/2016.
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
import Fabric
import Crashlytics

let kCrashlyticsAPIKey = "yourKey"
let kCrashlyticsMaxNumberOfActions = 10

enum CrashlyticsError : Error {
    
    case customError
}

// TODO: Add Run Build Script:
// "${PODS_ROOT}/Fabric/run" <FABRIC_API_KEY> <BUILD_SECRET>

class CrashManager: CrashManagerProtocol {

    // MARK: CrashManagerProtocol
    
    init() {
        
        /*#ifdef DEBUG
         
         // Mark the build is made for internal testing (Enterprise build)
         //[[Crashlytics sharedInstance] setIntValue:1 forKey:@"isDebugBuild"];
         
         #else*/
        
        Fabric.with([Crashlytics.self])
        
        //#endif
    }
    
    // CrashManagerProtocol

    // Allows to log any custom action. Stores history
    func logScreenAction(log: String) {
        
        // Remove last item if exceeded max stored action count
        if (_actionsArray.count > kCrashlyticsMaxNumberOfActions) {
            
            // Remove the most old log record
            _actionsArray.remove(at: 0)
        }
        
        // Create new action object
        let logItem: LogEntity = LogEntity.init(message: log)
        
        // Add action object
        _actionsArray.append(logItem)
        
        // Store log
        Crashlytics.sharedInstance().setObjectValue(_actionsArray, forKey: "ControllerNavigationHistory")
    }
    
    func logCustomAction(log: String) {
        
        Crashlytics.sharedInstance().setObjectValue(log, forKey: "lastUsedItem")
    }
    
    func updateUserWith(isLoggedIn: Bool) {
        
        Crashlytics.sharedInstance().setObjectValue(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func updateUserWith(language: String) {
        
        Crashlytics.sharedInstance().setObjectValue(language, forKey: "userLanguage")
    }
    
    func sendNonFatalError(errorMessage: String) {
        
        let userInfo: Dictionary<String, String> = ["ErrorMessage": errorMessage]
        Crashlytics.sharedInstance().recordError(CrashlyticsError.customError, withAdditionalUserInfo: userInfo)
    }
    
    func crash() {
        
        Crashlytics.sharedInstance().crash()
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal lazy var _actionsArray: Array<LogEntity> = Array()
}
