//
//  OrderObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderObject : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *paymentTypeString;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *tax;
@property (nonatomic, strong) NSNumber *shipping;
@property (nonatomic, copy) NSString *currencyCode;

+ (id)objectWithDictionary:(NSDictionary *)dict;

@end
