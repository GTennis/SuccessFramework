//
//  SettingsManager.swift
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

// Settings group key
let kSettingsGroupKey = "Settings"

// First time app launch
let kSettingsFirstTimeAppLaunch = "FirstTimeAppLaunch"

// User
let kSettingsLoggedInUser = "LoggedInUser"

class SettingsManager: SettingsManagerProtocol {

    required init(localizationManager: LocalizationManagerProtocol) {
        
        self._localizationManager = localizationManager
        self.setDefaultLanguage()
    }
    
    // MARK: SettingsManagerProtocol
    
    var isFirstTimeAppLaunch: Bool {
     
        set {
         
            self.set(value: newValue, key: kSettingsFirstTimeAppLaunch)
        }
        get {
            
            let isFirstTimeLaunch: Bool? = self.value(key: kSettingsFirstTimeAppLaunch, defaultValueIfNotExists: nil) as! Bool?
            
            // If it's the first launch then there will be no such settings saved in preferences OR it might be resetted from code later (so value is set to YES)
            if (isFirstTimeLaunch == nil || isFirstTimeLaunch == true) {
                
                return true
                
            } else {
                
                return false
            }
        }
    }
    
    // User
    var loggedInUser: Dictionary <String, AnyObject>? {
     
        set {
            
            self.set(value: newValue, key: kSettingsLoggedInUser)
        }
        get {
            
            let user: Dictionary<String, Any>? = self.value(key: kSettingsLoggedInUser, defaultValueIfNotExists: nil) as! Dictionary<String, Any>?
            
            return user as Dictionary<String, AnyObject>?
        }
    }
    
    // Languages
    var language: String? {
        
        get {
            
            return nil;
        }
    }
    var languageFullName: String? {
     
        get {
            
            return self._localizationManager.getFullLanguageName(key: self.language!)
        }
    }
    
    func setLanguageEnglish() {
        
        self._localizationManager.setLanguage(lang: kLanguageEnglish)
        Date.setLocale(language: kLanguageEnglish)
    }
    
    func setLanguageGerman() {
        
        self._localizationManager.setLanguage(lang: kLanguageGerman)
        Date.setLocale(language: kLanguageGerman)
    }
    
    var isGrantedNotificationAccess: Bool {
        
        set {
            
            
        }
        get {
            
            return true
        }
    }
    
    /*
    - (NSString *)remoteNotificationsDeviceToken {
    
        // ...
    }
    
    - (void)setRemoteNotificationsDeviceToken:(NSString *)remoteNotificationsDeviceToken {
    
        // ...
    
    }*/
    
    // MARK:
    // MARK: Internal
    // MARK:

    internal var _localizationManager: LocalizationManagerProtocol
    
    // Currently the app supports 2 languages only - "en" and "de". If user has selected other language than those two then "en" will be set as default
    internal func setDefaultLanguage() {
        
        let currentLanguage: String = self._localizationManager.getLanguage()
        
        if (!currentLanguage.isEqual(kLanguageEnglish) && !currentLanguage.isEqual(kLanguageGerman)) {
            
            self.setLanguageEnglish()
        }
    }
    
    // MARK: Generic
    
    // Generic setter
    internal func set(value: Any, key: String) {
        
        let userDefaults: UserDefaults = UserDefaults.standard
        let oldDict: Dictionary<String, Any>? = userDefaults.object(forKey: kSettingsGroupKey) as? Dictionary<String, Any>
    
        var newDict: Dictionary<String, Any> = Dictionary()
    
        // Create setting value if not exists
        if let oldDict = oldDict {
            
            newDict = newDict.merged(with: oldDict)
        }
        
        // Special treatment for bools
        if value is Bool {
            
            newDict.removeValue(forKey: key)
            
        } else {
            
            newDict[key] = value
        }
        
        userDefaults.set(newDict, forKey: kSettingsGroupKey)
        userDefaults.synchronize()
    }

    // Generic getter
    internal func value(key: String, defaultValueIfNotExists: Any?) -> Any? {

        var result: Any?
        var needsToSynchronize: Bool = false

        let userDefaults: UserDefaults = UserDefaults.standard
        var dict: Dictionary<String, Any>? = userDefaults.object(forKey: kSettingsGroupKey) as! Dictionary<String, Any>?
        
        if let unwrappedDict = dict {
        
            // Make a copy
            dict = Dictionary().merged(with: unwrappedDict)
            
        } else {
        
            // Create setting value if not exists
            dict = Dictionary()
            needsToSynchronize = true
        }
        
        result = dict?[key]
        
        if ((result == nil) && (defaultValueIfNotExists != nil)) {
            
            result = defaultValueIfNotExists!
            dict?[key] = result
            needsToSynchronize = true
        }
        
        if (needsToSynchronize) {
            
            userDefaults.set(dict, forKey: kSettingsGroupKey)
            userDefaults.synchronize()
        }
        
        return result
    }
    
    internal func removeValue(key: String) {
        
        let userDefaults: UserDefaults = UserDefaults.standard
        //NSMutableDictionary *dic = [[userDefaults objectForKey:kSettingsGroupKey] mutableCopy];
        var dict: Dictionary<String, Any>? = userDefaults.object(forKey: kSettingsGroupKey) as! Dictionary<String, Any>?
        _ = dict?.removeValue(forKey: key)
        userDefaults.set(dict, forKey: kSettingsGroupKey)
        userDefaults.synchronize()
    }
    
    /*func wrappedBool(value: Bool)->NSNumber {
        
        return NSNumber(value: value)
    }
    
    func unWrappedBool(value: NSNumber)->Bool? {
        
        return value.boolValue
    }*/
    
    // For unit tests
    
    internal func clearAll() {
        
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: kSettingsGroupKey)
    }
}
