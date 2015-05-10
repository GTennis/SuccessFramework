//
//  CALayer+Border.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)

- (void)setBorderUIColor:(UIColor*)color {
    
    self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor {
    
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
