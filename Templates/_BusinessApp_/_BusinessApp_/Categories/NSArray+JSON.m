//
//  NSArray+JSON.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NSArray+JSON.h"
#import "NSDictionary+JSON.h"

@implementation NSArray (JSON)

- (NSArray *)arrayByRemovingAndReplacingNulls {
    
    NSMutableArray *replaced = [NSMutableArray arrayWithArray:self];
    
    for (NSObject *object in self) {
        
        if ([object isKindOfClass:[NSNull class]]) {
            
            [replaced removeObject:object];
            
        } else if ([object isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *replacedDict = [(NSDictionary *)object dictionaryByRemovingAndReplacingNulls];
            NSInteger index = [replaced indexOfObject:object];
            [replaced replaceObjectAtIndex:index withObject:replacedDict];
            
        } else if ([object isKindOfClass:[NSArray class]]) {
            
            NSArray *replacedArray = [(NSArray *)object arrayByRemovingAndReplacingNulls];
            NSInteger index = [replaced indexOfObject:object];
            [replaced replaceObjectAtIndex:index withObject:replacedArray];
        }
    }
    return replaced;
}

@end