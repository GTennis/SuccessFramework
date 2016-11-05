//
//  BaseNetworkOperation.swift
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
import Alamofire

struct NetworkRequestError {
    
    static let notification = Notification.Name("NetworkRequestErrorNotification")
    static let notificationUserInfoErrorKey = "notificationUserInfoErrorKey"
    
    struct badData {
        
        static let code = 400
        static let name = localizedString(key:"NetworkRequestBadUserDataError")
    }
    
    struct unauthorized {
        
        static let code = 401
        static let name = localizedString(key:"NetworkRequestUnauthorizeError")
    }
    
    /*struct server {
     
     static let code = 500
     static let name = "NetworkRequestServerError"
     }*/
    
    struct canceled {
        
        static let code = -999
        static let name = localizedString(key:"NetworkRequestCanceledError")
    }
    
    struct timeout {
        
        static let code = -1001
        static let name = localizedString(key:"NetworkRequestTimeoutError")
    }
    
    struct isOffline {
        
        static let code = -1009
        static let name = localizedString(key:"NetworkRequestIsOfflineError")
    }
}

class BaseNetworkOperation: NetworkOperationProtocol {
    
    // MARK: NetworkOperationProtocol
    
    var networkRequest: NetworkRequestEntityProtocol
    var context: Any?
    var isSilent: Bool = false
    
    required init(networkRequest: NetworkRequestEntityProtocol, context: Any?, userManager: UserManagerProtocol, settingsManager: SettingsManagerProtocol) {
        
        self.context = context
        _userManager = userManager
        _settingsManager = settingsManager
        self.networkRequest = networkRequest
    }
    
    func perform(callback: @escaping Callback) {
        
        // Create network request url string
        var urlString: String = self.requestBaseUrl()
        if let requestRelativeUrl = self.requestRelativeUrl() {
            
            urlString = urlString + requestRelativeUrl
        }
        
        // Add url params from the subclass if exist
        if let urlParamsString: String = self.requestUrlParams() {
            
            urlString = urlString + "?" + urlParamsString
        }
        
        // Escape
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        // Validate url
        /*if !urlString.isValidUrlString() {
         
         DDLogError(log: "Invalid url: " + urlString)
         }*/
        
        // Method
        let requestMethod: HTTPMethod = self.methodForName(name: self.requestMethod())
        
        // Headers
        let requestHeaders: Dictionary<String, String> = self.requestHeaders()
        
        // Body
        let requestBody: Dictionary<String, String>? = self.requestBodyParams()
        
        //#if DEBUG
        // For internal local https environment with self signed certificate
        //self.securityPolicy.allowInvalidCertificates = YES;
        //#endif
        
        Alamofire.request(urlString, method: requestMethod, parameters: requestBody, encoding: JSONEncoding.default, headers: requestHeaders)/*validate(statusCode: 200..<300)*/
            .validate(contentType: ["application/json"]).responseJSON { response in
                
                // Useful links for validation:
                // http://stackoverflow.com/a/34738244
                // http://stackoverflow.com/a/33102907
                
                let validationError = self.validate(response: response)
                
                // Immediatelly return error if custom validation fails
                if let error = validationError {
                    
                    let errorEntity = ErrorEntity.init(code: 0, message: "[" + className(object: self) + "]: failed with error: " + error.message)
                    DDLogError(log: errorEntity.message)
                    
                    self.handleResponse(success: false, result: nil, error: errorEntity, callback: callback)
                    
                    // Use Alamofire default validation
                } else {
                    
                    switch response.result {
                        
                    case .success(let value):
                        
                        DDLogDebug(log: "[" + className(object: self) + "]: success")
                        self.handleResponse(success: true, result: value, error: nil, callback: callback)
                        
                        break
                        
                    case .failure(let error):
                        
                        let errorEntity = ErrorEntity.init(code: 0, message: "[" + className(object: self) + "]: failed with error: " + error.localizedDescription)
                        DDLogError(log: errorEntity.message)
                        
                        self.handleResponse(success: false, result: nil, error: errorEntity, callback: callback)
                        
                        break
                    }
                }
        }
    }
    
    // MARK:
    // MARK: Protected
    // MARK:
    
    func requestBaseUrl() -> String {
        
        return networkRequest.baseUrl!
    }
    
    func requestRelativeUrl() -> String? {
        
        return networkRequest.relativeUrl
    }
    
    func requestMethod() -> String {
        
        return networkRequest.method
    }
    
    func requestHeaders() -> Dictionary<String, String> {
        
        var headers: Dictionary<String, String> = Dictionary()
        
        // Add common headers
        //[urlRequest setHTTPShouldHandleCookies:NO];
        
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        
        let language: String = _settingsManager.language!
        let locale: String = Locale.current.identifier
        let localeComponents = locale.components(separatedBy: "_")
        let region: String = localeComponents.last!
        let acceptLanguage: String = language + "_" + region
        
        headers["Accept-Language"] = acceptLanguage
        
        // Add authorization if needed
        if let user = _userManager.user {
            
            if let token = user.token {
                
                headers["Authorization"] = "Bearer " + token
            }
        }
        
        return headers
    }
    
    func requestBodyParams() -> Dictionary<String, String>? {
        
        return nil
    }
    
    func requestUrlParams() -> String? {
        
        return nil
    }
    
    func handleResponse(success: Bool, result: Any?, error: ErrorEntity?, callback: Callback) {
        
        fatalError("handleResponse is not implemented in class: " + className(object: self))
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _userManager: UserManagerProtocol
    internal var _settingsManager: SettingsManagerProtocol
    
    func methodForName(name: String) -> HTTPMethod {
        
        var result: HTTPMethod = HTTPMethod.get
        
        switch name {
            
        case "OPTIONS":
            result = HTTPMethod.options
        case "GET":
            result = HTTPMethod.get
        case "HEAD":
            result = HTTPMethod.head
        case "POST":
            result = HTTPMethod.post
        case "PUT":
            result = HTTPMethod.put
        case "PATCH":
            result = HTTPMethod.patch
        case "DELETE":
            result = HTTPMethod.delete
        case "TRACE":
            result = HTTPMethod.trace
        case "CONNECT":
            result = HTTPMethod.connect
        default:
            result = HTTPMethod.get
        }
        
        return result
    }
    
    func validate(response: DataResponse<Any>)->ErrorEntity? {
        
        var result: ErrorEntity?
        
        if let httpStatusCode = response.response?.statusCode {
            
            var message : String = String(describing: response)
            
            let httpStatusCodeString: String = String(httpStatusCode)
            let index = httpStatusCodeString.index(httpStatusCodeString.startIndex, offsetBy: 1)
            let httpResponseStatusFirstDigit: String = httpStatusCodeString.substring(to: index)
            
            switch(httpResponseStatusFirstDigit) {
                
            case "2":
                
                // Everything is ok.
                break
                
            case "4":
                
                // Unauthorized
                if (httpStatusCodeString.isEqual(401)) {
                    
                    message = NetworkRequestError.unauthorized.name
                    
                    // 4XX bad data was passed
                } else {
                    
                    // ...
                }
                
                result = ErrorEntity.init(code: httpStatusCode, message: message)
                break
                
            case "5":
                
                result = ErrorEntity.init(code: httpStatusCode, message: message)
                break
                
            default:
                
                result = ErrorEntity.init(code: httpStatusCode, message: message)
                break
            }
        }
        
        return result
    }
}
