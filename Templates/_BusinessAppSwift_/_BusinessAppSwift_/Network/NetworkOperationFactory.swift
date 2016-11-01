//
//  NetworkOperationFactory.swift
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

// Images
let kNetworkOperationImageListName = "imageList"
let kNetworkOperationImageUploadName = "imageUpload"

// User
let kNetworkOperationUserLoginName = "userLogin"
let kNetworkOperationUserSignUpName = "userSignUp"
let kNetworkOperationUserProfileName = "userProfile"
let kNetworkOperationUserResetPasswordName = "userResetPassword"

// Legal
let kNetworkOperationPrivacyPolicyName = "privacyPolicy"
let kNetworkOperationTermsConditionsName = "termsConditions"

class NetworkOperationFactory: NetworkOperationFactoryProtocol {

    // NetworkOperationFactoryProtocol
    
    var userManager: UserManagerProtocol?
    
    required init(appConfig: AppConfigEntity?, settingsManager: SettingsManagerProtocol) {
        
        _appConfig = appConfig
        _settingsManager = settingsManager
    }
    
    // MARK: Config
    
    func configNetworkOperation(context: Any?) -> NetworkOperationProtocol{
        
        let request = context as! NetworkRequestEntity
        let operation: NetworkOperationProtocol = ConfigNetworkOperation(networkRequest: request, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    // MARK: Images
    
    func imageUploadNetworkOperation(context: Any?) -> NetworkOperationProtocol {
     
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationImageListName]
        let operation: NetworkOperationProtocol = ImageUploadNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    func imageListNetworkOperation(context: Any?) -> NetworkOperationProtocol {
     
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationImageListName]
        let operation: NetworkOperationProtocol = ImageListNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    // MARK: User
    
    func userLoginNetworkOperation(context: Any?) -> NetworkOperationProtocol {
        
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationUserLoginName]
        let operation: NetworkOperationProtocol = UserLoginNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    func userSignUpNetworkOperation(context: Any?) -> NetworkOperationProtocol {
        
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationUserSignUpName]
        let operation: NetworkOperationProtocol = UserSignUpNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    func userProfileNetworkOperation(context: Any?) -> NetworkOperationProtocol {
        
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationUserProfileName]
        let operation: NetworkOperationProtocol = UserProfileNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    func userResetPasswordNetworkOperation(context: Any?) -> NetworkOperationProtocol {
        
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationUserResetPasswordName]
        let operation: NetworkOperationProtocol = UserResetPasswordNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    // MARK: Legal
    
    func privacyPolicyNetworkOperation(context: Any?) -> NetworkOperationProtocol {
        
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationPrivacyPolicyName]
        let operation: NetworkOperationProtocol = PrivacyPolicyNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    func termsConditionsNetworkOperation(context: Any?) -> NetworkOperationProtocol {
        
        let request = _appConfig!.currentNetworkRequests[kNetworkOperationTermsConditionsName]
        let operation: NetworkOperationProtocol = TermsConditionsNetworkOperation(networkRequest: request!, context: context, userManager: userManager!, settingsManager: _settingsManager)
        
        return operation
    }
    
    // MARK: 
    // MARK: Internal
    // MARK:
    internal
    
    var _appConfig: AppConfigEntity?
    var _settingsManager: SettingsManagerProtocol
}
