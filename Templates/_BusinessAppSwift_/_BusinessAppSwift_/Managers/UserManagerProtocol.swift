//
//  UserManagerProtocol.swift
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

import Foundation

protocol UserManagerProtocol {
    
    // Dependencies
    var settingsManager: SettingsManagerProtocol! {get set}
    var networkOperationFactory: NetworkOperationFactoryProtocol! {get set}
    var analyticsManager: AnalyticsManagerProtocol! {get set}
    var keychainManager: KeychainManagerProtocol! {get set}
    
    // Data object
    var user: UserEntity? {get set}
    
    // User handling
    init(settingsManager: SettingsManagerProtocol, networkOperationFactory: NetworkOperationFactoryProtocol, analyticsManager: AnalyticsManagerProtocol, keychainManager: KeychainManagerProtocol)
    
    func isUserLoggedIn()->Bool
    func login(user: UserEntity, callback: @escaping Callback)
    func signUp(user: UserEntity, callback: @escaping Callback)
    func resetPassword(user: UserEntity, callback: @escaping Callback)
    func getUserProfile(user: UserEntity, callback: @escaping Callback)
    func logout(callback: @escaping Callback)
    
    // State observers
    func addServiceObserver(observer: AnyObject, notificationType: UserManagerNotificationType, callback: @escaping Callback, context: Any?)
    func removeServiceObserver(observer: AnyObject, notificationType: UserManagerNotificationType)
    func removeServiceObserver(observer: AnyObject) // Removes all entries
}
