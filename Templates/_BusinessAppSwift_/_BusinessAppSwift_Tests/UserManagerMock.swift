//
//  UserManagerMock.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 16/11/16.
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

import Foundation
import XCTest
@testable import _BusinessAppSwift_

class UserManagerMock: UserManagerProtocol {
    
    // Dependencies
    var settingsManager: SettingsManagerProtocol!
    var networkOperationFactory: NetworkOperationFactoryProtocol!
    var analyticsManager: AnalyticsManagerProtocol!
    var keychainManager: KeychainManagerProtocol!
    
    // Data object
    var user: UserEntity?
    
    // User handling
    required init(settingsManager: SettingsManagerProtocol, networkOperationFactory: NetworkOperationFactoryProtocol, analyticsManager: AnalyticsManagerProtocol, keychainManager: KeychainManagerProtocol) {
        
        
    }
    
    func isUserLoggedIn()->Bool {
        
        return true
    }
    
    func login(user: UserEntity, callback: @escaping Callback) {
        
        
    }
    
    func signUp(user: UserEntity, callback: @escaping Callback) {
        
        
    }
    
    func resetPassword(user: UserEntity, callback: @escaping Callback) {
        
        
    }
    
    func getUserProfile(user: UserEntity, callback: @escaping Callback) {
        
        
    }
    
    func logout(callback: @escaping Callback) {
        
        
    }
    
    // State observers
    func addServiceObserver(observer: UserManagerObserver, notificationType: UserManagerNotificationType, callback: @escaping Callback, context: Any?) {
        
        
    }
    
    func removeServiceObserver(observer: UserManagerObserver, notificationType: UserManagerNotificationType) {
        
        
    }
    
    func removeServiceObserver(observer: UserManagerObserver) {
        
        
    }
}
