//
//  PhoneCallCommand.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 23/10/16.
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

let kPhoneCallCommandNotSupportedOnDeviceAlertTextKey = "PhoneCallCommandNotSupportedOnDeviceAlertTextKey"

class PhoneCallCommand: CommandProtocol {

    required init(phoneNumber: String) {
        
        _phoneNumber = phoneNumber
    }
    
    // MARK: CommandProtocol
    
    func canExecute(error: inout ErrorEntity) -> Bool {
        
        let url: URL = self.phoneNumberUrl()
        
        if (UIApplication.shared.canOpenURL(url)) {
            
            return true
            
        } else {
            
            error = ErrorEntity.init(code: 0, message: localizedString(key: kPhoneCallCommandNotSupportedOnDeviceAlertTextKey))
            
            return false
        }
    }
    
    func executeWithCallback(callback: Callback?) {
        
        var error: ErrorEntity = ErrorEntity.init(code: nil, message: nil)
        
        if (self.canExecute(error: &error)) {
            
            UIApplication.shared.open(self.phoneNumberUrl(), options: [:], completionHandler: { (finished) in
                // ...
            })
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _phoneNumber: String
    
    internal func phoneNumberUrl()->URL {
        
        // Prepare url
        let set = NSCharacterSet.init(charactersIn: "0123456789-+()")
        let invertedSet = set.inverted
        let components = _phoneNumber.components(separatedBy:invertedSet)
        let cleanedString = components.joined(separator: "")

        let url: URL = URL.init(string: "telprompt:"+cleanedString)!
        
        return url;
    }
}
