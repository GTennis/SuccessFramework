//
//  ReachabilityManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/23/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

@protocol ReachabilityManagerObserver <NSObject>

@optional

- (void)applicationDidBecomeActive;
- (void)applicationDidBecomeInactive;
- (void)internetDidBecomeOn;
- (void)internetDidBecomeOff;

@end

@protocol ReachabilityManagerProtocol <NSObject>

- (BOOL)isAppActive;
- (void)addServiceObserver:(id<ReachabilityManagerObserver>)observer;
- (void)removeServiceObserver:(id<ReachabilityManagerObserver>)observer;

@end
