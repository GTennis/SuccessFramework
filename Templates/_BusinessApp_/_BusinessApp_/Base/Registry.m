//
//  Registry.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "Registry.h"

@implementation Registry

+ (Registry *)sharedRegistry {
    
    static dispatch_once_t pred;
    static Registry *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init];});
    
    return sharedInstance;
}

- (void)registerObject:(id)object {
    
    if (!_registeredObjects) {
        
        _registeredObjects = [[NSMutableDictionary alloc] init];
    }
    
    NSString *key = NSStringFromClass([object class]);
    
    [_registeredObjects setObject:object forKey:key];
}

- (void)unRegisterObject:(id)object {
    
    NSString *key = NSStringFromClass([object class]);
    [_registeredObjects removeObjectForKey:key];
}

- (id)getObject:(id)object {
    
    NSString *key = NSStringFromClass([object class]);
    
    return [_registeredObjects objectForKey:key];
}

@end
