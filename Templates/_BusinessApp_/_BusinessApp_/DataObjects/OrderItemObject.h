//
//  OrderItemObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItemObject : NSObject

@property (nonatomic, copy) NSString *orderItemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *gaSkuCode;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *currencyCode;

+ (id)objectWithDictionary:(NSDictionary *)dict;

@end
