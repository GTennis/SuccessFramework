//
//  NSArray+JSON.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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