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
    
    // Set style for normal
    [self setTitleColor:self.textNormalColor forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:self.backgroundNormalColor] forState:UIControlStateNormal];
    
    // Set style for highlighted
    [self setTitleColor:self.textHighlightedColor forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self imageWithColor:self.backgroundHighlightedColor] forState:UIControlStateHighlighted];
    
    // Set style for disabled
    [self setTitleColor:self.textDisabledColor forState:UIControlStateDisabled];
    [self setBackgroundImage:[self imageWithColor:self.backgroundDisabledColor] forState:UIControlStateDisabled];
    
    UIFont *font = [UIFont fontWithName:self.fontName size:self.fontSize];
    [self.titleLabel setFont:font];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self commonInit];
}

@end
