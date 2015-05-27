//
//  OrderObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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
#import "OrderItemObject.h"

#define kOrderIdKey @"orderId"
#define kOrderPaymentTypeKey @"paymentType"
#define kOrderTotalKey @"total"
#define kOrderTaxKey @"tax"
#define kOrderShippingKey @"shipping"
#define kOrderCurrency @"currency"

#define kOrderItemsKey @"items"

@protocol OrderObject <ParsableObject>

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *paymentTypeString;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *tax;
@property (nonatomic, strong) NSNumber *shipping;
@property (nonatomic, copy) NSString *currency;

@property (nonatomic, strong) NSArray <OrderItemObject> *list;

@end

@interface OrderObject : NSObject <OrderObject>

@end
