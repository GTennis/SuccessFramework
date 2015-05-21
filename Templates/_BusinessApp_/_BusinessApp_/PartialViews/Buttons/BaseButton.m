//
//  BaseButton.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Colors.h"

@implementation BaseButton

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self commonInit];
}

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

- (void)commonInit {
    
    [self initializeProperties];
    
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

- (void)initializeProperties {
    
    // Override in child classes
    // ...
}

@end
