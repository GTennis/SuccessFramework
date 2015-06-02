//
//  UserObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
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

#import "UserObject.h"

@implementation UserObject

@synthesize userId = _userId;
@synthesize token = _token;
@synthesize salutation = _salutation;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize address = _address;
@synthesize addressOptional = _addressOptional;
@synthesize zipCode = _zipCode;
@synthesize city = _city;
@synthesize countryCode = _countryCode;
@synthesize stateCode = _stateCode;
@synthesize email = _email;
@synthesize phone = _phone;

@synthesize password = _password;

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {

        _userId = dict[kUserUserIdKey];
        _salutation = dict[kUserSalutationKey];
        _firstName = dict[kUserFirstNameKey];
        _lastName = dict[kUserLastNameKey];
        _address = dict[kUserAddressKey];
        _addressOptional = dict[kUserAddressOptionalKey];
        _zipCode = dict[kUserZipCodeKey];
        _city = dict[kUserCityKey];
        _countryCode = dict[kUserCountryCodeKey];
        _stateCode = dict[kUserStateCodeKey];
        _phone = dict[kUserPhoneKey];;
        _email = dict[kUserEmailKey];
    }
    return self;
}

// For serializing object into dictionary for passing json data to backend
- (NSDictionary *)toDict {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    /*[dict setValue:_email forKey:kUserEmailKey];
    [dict setValue:_password forKey:kUserPasswordKey];
    */
    
    return dict;
}

@end
