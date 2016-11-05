//
//  AppConfigEntity.swift
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

// Keys for parsing response
let kAppConfigPlatformIOS: String = "ios"
let kAppConfigSupportedAppVersionsKey: String = "supportedAppVersions"
let kAppConfigSupportedAppVersionListKey: String = "versions"
let kAppConfigSupportedAppStoreUrlKey: String = "appStoreUrl"

let kAppConfigVersionKey: String = "version"
let kAppConfigPlatformKey: String = "platform"

let kAppConfigLoggingGroupKey: String = "logging"
let kAppConfigLogLevelKey: String = "logLevel"

let kAppConfigBackendAPIsKey: String = "backendAPIs"
let kAppConfigBackendEnvironmentsKey: String = "environments"

let kAppConfigBackendEnvironmentActionsKey: String = "actions"
let kAppConfigBackendEnvironmentBaseUrlKey: String = "baseUrl"

let kAppConfigBackendProductionGroupKey: String = "production"
let kAppConfigBackendStageGroupKey: String = "production"//"stage"
let kAppConfigBackendDevelopmentGroupKey: String = "production"//"development"

protocol AppConfigEntityProtocol: ParsableEntityProtocol {
    
    var supportedAppVersions: Array <String> {get set}
    var appStoreUrlString: String {get set}
    var appConfigVersion: Int {get set} // This property is received from backend during app launch and stored in memory during app run. Then app will requery app configs from the app everytime it will return from background. If current in-memory appConfigVersion is not equal to received appConfigVersion then app will reload itself (in order to update its backend API paths)
    var isAppNeedUpdate: Bool {get}
    var logLevel: LogLevelType {get}
    
    func setCurrentRequests(backendEnvironment: BackendEnvironmentType)
}

class AppConfigEntity: AppConfigEntityProtocol {
    
    // MARK: AppConfigEntityProtocol
    
    var supportedAppVersions: Array <String>
    var appStoreUrlString: String
    var appConfigVersion: Int
    var currentNetworkRequests: Dictionary <String, NetworkRequestEntity>! // will point to one of the three properties above
    
    var isAppNeedUpdate: Bool {
        
        let nsObject: Any? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as Any?
        let version = nsObject as! String
        
        return !self._contains(appVersion: version)
    }
    
    var logLevel: LogLevelType {
        
        let intValue: Int = _currentNetworkEnvironment.rawValue
        let logLevelString: String = _environmentLogLevels[intValue]!
        
        return self._convertedLogLevel(logLevelString: logLevelString)
    }
    
    func setCurrentRequests(backendEnvironment: BackendEnvironmentType) {
    
        _currentNetworkEnvironment = backendEnvironment
        
        switch backendEnvironment {
            
            case .production:
                currentNetworkRequests = _productionNetworkRequests
            
            case .staging:
                currentNetworkRequests = _stageNetworkRequests
            
            case .development:
                currentNetworkRequests = _developmentNetworkRequests
            
            //default:
        }
    }
    
    required init(dict: Dictionary <String, Any>) {
        
        _platform = dict[kAppConfigPlatformKey] as! String;
        
        let backendAPIsDict: Dictionary <String, Any> = dict[kAppConfigBackendAPIsKey] as! Dictionary;
        let backendEnvironmentDict: Dictionary <String, Any> = backendAPIsDict[kAppConfigBackendEnvironmentsKey] as! Dictionary;
        
        let productionEnvironmentDict: Dictionary <String, Any> = backendEnvironmentDict[kAppConfigBackendProductionGroupKey] as! Dictionary;
        let stageEnvironmentDict: Dictionary <String, Any> = backendEnvironmentDict[kAppConfigBackendStageGroupKey] as! Dictionary;
        let developmentEnvironmentDict: Dictionary <String, Any> = backendEnvironmentDict[kAppConfigBackendDevelopmentGroupKey] as! Dictionary;
        
        //----- Check app config version -----//
        appConfigVersion = dict[kAppConfigVersionKey] as! Int;
        
        //----- Extract log levels -----//
        
        _environmentLogLevels = Dictionary();
        
        // Add production log level
        
        let productionEnvironmentLogsDict: Dictionary <String, Any> = productionEnvironmentDict[kAppConfigLoggingGroupKey] as! Dictionary;
        var logLevel = productionEnvironmentLogsDict[kAppConfigLogLevelKey] as! String;
        
        _environmentLogLevels[BackendEnvironmentType.production.rawValue] = logLevel
        
        // Add stage log level
        let stageEnvironmentLogsDict: Dictionary <String, Any> = stageEnvironmentDict[kAppConfigLoggingGroupKey] as! Dictionary;
        logLevel = stageEnvironmentLogsDict[kAppConfigLogLevelKey] as! String
        _environmentLogLevels[BackendEnvironmentType.staging.rawValue] = logLevel
        
        // Add development log level
        let developmentEnvironmentLogsDict: Dictionary <String, Any> = developmentEnvironmentDict[kAppConfigLoggingGroupKey] as! Dictionary;
        logLevel = developmentEnvironmentLogsDict[kAppConfigLogLevelKey] as! String;
        _environmentLogLevels[BackendEnvironmentType.development.rawValue] = logLevel
        
        //----- Check for supported version -----//
        let supportedAppVersionsDict: Dictionary <String, Any> = dict[kAppConfigSupportedAppVersionsKey] as! Dictionary
        let supportedAppVersionsArray: Array <String> = supportedAppVersionsDict[kAppConfigSupportedAppVersionListKey] as! Array;
        
        supportedAppVersions = Array();
        for item in supportedAppVersionsArray {
            
            supportedAppVersions.append(item)
        }
        
        appStoreUrlString = supportedAppVersionsDict[kAppConfigSupportedAppStoreUrlKey] as! String;
        
        //----- Parse and check production backend urls -----//
        
        let productionBaseUrl:String = productionEnvironmentDict[kAppConfigBackendEnvironmentBaseUrlKey] as! String
        let productionNetworkRequestsDict: Dictionary <String, Any> = productionEnvironmentDict[kAppConfigBackendEnvironmentActionsKey] as! Dictionary;
        
        _productionNetworkRequests = AppConfigEntity._networkRequests(networkRequestsDict: productionNetworkRequestsDict, baseUrl: productionBaseUrl)
        
        //----- Parse stage backend urls -----//
        // No need to check because it's not important on production environment if they would become empty
        
        let stageBaseUrl:String = stageEnvironmentDict[kAppConfigBackendEnvironmentBaseUrlKey] as! String
        let stageNetworkRequestsDict: Dictionary <String, Any> = stageEnvironmentDict[kAppConfigBackendEnvironmentActionsKey] as! Dictionary;
        
        _stageNetworkRequests = AppConfigEntity._networkRequests(networkRequestsDict: stageNetworkRequestsDict, baseUrl: stageBaseUrl)
        
        //----- Parse and check stage backend urls -----//
        // No need to check because it's not important on production environment if they would become empty
        
        let developmentBaseUrl:String = developmentEnvironmentDict[kAppConfigBackendEnvironmentBaseUrlKey] as! String;
        let developmentNetworkRequestsDict: Dictionary <String, Any> = developmentEnvironmentDict[kAppConfigBackendEnvironmentActionsKey] as! Dictionary;
        
        _developmentNetworkRequests = AppConfigEntity._networkRequests(networkRequestsDict: developmentNetworkRequestsDict, baseUrl: developmentBaseUrl)
    }
    
    func serializedDict()-> Dictionary <String, Any>? {
        
        return nil;
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    internal
    
    var _productionNetworkRequests: Dictionary <String, NetworkRequestEntity>!
    var _stageNetworkRequests: Dictionary <String, NetworkRequestEntity>!
    var _developmentNetworkRequests: Dictionary <String, NetworkRequestEntity>!
    
    var _platform: String
    var _environmentLogLevels: Dictionary <Int, String>
    var _currentNetworkEnvironment: BackendEnvironmentType!
    //var environmentsDict: [String : Any] = [:]
    var _productionEnvironmentDict: [String : Any] = [:]
    var _stageEnvironmentDict: [String : Any] = [:]
    var _developmentEnvironmentDict: [String : Any] = [:]
    
    // Static because this method cannot be called in init with self because init should initialize variables first, and if some variable and optional then you need to use static
    static func _networkRequests(networkRequestsDict: Dictionary<String, Any>, baseUrl: String) -> Dictionary<String, NetworkRequestEntity> {
        
        //return Dictionary()
        
        let networkRequestNames: Array <String> = allKeys(dict: networkRequestsDict)
        
        //TODO
        var result: Dictionary <String, NetworkRequestEntity> = Dictionary()
        var dict:Dictionary<String, Any>
        var networkRequest: NetworkRequestEntity
        
        for networkRequestName in networkRequestNames {
            
            // Extract object
            dict = networkRequestsDict[networkRequestName] as! Dictionary
            networkRequest = NetworkRequestEntity.init(dict: dict)
            
            if networkRequest.baseUrl == nil {
                
                networkRequest.baseUrl = baseUrl;
            }
            
            // Add object
            result[networkRequestName] = networkRequest;
        }
        
        // Return
        return result;
    }
    
    func _convertedLogLevel(logLevelString: String) -> LogLevelType {
        
        // Proceed
        
        var logLevel: LogLevelType = LogLevelType.warning
        
        switch logLevelString {
            
        case "none":
            logLevel = LogLevelType.none
            
        case "error":
            logLevel = LogLevelType.error
            
        case "warning":
            logLevel = LogLevelType.warning
            
        case "info":
            logLevel = LogLevelType.info
            
        case "debug":
            logLevel = LogLevelType.debug
            
        case "verbose":
            logLevel = LogLevelType.verbose
            
        case "all":
            logLevel = LogLevelType.all
            
        default:
            logLevel = LogLevelType.warning
        }
        
        return logLevel;
    }
    
    func _contains(appVersion: String) -> Bool {
        
        let predicate: NSPredicate = NSPredicate(format: "SELF == %@", appVersion)
        let result:Array = (supportedAppVersions as NSArray).filtered(using: predicate)
        
        
        return (result.count > 0) ? true : false
    }
    
    var isConfigForIosPlatform: Bool {
        
        return (_platform == kAppConfigPlatformIOS) ? true : false
    }
}
