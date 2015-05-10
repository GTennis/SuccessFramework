//
//  OrderItemObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "OrderItemObject.h"

@implementation OrderItemObject

+ (id)objectWithDictionary:(NSDictionary *)dict; {
    
    if (!dict) {
        
        return nil;
    }
    
    OrderItemObject *orderItem = [[OrderItemObject alloc] init];
    
    // Assign property values
    // ...
    
    return orderItem;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"orderItemId: %@, title: %@, gaSkuCode: %@, quantity: %@, price: %@, currencyCode: %@", _orderItemId, _title, _gaSkuCode, _quantity, _price, _currencyCode];
}

@end
