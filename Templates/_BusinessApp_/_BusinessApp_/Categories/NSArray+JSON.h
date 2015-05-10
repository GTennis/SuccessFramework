//
//  NSArray+JSON.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSON)

- (NSArray *)arrayByRemovingAndReplacingNulls;

@end