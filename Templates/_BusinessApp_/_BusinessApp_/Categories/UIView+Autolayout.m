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

#pragma mark - Add width and height

- (void)viewAddWidth:(CGFloat)width {

    [self prepareViewForAutolayout];
 
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:width];
    
    [self addConstraint:constraint];
}

- (void)viewAddHeight:(CGFloat)height {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:height];
    
    [self addConstraint:constraint];
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

- (void)viewAddLeadingSpace:(CGFloat)leadingSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeLeading
     multiplier:1 constant:leadingSpace];
    
    [containerView addConstraint:constraint];
}

- (void)viewAddTrailingSpace:(CGFloat)trailingSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeTrailing
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeTrailing
     multiplier:1 constant:trailingSpace];
    
    [containerView addConstraint:constraint];
}

- (void)viewAddTopSpace:(CGFloat)topSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeTop
     multiplier:1 constant:topSpace];
    
    [containerView addConstraint:constraint];
}

- (void)viewAddBottomSpace:(CGFloat)bottomSpace containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint
     constraintWithItem:self attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:containerView attribute:NSLayoutAttributeBottom
     multiplier:1 constant:bottomSpace];
    
    [containerView addConstraint:constraint];
}

#pragma mark - Pin with next view

- (void)viewAddHorizontalSpace:(CGFloat)horizontalSpace toRightView:(UIView *)rightView containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, rightView);
    NSDictionary *metrics = @{@"horizontalSpace":@(horizontalSpace)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[self]-horizontalSpace-[rightView]" options:0 metrics:metrics views:views];
    
    [containerView addConstraints:constraints];
}

- (void)viewAddVerticalSpace:(CGFloat)verticalSpace toBottomView:(UIView *)bottomView containerView:(UIView *)containerView {
    
    [self prepareViewForAutolayout];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, bottomView);
    NSDictionary *metrics = @{@"verticalSpace":@(verticalSpace)};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-verticalSpace-[bottomView]" options:0 metrics:metrics views:views];
    
    [containerView addConstraints:constraints];
}

#pragma mark - Helpers

- (void)prepareViewForAutolayout {
    
    // Adding a protection in case we forgot to set it
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
