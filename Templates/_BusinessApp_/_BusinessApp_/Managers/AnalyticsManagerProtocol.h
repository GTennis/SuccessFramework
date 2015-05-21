//
//  AnalyticsManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/24/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "AnalyticsManagerConstants.h"

@protocol AnalyticsManagerProtocol

- (void)startSession;
- (void)endSession;
- (void)logScreen:(NSString *)screeName;
//- (void)logEventWithCategory:(NSString *)category action:(NSString *)action title:(NSString *)title value:(NSNumber *)value;
//- (void)logPurchaseItem:(OrderItemObject *)item transactionId:(NSString *)transactionId;
//- (void)logPurchaseOrder:(OrderObject *)order transactionId:(NSString *)transactionId;

// Custom action logging

@end
