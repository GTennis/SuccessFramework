//
//  Registry.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Registry : NSObject

@property (nonatomic, strong) NSMutableDictionary *registeredObjects;

// Singleton
+ (Registry *)sharedRegistry;

- (void)registerObject:(id)object;
- (void)unRegisterObject:(id)object;
- (id)getObject:(id)object;

@end
