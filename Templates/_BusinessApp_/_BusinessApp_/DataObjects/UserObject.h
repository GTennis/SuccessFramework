//
//  UserObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ParsableObject.h"

#define kUserUserIdKey @"userId"
#define kUserTokenKey @"token"
#define kUserSalutationKey @"salutation"
#define kUserFirstNameKey @"firstName"
#define kUserLastNameKey @"lastName"
#define kUserAddressKey @"address"
#define kUserAddressOptionalKey @"addressOptional"
#define kUserZipCodeKey @"zipCode"
#define kUserCountryCodeKey @"countryCode"
#define kUserStateCodeKey @"stateCode"
#define kUserCityKey @"city"
#define kUserEmailKey @"email"
#define kUserPhoneKey @"phone"

@protocol UserObject <ParsableObject>

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *salutation;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *addressOptional;
@property (nonatomic, strong) NSNumber *zipCode;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *stateCode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;

@end

@interface UserObject : NSObject <UserObject>

@end
