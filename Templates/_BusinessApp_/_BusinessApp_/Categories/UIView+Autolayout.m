//
//  UIView+Autolayout.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)

+ (id)autolayoutView {
    
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

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

- (void)viewAddLeadingSpace:(CGFloat)leadingSpace containerView:(UIView *)containerView {
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:leadingSpace];
    
    [containerView addConstraint:constraint];
}

- (void)viewAddTrailingSpace:(CGFloat)trailingSpace containerView:(UIView *)containerView {
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:trailingSpace];
    
    [containerView addConstraint:constraint];
}

- (void)viewAddTopSpace:(CGFloat)topSpace containerView:(UIView *)containerView {
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:topSpace];
    
    [containerView addConstraint:constraint];
}

- (void)viewAddBottomSpace:(CGFloat)bottomSpace containerView:(UIView *)containerView {
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:bottomSpace];
    
    [containerView addConstraint:constraint];
}

#pragma mark - Helpers

- (void)prepareViewForAutolayout {
    
    // Adding a protection in case we forgot to set it
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
