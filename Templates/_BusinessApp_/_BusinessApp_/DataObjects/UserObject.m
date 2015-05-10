//
//  UserObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
