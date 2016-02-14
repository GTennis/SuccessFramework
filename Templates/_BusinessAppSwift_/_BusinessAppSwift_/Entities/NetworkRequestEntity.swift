//
//  NetworkRequestEntity.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 09/09/16.
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
//import AlamofireObjectMapper
//import ObjectMapper

let kNetworkRequestBaseUrlKey = "baseUrl"
let kNetworkRequestRelativeUrlKey = "relativeUrl"
let kNetworkRequestMethodKey = "method"
let kNetworkRequestGroupKey = "group"

protocol NetworkRequestEntityProtocol: ParsableEntityProtocol {
    
    var baseUrl: String? {get set}
    var relativeUrl: String! {get set}
    var method: String! {get set}
    var group: String? {get set}
}

class NetworkRequestEntity: NetworkRequestEntityProtocol {
    
    // MARK: NetworkRequestEntityProtocol
    
    var baseUrl: String?
    var relativeUrl: String!
    var method: String!
    var group: String?
    
    /*override init() {
        super.init()
    }
    
    // This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    convenience required init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        baseUrl    <- map[kNetworkRequestBaseUrlKey]
        relativeUrl         <- map[kNetworkRequestRelativeUrlKey]
        method      <- map[kNetworkRequestMethodKey]
        group       <- map[kNetworkRequestGroupKey]
    }*/
    
    // Custom
    
    init(backendEnvironment: BackendEnvironmentType) {
        
        // Auto pick environment for app config request
        switch (backendEnvironment) {
            
        case .production:
            
            baseUrl = ConstantsBackendEnvironment.production.baseUrl
            relativeUrl = ConstantsBackendEnvironment.production.relativeUrl
            method = ConstantsBackendEnvironment.production.method
            
            break;
            
        case .staging:
            
            baseUrl = ConstantsBackendEnvironment.staging.baseUrl
            relativeUrl = ConstantsBackendEnvironment.staging.relativeUrl
            method = ConstantsBackendEnvironment.staging.method
            
            break;
            
        case .development:
            
            baseUrl = ConstantsBackendEnvironment.development.baseUrl
            relativeUrl = ConstantsBackendEnvironment.development.relativeUrl
            method = ConstantsBackendEnvironment.development.method
            
            break;
        }
    }
    
    required init(dict: Dictionary <String, AnyObject>) {
        
        // as! is a forced downcast
        baseUrl = dict[kNetworkRequestBaseUrlKey] as? String;
        relativeUrl = dict[kNetworkRequestRelativeUrlKey] as! String;
        method = dict[kNetworkRequestMethodKey] as! String;
        group = dict[kNetworkRequestGroupKey] as? String;
    }
    
    func serializedDict()-> Dictionary <String, AnyObject>? {
        
        return nil;
    }
}
