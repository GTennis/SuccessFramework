//
//  UIView+Colors.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Colors)

// For setting style on UI views via user runtime attributes in interface builder
@property (nonatomic, strong) NSString *backgroundColorName;
@property (nonatomic, strong) NSString *labelTitleColorName;
@property (nonatomic, strong) NSString *buttonTitleColorName;

// Helpers
- (BOOL)color:(UIColor *)color isEqualToColor:(UIColor *)otherColor;
- (UIImage *)imageWithColor:(UIColor *)color;

@end
