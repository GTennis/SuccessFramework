//
//  CrashManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/14/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "CrashManager.h"
//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>

#define kCrashlyticsAPIKey @"304f198c97952f6b448f445fee4789a89fd427b2"
#define kCrashlyticsMaxNumberOfActions 10

//---------- Log object -----------//

@interface CrashlyticsLogAction : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *date;

@end

@implementation CrashlyticsLogAction

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@: %@",
            _title,
            _date];
}

@end

//---------- Manager -----------//

@interface CrashManager () {
    
    NSMutableArray *_actionsArray;
}

@end

@implementation CrashManager

@synthesize maxAllowedStoredActionsCount;

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
#ifndef DEBUG
        
        [Fabric with:@[CrashlyticsKit]];
        
        // Will only track crashes on production builds
        //[Crashlytics startWithAPIKey:[self apiKey]];
#endif
        
#ifdef ENTERPRISE_BUILD
        
        // Mark the build is made for internal testing (Enterprise build)
        [Crashlytics setIntValue:1 forKey:@"isEnterpriseBuild"];
#endif
        
        _actionsArray = [[NSMutableArray alloc] initWithCapacity:self.maxAllowedStoredActionsCount];
    }
    return self;
}

// For auction tracking
- (void)setCurrentAuctionId:(NSString *)auctionId title:(NSString *)title {
    
    NSString *logValue = [NSString stringWithFormat:@"auctionId: %@, title: %@", auctionId, title];
    [self logCustomAction:logValue];
}

- (NSString *)apiKey {
    
    return kCrashlyticsAPIKey;
}

- (NSInteger)maxAllowedStoredActionsCount {
    
    return kCrashlyticsMaxNumberOfActions;
}

#pragma mark - Helpers

// Allows to log any custom action. Stores history.
- (void)logScreenAction:(NSString *)actionString {
    
    // Remove last item if exceeded max stored action count
    if (_actionsArray.count > self.maxAllowedStoredActionsCount) {
        
        // Remove the most old log record
        [_actionsArray removeObjectAtIndex:0];
    }
    
    // Create new action object
    CrashlyticsLogAction *action = [[CrashlyticsLogAction alloc] init];
    action.title = actionString;
    action.date = [NSDate date];
    
    // Add action object
    [_actionsArray addObject:action];
    
    // Store log
    //[Crashlytics setObjectValue:_actionsArray forKey:@"ControllerNavigationHistory"];
}

- (void)logCustomAction:(NSString *)actionString {
    
    //[Crashlytics setObjectValue:actionString forKey:@"lastUsedAuctionItem"];
}

- (void)setUserHasLoggedIn:(BOOL)isLoggedIn {
    
    //[Crashlytics setIntValue:isLoggedIn forKey:@"isLoggedIn"];
}

- (void)setUserLanguage:(NSString *)language {
    
    //[Crashlytics setObjectValue:language forKey:@"userLanguage"];
}

- (void)crash {
    
    //[[Crashlytics sharedInstance] crash];
}

@end
