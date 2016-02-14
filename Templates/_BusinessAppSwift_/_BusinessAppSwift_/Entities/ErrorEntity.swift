//
//  ErrorEntity.swift
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

let kNetworkErrorCodeKey: String = "ErrorCode"
let kNetworkErrorMessageKey: String = "ErrorMessage"

protocol ErrorEntityProtocol: ParsableEntityProtocol {
    
    var code: Int! {get set}
    var message: String! {get set}
    
    init(code: Int?, message: String?)
}

class ErrorEntity: ErrorEntityProtocol {
    
    // MARK: ErrorEntityProtocol
    
    var code: Int!
    var message: String!
    
    required init(dict: Dictionary <String, AnyObject>) {
        
        let errorCodeString: String? = dict[kNetworkErrorCodeKey] as? String
        
        if let value = errorCodeString {
            
            code = Int(value)
            message = dict[kNetworkErrorMessageKey] as! String
        }
    }
    
    convenience required init(code: Int?, message: String?) {
        
        var errorDict: Dictionary <String, AnyObject> = Dictionary()
        
        if let code = code {
            
            errorDict[kNetworkErrorCodeKey] = code as AnyObject?
        }
        
        if let message = message {
            
            errorDict[kNetworkErrorMessageKey] = message as AnyObject?
        }

        self.init(dict: errorDict)
    }
    
    func serializedDict()-> Dictionary <String, AnyObject>? {
        
        return nil;
    }
}
