//
//  CrashManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/14/14.
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

#import "CrashManager.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#define kCrashlyticsAPIKey @"yourKey"
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

#pragma mark - Public -

- (instancetype)init {
    
    self = [super init];
    if (self) {

#ifdef DEBUG
       
        // Mark the build is made for internal testing (Enterprise build)
        [Crashlytics setIntValue:1 forKey:@"isDebugBuild"];
        
#else
      
        [Fabric with:@[CrashlyticsKit]];
        
#endif
        
        _actionsArray = [[NSMutableArray alloc] initWithCapacity:self.maxAllowedStoredActionsCount];
    }
    return self;
}

#pragma mark - CrashManagerProtocol -

- (NSString *)apiKey {
    
    return kCrashlyticsAPIKey;
}

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
    [Crashlytics setObjectValue:_actionsArray forKey:@"ControllerNavigationHistory"];
}

- (void)logCustomAction:(NSString *)actionString {
    
    [Crashlytics setObjectValue:actionString forKey:@"lastUsedItem"];
}

- (void)setUserHasLoggedIn:(BOOL)isLoggedIn {
    
    [Crashlytics setIntValue:isLoggedIn forKey:@"isLoggedIn"];
}

- (void)setUserLanguage:(NSString *)language {
    
    [Crashlytics setObjectValue:language forKey:@"userLanguage"];
}

- (void)crash {
    
    [[Crashlytics sharedInstance] crash];
}

#pragma mark - Private -

- (NSInteger)maxAllowedStoredActionsCount {
    
    return kCrashlyticsMaxNumberOfActions;
}

@end
