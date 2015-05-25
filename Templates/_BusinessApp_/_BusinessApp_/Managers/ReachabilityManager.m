//
//  ReachabilityManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/23/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ReachabilityManager.h"
#import "GMObserverList.h"
#import <AFNetworkReachabilityManager.h>

@interface ReachabilityManager () {
    
    GMObserverList *_observers;
}

@end

@implementation ReachabilityManager

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _observers = [[GMObserverList alloc] initWithObservedSubject:self];
        
        // Listen for app state changes
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        
        // Subscribe to internet dissapearing
        __weak typeof (self) weakSelf = self;
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (![weakSelf isInternetOn]) {
                
                DLog(@"Internet become off");
                [weakSelf notifyObserversWithInternetDidBecomeOff];
                
            } else {
                
                DLog(@"Internet become on");
                if ([weakSelf isAppActive]) {
                    
                    [weakSelf notifyObserversWithInternetDidBecomeOn];
                }
            }
        }];
    }
    
    return self;
}

- (BOOL)isAppActive {
    
    UIApplication *application = [UIApplication sharedApplication];
    
    if (application.applicationState == UIApplicationStateActive) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

- (BOOL)isInternetOn {
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)addServiceObserver:(id<ReachabilityManagerObserver>)observer {
 
    [_observers addObserver:observer];
}

- (void)removeServiceObserver:(id<ReachabilityManagerObserver>)observer {
    
    [_observers removeObserver:observer];
}

#pragma mark - Application state change handlers

- (void)applicationWillResignActive {
    
    DLog(@"[%@]: ApplicationWillResignActive", NSStringFromClass([self class]));
    
    [self notifyObserversWithApplicationDidBecomeInactive];
}

- (void)applicationDidBecomeActive {
    
    DLog(@"[%@]: applicationDidBecomeActive", NSStringFromClass([self class]));
    
    if ([self isInternetOn] && [self isAppActive]) {
        
        [self notifyObserversWithApplicationDidBecomeActive];
    }
}

#pragma mark - ReachabilityManagerObservers

- (void)notifyObserversWithApplicationDidBecomeActive {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    if (_observers.observers.count > 0) {
        
        DLog(@"[%@]: will notify observers", NSStringFromClass([self class]));
    }
    
    [_observers notifyObserversForSelector:@selector(applicationDidBecomeActive)];
    
#pragma clang diagnostic pop
}

- (void)notifyObserversWithApplicationDidBecomeInactive {
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [_observers notifyObserversForSelector:@selector(applicationDidBecomeInactive)];
    
#pragma clang diagnostic pop
}

- (void)notifyObserversWithInternetDidBecomeOn {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [_observers notifyObserversForSelector:@selector(internetDidBecomeOn)];
    
#pragma clang diagnostic pop
}

- (void)notifyObserversWithInternetDidBecomeOff {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    [_observers notifyObserversForSelector:@selector(internetDidBecomeOff)];
    
#pragma clang diagnostic pop
}

@end
