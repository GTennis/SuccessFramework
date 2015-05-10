//
//  OrderObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "OrderObject.h"

@implementation OrderObject

+ (id)objectWithDictionary:(NSDictionary *)dict; {
    
    if (!dict) {
        
        return nil;
    }
    
    OrderObject *order = [[OrderObject alloc] init];
    
    // Assign property values
    // ...
    
    return order;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"orderId: %@, paymentTypeString: %@, total: %@, tax: %@, shipping: %@, currencyCode: %@", _orderId, _paymentTypeString, _total, _tax, _shipping, _currencyCode];
}

@end
