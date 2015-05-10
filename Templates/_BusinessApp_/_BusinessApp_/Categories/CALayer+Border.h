//
//  CALayer+Border.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Border)

// Interface builder does not allow to pass CGColor, so need to make proxy property for using in IB, in runtime attributes when setting border color
@property (nonatomic, strong) UIColor *borderUIColor;

@end
