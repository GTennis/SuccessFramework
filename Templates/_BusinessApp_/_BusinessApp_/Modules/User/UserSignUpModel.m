//
//  UserSignUpModel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
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

#import "UserSignUpModel.h"
#import "NSString+Validator.h"

@implementation UserSignUpModel

#pragma mark - Protected methods

- (void)commonInit {
    
    [super commonInit];
    
    _user = [[UserObject alloc] init];
}

#pragma mark - Public methods

- (BOOL)isValidData {
    
    BOOL isEmailValid = [_user.email isMailValid];
    BOOL result = isEmailValid;
    
    BOOL isPasswordValid = [_user.email isPasswordValid];
    result &= isPasswordValid;
    
    BOOL isSalutationValid = _user.salutation ? YES : NO;
    result &= isSalutationValid;
    
    BOOL isFirstNameValid = _user.firstName ? YES : NO;
    result &= isFirstNameValid;
    
    BOOL isLastNameValid = _user.lastName ? YES : NO;
    result &= isLastNameValid;
    
    BOOL isAddressValid = _user.address ? YES : NO;
    result &= isAddressValid;
    
    BOOL isAddressOptionalValid = _user.addressOptional ? YES : NO;
    result &= isAddressOptionalValid;
    
    BOOL isZipCodeValid = _user.zipCode ? YES : NO;
    result &= isZipCodeValid;
    
    BOOL isCountryCodeValid = _user.countryCode ? YES : NO;
    result &= isCountryCodeValid;
    
    BOOL isStateCodeValid = _user.stateCode ? YES : NO;
    result &= isStateCodeValid;
    
    BOOL isCityValid = _user.city ? YES : NO;
    result &= isCityValid;
    
    BOOL isPhoneValid = _user.phone ? YES : NO;
    result &= isPhoneValid;

    return result;
}

- (void)clearData {
    
    _user = [[UserObject alloc] init];
}

- (void)updateModelWithData:(UserObject *)user {
    
    _user.salutation = user.salutation;
    _user.firstName = user.firstName;
    _user.lastName = user.lastName;
    _user.address = user.firstName;
    _user.addressOptional = user.address;
    _user.zipCode = user.addressOptional;
    _user.countryCode = user.countryCode;
    _user.stateCode = user.stateCode;
    _user.city = user.city;
    _user.phone = user.phone;
    _user.email = user.email;
    _user.password = user.password;
}

- (void)signUp:(Callback)callback {
    
    // TODO...
    
    callback(YES, nil, nil);
}

@end
