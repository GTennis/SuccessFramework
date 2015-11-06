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

#pragma mark - Protected -

- (void)commonInit {
    
    [super commonInit];
    
    _user = [[UserObject alloc] init];
}

#pragma mark - Public -

- (NSError *)validateData {
    
    NSError *result = nil;
    
    if (![_user.email isMailValid]) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadUsernameKey)}];
        
    } else if (![_user.email isPasswordValid]) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadPasswordKey)}];
        
    } else if (!_user.salutation) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadSalutationKey)}];
        
    } else if (!_user.firstName) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadFirstNameKey)}];
        
    } else if (!_user.lastName) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadLastNameKey)}];
        
    } else if (!_user.address) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadAddressKey)}];
        
    } else if (!_user.addressOptional) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadAddressOptionalKey)}];
        
    } else if (!_user.zipCode) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadZipCodeKey)}];
        
    } else if (!_user.countryCode) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadCountryCodeKey)}];
        
    } else if (!_user.stateCode) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadStateCodeKey)}];
        
    } else if (!_user.city) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadCityKey)}];
        
    } else if (!_user.phone) {
        
        result = [NSError errorWithDomain:kEmptyString code:1 userInfo:@{NSLocalizedDescriptionKey:GMLocalizedString(kUserSignUpModelBadPhoneKey)}];
        
    }
    
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
    
    [self.userManager signUpUserWithData:_user callback:callback];
}

@end
