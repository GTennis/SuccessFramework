//
//  UIView+Autolayout.m
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

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)

+ (id)autolayoutView {
    
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

#pragma mark - Add width and height

- (NSLayoutConstraint *)viewAddWidth:(CGFloat)width {

    [self prepareViewForAutolayout];
 
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:width];
    
    [self addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)viewAddHeight:(CGFloat)height {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:height];
    
    [self addConstraint:constraint];
    
    return constraint;
}

#pragma mark - Center and fullsize alignment

- (void)viewCenterInsideContainerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *centerConstraintX =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeCenterX
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeCenterX
     multiplier:1 constant:0];
    
    NSLayoutConstraint *centerConstraintY =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeCenterY
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeCenterY
     multiplier:1 constant:0];
    
    [containerView addConstraints:@[centerConstraintX, centerConstraintY]];
}

- (NSLayoutConstraint *)viewAddCenterHorizontalInsideContainerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *centerConstraintX =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeCenterX
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeCenterX
     multiplier:1 constant:0];
    
    [containerView addConstraint:centerConstraintX];
    
    return centerConstraintX;
}

- (NSLayoutConstraint *)viewAddCenterVerticalInsideContainerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *centerConstraintY =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeCenterY
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeCenterY
     multiplier:1 constant:0];
    
    [containerView addConstraint:centerConstraintY];
    
    return centerConstraintY;
}

- (void)viewMakeFullWidthAndHeightInsideContainerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:0];
    
    NSLayoutConstraint *trailingConstraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeTrailing
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeTrailing
     multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeTop
     multiplier:1 constant:0];
    
    NSLayoutConstraint *bottomConstraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeBottom
     multiplier:1 constant:0];
    
    [containerView addConstraints:@[leadingConstraint, trailingConstraint, topConstraint, bottomConstraint]];
}

#pragma mark - Alignment to superView

- (NSLayoutConstraint *)viewAddLeadingSpace:(CGFloat)leadingSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:leadingSpace];
    
    [containerView addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)viewAddTrailingSpace:(CGFloat)trailingSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeTrailing
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeTrailing
     multiplier:1 constant:trailingSpace];
    
    [containerView addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)viewAddTopSpace:(CGFloat)topSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeTop
     multiplier:1 constant:topSpace];
    
    [containerView addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)viewAddBottomSpace:(CGFloat)bottomSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeBottom
     multiplier:1 constant:bottomSpace];
    
    [containerView addConstraint:constraint];
    
    return constraint;
}

#pragma mark - Pin to other view

- (void)viewAddLeftToView:(UIView *)view horizontalSpace:(CGFloat)horizontalSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, view);
    NSDictionary *metrics = @{@"horizontalSpace":@(horizontalSpace)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[self]-horizontalSpace-[view]" options:0 metrics:metrics views:views];
    
    [containerView addConstraints:constraints];
}

- (void)viewAddRightToView:(UIView *)view horizontalSpace:(CGFloat)horizontalSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, view);
    NSDictionary *metrics = @{@"horizontalSpace":@(horizontalSpace)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-horizontalSpace-[self]" options:0 metrics:metrics views:views];
    
    [containerView addConstraints:constraints];
}

- (void)viewAddBelowOfView:(UIView *)view verticalSpace:(CGFloat)verticalSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, view);
    NSDictionary *metrics = @{@"verticalSpace":@(verticalSpace)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-verticalSpace-[self]" options:0 metrics:metrics views:views];
    
    [containerView addConstraints:constraints];
}

- (void)viewAddOnTopOfView:(UIView *)view verticalSpace:(CGFloat)verticalSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, view);
    NSDictionary *metrics = @{@"verticalSpace":@(verticalSpace)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-verticalSpace-[view]" options:0 metrics:metrics views:views];
    
    [containerView addConstraints:constraints];
}

#pragma mark - Private

- (void)prepareViewForAutolayout {
    
    // Adding a protection in case we forgot to set it
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
