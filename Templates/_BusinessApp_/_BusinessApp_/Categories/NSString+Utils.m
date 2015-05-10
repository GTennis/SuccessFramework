//
//  UIView+Colors.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSNumber *)number {
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *number = [format numberFromString:self];
    
    return number;
}

@end
