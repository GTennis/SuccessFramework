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

// Add width and height
- (void)viewAddWidth:(CGFloat)width;
- (void)viewAddHeight:(CGFloat)height;

// Add center and fullsize alignment
- (void)viewCenterInsideContainerView:(UIView *)containerView;
- (void)viewMakeFullWidthAndHeightInsideContainerView:(UIView *)containerView;

// Add superView alignment
- (void)viewAddLeadingSpace:(CGFloat)leadingSpace containerView:(UIView *)containerView;
- (void)viewAddTrailingSpace:(CGFloat)trailingSpace containerView:(UIView *)containerView;
- (void)viewAddTopSpace:(CGFloat)topSpace containerView:(UIView *)containerView;
- (void)viewAddBottomSpace:(CGFloat)bottomSpace containerView:(UIView *)containerView;

// Pin with next view
- (void)viewAddHorizontalSpace:(CGFloat)horizontalSpace toRightView:(UIView *)rightView containerView:(UIView *)containerView;
- (void)viewAddVerticalSpace:(CGFloat)verticalSpace toBottomView:(UIView *)bottomView containerView:(UIView *)containerView;

@end
