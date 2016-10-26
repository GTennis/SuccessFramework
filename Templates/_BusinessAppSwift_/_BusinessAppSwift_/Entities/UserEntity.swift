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
    var addressOptional: String! {get set}
    var zipCode: String! {get set}
    var countryCode: String! {get set}
    var stateCode: String! {get set}
    var city: String! {get set}
    var phone: String! {get set}
    var email: String! {get set}
    var password: String! {get set}
}

class UserEntity: UserEntityProtocol {

    // MARK: UserEntityProtocol
    
    var userId: String!
    var token: String?
    var salutation: String!
    var firstName: String!
    var lastName: String!
    var address: String!
    var addressOptional: String!
    var zipCode: String!
    var countryCode: String!
    var stateCode: String!
    var city: String!
    var phone: String!
    var email: String!
    var password: String!
    
    required init(dict: Dictionary <String, AnyObject>) {
        
        userId = dict[kUserUserIdKey] as! String!
        salutation = dict[kUserSalutationKey] as! String!
        firstName = dict[kUserFirstNameKey] as! String!
        lastName = dict[kUserLastNameKey] as! String!
        address = dict[kUserAddressKey] as! String!
        addressOptional = dict[kUserAddressOptionalKey] as! String!
        zipCode = dict[kUserZipCodeKey] as! String!
        city = dict[kUserCityKey] as! String!
        countryCode = dict[kUserCountryCodeKey] as! String!
        stateCode = dict[kUserStateCodeKey] as! String!
        phone = dict[kUserPhoneKey] as! String!
        email = dict[kUserEmailKey] as! String!
        
        token = dict[kUserTokenKey] as! String?
    }
    
    func serializedDict()-> Dictionary <String, AnyObject>? {
        
        var dict:Dictionary <String, AnyObject>? = Dictionary()

        // dict? unwraps dictionary into value, and then ? (Optional chaining) makes sure setValue on dictionary is called when dict is not nill only.
        
        dict?[kUserUserIdKey] = userId as AnyObject?
        dict?[kUserSalutationKey] = salutation as AnyObject?
        dict?[kUserFirstNameKey] = firstName as AnyObject?
        dict?[kUserLastNameKey] = lastName as AnyObject?
        dict?[kUserAddressKey] = address as AnyObject?
        dict?[kUserAddressOptionalKey] = addressOptional as AnyObject?
        dict?[kUserZipCodeKey] = zipCode as AnyObject?
        dict?[kUserCityKey] = city as AnyObject?
        dict?[kUserCountryCodeKey] = countryCode as AnyObject?
        dict?[kUserStateCodeKey] = stateCode as AnyObject?
        dict?[kUserPhoneKey] = phone as AnyObject?
        dict?[kUserEmailKey] = email as AnyObject?
        dict?[kUserPasswordKey] = password as AnyObject?
        
        return dict;
    }
}
