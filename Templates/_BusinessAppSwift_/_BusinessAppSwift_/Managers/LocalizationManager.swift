//
//  LocalizationManager.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 22/10/16.
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

// MARK: Convenience functions

func localizedString(key: String)->String {
    
    let managerFactory: ManagerFactoryProtocol = ManagerFactory.shared()
    
    return managerFactory.localizationManager.localizedString(key: key)
}

class LocalizationManager: /*NSObject,*/ LocalizationManagerProtocol {

    init() {
        
        // ...
    }
    
    // MARK: LocalizationManagerProtocol
    
    // MARK: Strings
    
    // Gets the current localized string
    func localizedString(key: String) -> String {
        
        return _bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    // Sets the desired language of the ones you have.
    //
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
    
    func setLanguage(lang: String) {
        
        DDLogDebug(log: "LocalizationManager: setLanguage to " + lang)
    
        let path: String? = _bundle.path(forResource: lang, ofType: "lproj")
        
        if let path = path {
            
            _bundle = Bundle(path: path)!
            
        } else {
            
            //in case the language does not exists
            self.resetLocalization()
        }
    
        let userDefaults = UserDefaults.standard
        userDefaults.set([lang], forKey: "AppleLanguages")
        userDefaults.synchronize()

        // Post notification
        self.notifyObserversWithLangChange()
    }
    
    // Just gets the current setted up language
    func getLanguage() -> String {
        
        var result: String = kLanguageEnglish
        
        if let languages = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String> {
            
            if let preferredLang = languages.first {
                
                // Only 2-letter language codes are used accross the app. This method will always return first to letters on country code (e.g. for en-GB it will return en)
                result = String(preferredLang.characters.prefix(2))
            }
        }
        
        return result
    }
    
    func getCurrentACLanguage() -> LanguageEntity {
        
        let shortName: String = self.getLanguage()
        let longName: String = self.getFullLanguageName(key: shortName)
        
        let lang: LanguageEntity = LanguageEntity.init(shortName: shortName, longName: longName)
        
        return lang
    }
    
    func resetLocalization() {
        
        _bundle = Bundle.main
    }
    
    func getFullLanguageName(key: String) -> String {
        
        // returns full language name in that language e.g.:
        // en = English
        // de = Deutsch
        
        let locale: NSLocale = NSLocale.init(localeIdentifier: key)
        var result: String = "UnknownLanguage"
        
        if let langName = locale.displayName(forKey: NSLocale.Key.identifier, value: key) {
            
            result = langName
        }
        
        return result
    }
    
    // MARK: State observers
    
    func addServiceObserver(observer: LocalizationManagerObserver, notificationType: LocalizationManagerNotificationType, callback: @escaping Callback, context: Any?) {
        
        _observers.add(observer: observer as AnyObject, notificationName: notificationType.rawValue, callback: callback, context: context)
    }
    
    func removeServiceObserver(observer: LocalizationManagerObserver, notificationType: LocalizationManagerNotificationType) {
        
        _observers.remove(observer: observer as AnyObject, notificationName: notificationType.rawValue)
    }
    
    func removeServiceObserver(observer: LocalizationManagerObserver) {
        
        _observers.remove(observer: observer as AnyObject)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    // http://mikebuss.com/2014/06/22/lazy-initialization-swift/
    internal lazy var _observers: ObserverListProtocol = SFObserverList.init(observedSubject: self)
    
    internal lazy var _bundle: Bundle = Bundle.main
    
    internal func notifyObserversWithLangChange() {
        
        _observers.notifyObservers(notificationName: LocalizationManagerNotificationType.didChangeLang.rawValue)
    }
}
