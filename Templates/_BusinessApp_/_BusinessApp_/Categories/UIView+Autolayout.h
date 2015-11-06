//
//  UIView+Autolayout.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
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
//  For creating manual views with manual auto layout constraints from code
//

#import <UIKit/UIKit.h>

@interface UIView (Autolayout)

+ (id)autolayoutView;

// Add width and height
- (NSLayoutConstraint *)viewAddWidth:(CGFloat)width;
- (NSLayoutConstraint *)viewAddHeight:(CGFloat)height;

// Add center and fullsize alignment
- (void)viewCenterInsideContainerView:(UIView *)containerView;
- (void)viewMakeFullWidthAndHeightInsideContainerView:(UIView *)containerView;
- (NSLayoutConstraint *)viewAddCenterVerticalInsideContainerView:(UIView *)containerView;
- (NSLayoutConstraint *)viewAddCenterHorizontalInsideContainerView:(UIView *)containerView;

// Add superView alignment
- (NSLayoutConstraint *)viewAddLeadingSpace:(CGFloat)leadingSpace containerView:(UIView *)containerView;
- (NSLayoutConstraint *)viewAddTrailingSpace:(CGFloat)trailingSpace containerView:(UIView *)containerView;
- (NSLayoutConstraint *)viewAddTopSpace:(CGFloat)topSpace containerView:(UIView *)containerView;
- (NSLayoutConstraint *)viewAddBottomSpace:(CGFloat)bottomSpace containerView:(UIView *)containerView;

// Pin to other view
- (void)viewAddLeftToView:(UIView *)view horizontalSpace:(CGFloat)horizontalSpace containerView:(UIView *)containerView;
- (void)viewAddRightToView:(UIView *)view horizontalSpace:(CGFloat)horizontalSpace containerView:(UIView *)containerView;
- (void)viewAddBelowOfView:(UIView *)view verticalSpace:(CGFloat)verticalSpace containerView:(UIView *)containerView;
- (void)viewAddOnTopOfView:(UIView *)view verticalSpace:(CGFloat)verticalSpace containerView:(UIView *)containerView;

@end
