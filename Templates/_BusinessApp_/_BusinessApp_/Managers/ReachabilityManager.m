//
//  ReachabilityManager.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/23/14.
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

#import "ReachabilityManager.h"
#import "GMObserverList.h"
#import <AFNetworkReachabilityManager.h>
#import "ReachabilityManagerObserver.h"

@interface ReachabilityManager () {
    
    GMObserverList *_observers;
}

@end

@implementation ReachabilityManager

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public -

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _observers = [[GMObserverList alloc] initWithObservedSubject:self];
        
        // Listen for app state changes
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // Subscribe to internet dissapearing
        __weak typeof (self) weakSelf = self;
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (![weakSelf isInternetOn]) {
                
                DDLogDebug(@"Internet become off");
                [weakSelf notifyObserversWithInternetDidBecomeOff];
                
            } else {
                
                DDLogDebug(@"Internet become on");
                if ([weakSelf isAppActive]) {
                    
                    [weakSelf notifyObserversWithInternetDidBecomeOn];
                }
            }
        }];
    }
    
    return self;
}

#pragma mark - ReachabilityManagerProtocol -

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

#pragma mark - Private -

#pragma mark Application state change handlers

- (void)applicationWillResignActive {
    
    DDLogDebug(@"[%@]: ApplicationWillResignActive", NSStringFromClass([self class]));
    
    [self notifyObserversWithApplicationDidBecomeInactive];
}

- (void)applicationDidBecomeActive {
    
    DDLogDebug(@"[%@]: applicationDidBecomeActive", NSStringFromClass([self class]));
    
    if ([self isInternetOn] && [self isAppActive]) {
        
        [self notifyObserversWithApplicationDidBecomeActive];
    }
}

#pragma mark ReachabilityManagerObservers

- (void)notifyObserversWithApplicationDidBecomeActive {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    if (_observers.observers.count > 0) {
        
        DDLogDebug(@"[%@]: will notify observers", NSStringFromClass([self class]));
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
