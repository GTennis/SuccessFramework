//
//  OrderItemObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ParsableObject.h"

#define kOrderItemIdKey @"itemId"
#define kOrderItemTitleKey @"title"
#define kOrderItemTrackingCodeKey @"trackingCode"
#define kOrderItemQuantityKey @"quantity"
#define kOrderItemPriceKey @"price"
#define kOrderItemCurrencyKey @"currency"

@protocol OrderItemObject <ParsableObject>

@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *trackingCode;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *currency;

@end

@interface OrderItemObject : NSObject <OrderItemObject>

@end
