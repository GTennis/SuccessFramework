//
//  NSDictionary+JSON.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NSDictionary+JSON.h"
#import "NSArray+JSON.h"

@implementation NSDictionary (JSON)

- (NSDictionary *)dictionaryByRemovingAndReplacingNulls {

    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary:self];

    for (NSString *key in self) {

        id object = [self objectForKey:key];

        if ([object isKindOfClass:[NSNull class]]) {

            [replaced removeObjectForKey:key];

        } else if ([object isKindOfClass:[NSDictionary class]]) {

            replaced[key] = [object dictionaryByRemovingAndReplacingNulls];
            
        } else if ([object isKindOfClass:[NSArray class]]) {
            
            replaced[key] = [object arrayByRemovingAndReplacingNulls];
        }
    }
    return replaced;
}

@end
