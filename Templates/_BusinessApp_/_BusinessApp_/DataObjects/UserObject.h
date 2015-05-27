//
//  UserObject.h
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
