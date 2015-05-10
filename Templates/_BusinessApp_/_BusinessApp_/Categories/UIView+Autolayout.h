//
//  UIView+Autolayout.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//
//  For creating manual views with manual auto layout constraints from code
//

#import <UIKit/UIKit.h>

@interface UIView (Autolayout)

+ (id)autolayoutView;

- (void)viewCenterInsideContainerView:(UIView *)containerView;
- (void)viewMakeFullWidthAndHeightInsideContainerView:(UIView *)containerView;

- (void)viewAddLeadingSpace:(CGFloat)leadingSpace containerView:(UIView *)containerView;
- (void)viewAddTrailingSpace:(CGFloat)trailingSpace containerView:(UIView *)containerView;
- (void)viewAddTopSpace:(CGFloat)topSpace containerView:(UIView *)containerView;
- (void)viewAddBottomSpace:(CGFloat)bottomSpace containerView:(UIView *)containerView;

@end
