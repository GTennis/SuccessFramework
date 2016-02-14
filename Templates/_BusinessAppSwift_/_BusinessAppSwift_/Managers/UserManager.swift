//
//  UserManager.swift
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

class UserManager : UserManagerProtocol {

    // MARK: UserManagerProtocol     
    var settingsManager: SettingsManagerProtocol!
    var networkOperationFactory: NetworkOperationFactoryProtocol!
    var analyticsManager: AnalyticsManagerProtocol!
    var keychainManager: KeychainManagerProtocol!
    
    // Data object
    var user: UserEntity?
    
    // https://objectpartners.com/2016/01/18/exploring-swift-initializers/
    // Every class needs to have at least one designated initializer where all non optional properties are initialized
    // Such init would allow you to create empty object but then all the properties would need to be optionals
    /*required init() {
        
        // ...
    }*/
    
    // User handling
    required init(settingsManager: SettingsManagerProtocol, networkOperationFactory: NetworkOperationFactoryProtocol, analyticsManager: AnalyticsManagerProtocol, keychainManager: KeychainManagerProtocol) {
        
        self.settingsManager = settingsManager
        self.networkOperationFactory = networkOperationFactory
        self.analyticsManager = analyticsManager
        self.keychainManager = keychainManager
        
        // Load user
        let dict: Dictionary <String, AnyObject>? = settingsManager.loggedInUser
        
        if (dict == nil) {
            
            user = nil;
        }
        
        let token: String? = keychainManager.authentificationToken()
        
        if let token = token {
            
            if let dict = dict {
                
                var dictWithToken: Dictionary<String, AnyObject> = Dictionary()
                
                dictWithToken = dictWithToken.merged(with: dict)
                dictWithToken[kUserTokenKey] = token as AnyObject
                
                user = UserEntity.init(dict: dictWithToken)
            }
            
        } else {
            
            // Clear user if token was not loaded
            user = nil
        }
    }
    
    func isUserLoggedIn()->Bool {

        let intCount = user?.token?.characters.count
        
        if let intCount = intCount {
            
            return (intCount > 0)
            
        } else {
            
            return false
        }
    }
    
    func login(user: UserEntity, callback: @escaping Callback) {
        
        //weak var weakSelf = self
        //__weak typeof(wself) weakSelf = self;
        
        // Weak and unowned self:
        // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html
        let wrappedCallback: Callback = { [weak self] (_ success: Bool, _ result: Any?, _ context: Any?, _ error: ErrorEntity?) -> Void in
            
            if (success) {
                
                let error: ErrorEntity? = self?.save(user: result as! UserEntity)
                
                if let error = error {
                    
                    self?.notifyObserversWithLoginFail(error: error)
                    
                } else {
                    
                    // [weakSelf.pushNotificationManager loginUser:data callback:^(BOOL success, id result, NSError *error) {
                    // ...
                    // }];
                    
                    self?.notifyObserversWithLoginSuccess(user: (self?.user!)!)
                }
                
            } else {
                
                self?.notifyObserversWithLoginFail(error: error)
            }
            
            callback(success, result, nil, error);
        }
        
        let hashedPwd: String = (user.password as NSString).sha512(withSalt: nil);
        user.password = hashedPwd
        
        let userLoginOperation: NetworkOperationProtocol = networkOperationFactory.userLoginNetworkOperation(context: user.serializedDict())
        userLoginOperation.perform(callBack: wrappedCallback)
    }
    
    func signUp(user: UserEntity, callback: @escaping Callback) {
        
        let wrappedCallback: Callback = { [weak self] (_ success: Bool, _ result: Any?, _ context: Any?, _ error: ErrorEntity?) -> Void in
            
            if (success) {
                
                let error: ErrorEntity? = self?.save(user: result as! UserEntity)
                
                if let error = error {
                    
                    self?.notifyObserversWithSignUpFail(error: error)
                    
                } else {
                    
                    // [weakSelf.pushNotificationManager signUpUser:data callback:^(BOOL success, id result, NSError *error) {
                    // ...
                    // }];
                    
                    self?.notifyObserversWithSignUpSuccess(user: (self?.user!)!)
                }
                
            } else {
                
                self?.notifyObserversWithSignUpFail(error: error)
            }
            
            callback(success, result, nil, error);
        }
        
        let hashedPwd: String = (user.password as NSString).sha512(withSalt: nil);
        user.password = hashedPwd
        
        let userSignUpOperation: NetworkOperationProtocol = networkOperationFactory.userSignUpNetworkOperation(context: user.serializedDict())
        userSignUpOperation.perform(callBack: wrappedCallback)
    }
    
    func resetPassword(user: UserEntity, callback: @escaping Callback) {
        
        let wrappedCallback: Callback = { [weak self] (_ success: Bool, _ result: Any?, _ context: Any?, _ error: ErrorEntity?) -> Void in
            
            if (success) {
                
                self?.notifyObserversWithPasswordResetSuccess(email: user.email)
                
            } else {
                
                self?.notifyObserversWithPasswordResetFail(error: error)
            }
            
            callback(success, result, nil, error)
        }
        
        let userResetPasswordOperation: NetworkOperationProtocol = networkOperationFactory.userResetPasswordNetworkOperation(context: user.serializedDict())
        userResetPasswordOperation.perform(callBack: wrappedCallback)
    }
    
    func getUserProfile(user: UserEntity, callback: @escaping Callback) {
        
        let wrappedCallback: Callback = { [weak self] (_ success: Bool, _ result: Any?, _ context: Any?, _ error: ErrorEntity?) -> Void in
            
            if (success) {
                
                self?.user = result as? UserEntity
                
            } else {
                
                self?.notifyObserversWithPasswordResetFail(error:error)
            }
            
            callback(success, result, nil, error)
        }
        
        let userProfileOperation: NetworkOperationProtocol = networkOperationFactory.userProfileNetworkOperation(context: user.serializedDict())
        userProfileOperation.perform(callBack: wrappedCallback)
    }
    
    func logout(callback: @escaping Callback) {
        
        var error: ErrorEntity

        // [self.pushNotificationManager logoutUserWithCallback:^(BOOL success, id result, NSError *error) {
        // ...
        //    }];
        
        // Clear the token
        if let keychainError = self.keychainManager.setAuthentificationToken(token: nil) {
            
            error = ErrorEntity.init(code: 0, message: localizedString(key: "UserManager logout: unable to clear token in keychain. " + keychainError.message))
            
            self.notifyObserversWithLogoutFail(error: error)
            
            callback(false, nil, nil, error)

        } else {
            
            settingsManager.loggedInUser = nil
            
            let loggedOutUser: UserEntity = self.user!
            
            self.user = nil
            
            // There should be a webservice which does login and invalides token (if somebody sniffed and stole it). However there's no such webservice and we do logout locally only and so always consider logout as success immediatelly
            self.notifyObserversWithLogoutSuccess(user: loggedOutUser)
            
            callback(true, nil, nil, nil)
        }
    }
    
    // MARK: State observers

    func addServiceObserver(observer: UserManagerObserver, notificationType: UserManagerNotificationType, callback: @escaping Callback, context: Any?) {
        
        _observers.add(observer: observer as AnyObject, notificationName: notificationType.rawValue, callback: callback, context: context)
    }
    
    func removeServiceObserver(observer: UserManagerObserver, notificationType: UserManagerNotificationType) {
        
        _observers.remove(observer: observer as AnyObject, notificationName: notificationType.rawValue)
    }
    
    func removeServiceObserver(observer: UserManagerObserver) {
        
        _observers.remove(observer: observer as AnyObject)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    // http://mikebuss.com/2014/06/22/lazy-initialization-swift/
    internal lazy var _observers: ObserverListProtocol = GMObserverList.init(observedSubject: self)
    //lazy var _user: UserEntity = UserEntity()
    //_user = [[UserObject alloc] init]; haven't ported this line. IMHO it's not needed anymore, maybe legacy stuff
    
    internal func save(user: UserEntity) -> ErrorEntity? {
        
        var result: ErrorEntity?
        
        if let token = user.token {
            
            // Store token
            if let error = self.keychainManager.setAuthentificationToken(token: token) {
                
                result = error
                
            } else {
                
                // Serialize and store user in settings
                let dict: Dictionary <String, AnyObject>? = user.serializedDict()
                settingsManager.loggedInUser = dict
                
                // Update in-memory user
                self.user = user
            }
            
        } else {
            
            result = ErrorEntity.init(code: 0, message: localizedString(key: "UserManager: unable to save user because token is empty"))
        }
        
        return result
    }
    
    // MARK: UserManagerObserver handling
    
    internal func notifyObserversWithLoginSuccess(user: UserEntity) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didLogin.rawValue)
    }

    internal func notifyObserversWithLoginFail(error: ErrorEntity?) {
     
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didFailedToLogin.rawValue)
    }
    
    internal func notifyObserversWithSignUpSuccess(user: UserEntity) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didSignUp.rawValue)
    }
    
    internal func notifyObserversWithSignUpFail(error: ErrorEntity?) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didFailedToSignUp.rawValue)
    }
    
    internal func notifyObserversWithUpdateSuccess(user: UserEntity) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didUpdate.rawValue)
    }
    
    internal func notifyObserversWithUpdateFail(error: ErrorEntity?) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didFailedToUpdate.rawValue)
    }
    
    internal func notifyObserversWithLogoutSuccess(user: UserEntity) {
    
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didLogout.rawValue)
    }
    
    internal func notifyObserversWithLogoutFail(error: ErrorEntity?) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didFailedToLogout.rawValue)
    }

    internal func notifyObserversWithPasswordResetSuccess(email: String) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didResetPassword.rawValue)
    }
    
    internal func notifyObserversWithPasswordResetFail(error: ErrorEntity?) {
        
        _observers.notifyObservers(notificationName: UserManagerNotificationType.didFailedToResetPassword.rawValue)
    }
}
