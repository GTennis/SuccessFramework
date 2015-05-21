//
//  AnalyticsManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/24/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "AnalyticsManager.h"

#define kGoogleAnalyticsDevelopmentTrackerId @"DevTrackingId"
#define kGoogleAnalyticsProductionTrackerId @"ProdTrackingId"
#define kGoogleAnalyticsDataSendingInterval 120.0f

#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "OrderObject.h"
#import "OrderItemObject.h"

@interface AnalyticsManager() {
    
    id <GAITracker> _defaultTracker;
    NSString *_logSession;
}

@end

@implementation AnalyticsManager

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        NSString *trackingId = nil;
        
#if defined(ENTERPRISE_BUILD) || defined(DEBUG)
        trackingId = kGoogleAnalyticsDevelopmentTrackerId;
#else
        trackingId = kGoogleAnalyticsProductionTrackerId;
#endif
        
        _defaultTracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
        
        [GAI sharedInstance].dispatchInterval = kGoogleAnalyticsDataSendingInterval;
        
        // Optional: set Logger to VERBOSE for debug information.
        // Will also try to track additional information regarding errors
        //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose/*kGAILogLevelError*/];
    }
    return self;
}

- (void)startSession {
    
    [_defaultTracker set:kGAISessionControl value:@"start"];
}

- (void)endSession {
    
    [_defaultTracker set:kGAISessionControl value:@"end"];
}

- (void)logScreen:(NSString *)screeName {
    if (screeName.length){
        
        GALog(@"%@", screeName);
        
        [_defaultTracker set:kGAIScreenName value:screeName];
        [_defaultTracker send:[[GAIDictionaryBuilder createScreenView] build]];
    }
}

#pragma mark - Custom action loggin


/*- (void)logPurchaseItem:(OrderItemObject *)item transactionId:(NSString *)transactionId {
 
 if (item && transactionId.length) {
 
 GALog(@"logPurchasedItem:%@", item.title);
 
 [_defaultTracker send:[[GAIDictionaryBuilder createItemWithTransactionId:transactionId
 name:item.title
 sku:item.gaSkuCode
 category:nil
 price:item.price
 quantity:item.quantity
 currencyCode:item.currencyCode] build]];
 }
 }
 
 - (void)logPurchaseOrder:(OrderObject *)order transactionId:(NSString *)transactionId{
 if (order && transactionId.length) {
 
 GALog(@"logPurchaseOrder");
 
 // We can use Paypal | CreditCard | or other payment type value for affiliation param
 [_defaultTracker send:[[GAIDictionaryBuilder createTransactionWithId:transactionId
 affiliation:order.paymentTypeString
 revenue:order.total
 tax:order.tax
 shipping:order.shipping
 currencyCode:order.currencyCode] build]];
 }
 }*/

#pragma mark - Helpers

- (void)logEventWithCategory:(NSString *)category action:(NSString *)action title:(NSString *)title value:(NSNumber *)value {
    
    if (category.length && action.length) {
        
        GALog(@"%@:%@:%@:%@", category, action, title, value);
        
        [_defaultTracker send:[[GAIDictionaryBuilder createEventWithCategory:category        // Event category (required)
                                                                      action:action          // Event action   (required)
                                                                       label:title           // Event label
                                                                       value:value] build]]; // Event value
    }
}

@end
