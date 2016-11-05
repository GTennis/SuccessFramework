//
//  ConfigNetworkOperation.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 21/10/2016.
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
import Alamofire

class ConfigNetworkOperation: BaseNetworkOperation {

    override func requestUrlParams() -> String? {
        
        let appVersion: String = Bundle.plistValue(key: "CFBundleShortVersionString") as! String
        let result: String = "ios-" + appVersion
        
        return result
    }
    
    override func handleResponse(success: Bool, result: Any?, error: ErrorEntity?, callback: Callback) {
        
        if (success) {
            
            let item: AppConfigEntityProtocol = AppConfigEntity.init(dict: result as! Dictionary<String, Any>)
            callback(success, item, nil, nil)
            
        } else {
            
            callback(success, nil, nil, error);
        }
    }
    
    #if DEMO_MODE
    
    // Stub
    override func perform(callback: @escaping Callback) {
    
        let dict = readJsonFile(filename: "config")
    
        self.handleResponse(success: true, result: dict, error: nil, callback: callback)
    }
    
    #endif
}
