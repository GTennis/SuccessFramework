//
//  NetworkOperationProtocol.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 20/10/2016.
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

protocol NetworkOperationProtocol {

    var networkRequest: NetworkRequestEntityProtocol {get set}
    var context: Any? {get set}
    var isSilent: Bool {get set}
    
    init(networkRequest: NetworkRequestEntityProtocol, context: Any?, userManager: UserManagerProtocol, settingsManager: SettingsManagerProtocol)
    func handleResponse(success: Bool, result: Any?, error: ErrorEntity?, callback: Callback)
    
    // Params accepts any type of object. This means data objects could be passed for convenience. However, inside a subclass we need to transform passed "params" data object and return Dictionary. See protected params method
    func perform(callback: @escaping Callback)
    
    // NSOperation Operation Alamofire
    // http://stackoverflow.com/questions/27021896/nsurlsession-concurrent-requests-with-alamofire
}
