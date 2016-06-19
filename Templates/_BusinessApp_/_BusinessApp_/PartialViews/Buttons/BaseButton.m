//
//  BaseButton.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
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

#import "BaseButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Colors.h"

@implementation BaseButton

#pragma mark - Public -

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

#pragma mark - Protected -

- (void)commonInit {
    
    if (self.cornerRadius) {
        
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
    }
    
    if (self.borderSize) {
        
        self.layer.borderWidth = self.borderSize;
        self.layer.borderColor = [self.borderColor CGColor];
    }
    
    UIView *helperView = [[UIView alloc] init];
    CGFloat bgAlphaDefault = 1.0f;
    CGFloat bgAlphaHighlighted = 0.3f;
    CGFloat bgAlpha = bgAlphaDefault;
    
    // Set style for normal
    [self setTitleColor:self.textNormalColor forState:UIControlStateNormal];
    bgAlpha = ([helperView color:self.backgroundNormalColor isEqualToColor:[UIColor clearColor]]) ? bgAlphaDefault : bgAlphaHighlighted;
    [self setBackgroundImage:[self imageWithColor:self.backgroundNormalColor alpha:1.0f] forState:UIControlStateNormal];
    
    // Use Custom NOT SYSTEM button in IB in order to work UIControlStateHighlighted correctly!!! More info:
    // http://stackoverflow.com/a/22696409/597292
    // Set style for highlighted
    [self setTitleColor:self.textHighlightedColor forState:UIControlStateHighlighted];
    bgAlpha = ([helperView color:self.backgroundHighlightedColor isEqualToColor:[UIColor clearColor]]) ? bgAlphaDefault : bgAlphaHighlighted;
    [self setBackgroundImage:[self imageWithColor:self.backgroundHighlightedColor alpha:bgAlpha] forState:UIControlStateHighlighted];
    
    // Set style for disabled
    [self setTitleColor:self.textDisabledColor forState:UIControlStateDisabled];
    bgAlpha = ([helperView color:self.backgroundDisabledColor isEqualToColor:[UIColor clearColor]]) ? bgAlphaDefault : bgAlphaHighlighted;
    [self setBackgroundImage:[self imageWithColor:self.backgroundDisabledColor alpha:1.0f] forState:UIControlStateDisabled];
    
    UIFont *font = [UIFont fontWithName:self.fontName size:self.fontSize];
    [self.titleLabel setFont:font];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self commonInit];
}

// http://stackoverflow.com/a/17806333/597292
- (CGSize)intrinsicContentSize {
    
    CGSize s = [super intrinsicContentSize];
    s.height = 50.0f;
    
    return CGSizeMake(s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
    
}

#pragma mark Default style

- (CGFloat)borderSize {
    
    return 1.0f;
}

- (UIColor *)borderColor {
    
    return kColorBlack;
}

- (CGFloat)cornerRadius {
    
    return 0;
}

- (UIColor *)backgroundNormalColor {
    
    return [UIColor greenColor];
}

- (UIColor *)textNormalColor {
    
    return kColorBlack;
}

- (UIColor *)backgroundHighlightedColor {
    
    return [UIColor clearColor];
}

- (UIColor *)textHighlightedColor {
    
    return kColorBlack;
}

- (UIColor *)backgroundDisabledColor {
    
    return [UIColor clearColor];
}

- (UIColor *)textDisabledColor {
    
    return kColorGrayLight;
}

- (NSString *)fontName {
    
    return kFontNormal;
}

- (CGFloat)fontSize {
    
    return 20.0f;
}

@end
