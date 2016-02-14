//
//  KeychainManager.swift
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
import KeychainAccess

let kKeychainManagerAuthentificationTokenKey = "authentificationToken"

class KeychainManager: KeychainManagerProtocol {

    init() {
     
        // ...
    }
    
    // MARK: KeychainManagerProtocol
    
    func authentificationToken()->String? {
        
        var token: String?
        
        do {
                
            try token = _keychainStore.getString(kKeychainManagerAuthentificationTokenKey)
        }
        catch let error {
                
            let error: ErrorEntity = ErrorEntity.init(code: 0, message: "KeychainManager: unable to retrieve stored token: " + stringify(object: error))
            DDLogError(log: error.message!)
        }
                
        return token
    }
    
    func setAuthentificationToken(token: String?)->ErrorEntity? {
        
        var result: ErrorEntity?
        
        if let token = token {
            
            do {
                
                try _keychainStore.set(token, key: kKeychainManagerAuthentificationTokenKey)
            }
            catch let error {
                
                result = ErrorEntity.init(code: 0, message: "KeychainManager: unable to store token: " + stringify(object: error))
                DDLogError(log: (result?.message!)!)
            }
            
        } else {
            
            do {
                
                try _keychainStore.remove(kKeychainManagerAuthentificationTokenKey)
            }
            catch let error {
                
                result = ErrorEntity.init(code: 0, message: "KeychainManager: unable to clear stored token: " + stringify(object: error))
                DDLogError(log: (result?.message!)!)
            }
        }
        
        return result
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _keychainStore: Keychain = {
    
        let bundleIdentifier: String = Bundle.main.bundleIdentifier!
        
        // Access group: Create Keychain for Application Password
        //return Keychain(service: "com.example.github-token", accessGroup: "12ABCD3E4F.shared")
        
        // Create Keychain for Internet Password
        //let keychain = Keychain(server: "https://github.com", protocolType: .HTTPS)
        //let keychain = Keychain(server: "https://github.com", protocolType: .HTTPS, authenticationType: .HTMLForm)
        
        return Keychain(service: bundleIdentifier)
    }()
}
