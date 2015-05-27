//
//  UIView+Autolayout.h
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
