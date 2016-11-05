//
//  UserEntity.swift
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

let kUserUserIdKey: String = "userId"
let kUserTokenKey: String = "token"
let kUserSalutationKey: String = "salutation"
let kUserFirstNameKey: String = "firstName"
let kUserLastNameKey: String = "lastName"
let kUserAddressKey: String = "address"
let kUserAddressOptionalKey: String = "addressOptional"
let kUserZipCodeKey: String = "zipCode"
let kUserCountryCodeKey: String = "countryCode"
let kUserStateCodeKey: String = "stateCode"
let kUserCityKey: String = "city"
let kUserEmailKey: String = "email"
let kUserPhoneKey: String = "phone"
let kUserPasswordKey: String = "password"

protocol UserEntityProtocol: ParsableEntityProtocol {
    
    var userId: String! {get set}
    var token: String? {get set}
    var salutation: String! {get set}
    var firstName: String! {get set}
    var lastName: String! {get set}
    var address: String! {get set}
    var addressOptional: String? {get set}
    var zipCode: String! {get set}
    var countryCode: String! {get set}
    var stateCode: String! {get set}
    var city: String! {get set}
    var phone: String! {get set}
    var email: String! {get set}
    var password: String? {get set}
}

class UserEntity: UserEntityProtocol {

    // MARK: UserEntityProtocol
    
    var userId: String!
    var token: String?
    var salutation: String!
    var firstName: String!
    var lastName: String!
    var address: String!
    var addressOptional: String?
    var zipCode: String!
    var countryCode: String!
    var stateCode: String!
    var city: String!
    var phone: String!
    var email: String!
    var password: String?
    
    required init (){
        
        // ...
    }
    
    required init(dict: Dictionary <String, Any>) {
        
        self.userId = dict[kUserUserIdKey] as! String!
        self.salutation = dict[kUserSalutationKey] as! String!
        self.firstName = dict[kUserFirstNameKey] as! String!
        self.lastName = dict[kUserLastNameKey] as! String!
        self.address = dict[kUserAddressKey] as! String!
        if let addr = dict[kUserAddressOptionalKey] as? String {
            
            self.addressOptional = addr
        }
        self.zipCode = dict[kUserZipCodeKey] as! String!
        self.city = dict[kUserCityKey] as! String!
        self.countryCode = dict[kUserCountryCodeKey] as! String!
        self.stateCode = dict[kUserStateCodeKey] as! String!
        self.phone = dict[kUserPhoneKey] as! String!
        self.email = dict[kUserEmailKey] as! String!
        
        self.token = dict[kUserTokenKey] as! String?
    }
    
    func serializedDict()-> Dictionary <String, Any>? {
        
        var dict:Dictionary <String, Any>? = Dictionary()

        // dict? unwraps dictionary into value, and then ? (Optional chaining) makes sure setValue on dictionary is called when dict is not nill only.
        
        dict?[kUserUserIdKey] = userId
        dict?[kUserSalutationKey] = salutation
        dict?[kUserFirstNameKey] = firstName
        dict?[kUserLastNameKey] = lastName
        dict?[kUserAddressKey] = address
        dict?[kUserAddressOptionalKey] = addressOptional
        dict?[kUserZipCodeKey] = zipCode
        dict?[kUserCityKey] = city
        dict?[kUserCountryCodeKey] = countryCode
        dict?[kUserStateCodeKey] = stateCode
        dict?[kUserPhoneKey] = phone
        dict?[kUserEmailKey] = email
        dict?[kUserPasswordKey] = password
        
        return dict
        
        //return ["test":"test"]
    }
}
