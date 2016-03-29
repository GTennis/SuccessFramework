//
//  NormalCheckbox.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 11/22/15.
//  Copyright © 2015 Gytenis Mikulėnas 
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

#import "NormalCheckbox.h"

@interface NormalCheckbox () {
    
}

@end

@implementation NormalCheckbox

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)setIsOn:(BOOL)isOn {
    
    _isOn = isOn;
    
    [self setIconWithState:isOn];
}

- (void)setIsIconOnLeftSide:(BOOL)isIconOnLeftSide {
    
    if (!isIconOnLeftSide) {
        
        [self moveImageToRightSide];
    }
}

#pragma mark - Protected -

- (void)commonInit {
    
    //self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self setIconWithState:_isOn];
    
    [self setIsIconOnLeftSide:self.isIconOnLeftSide];
    
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
}

- (BOOL)isIconOnLeftSide {
    
    return NO;
}

- (UIColor *)titleColor {
    
    return kColorBlue;
}

- (UIColor *)selectedTitleColor {
    
    return kColorGreen;
}

- (UIEdgeInsets)titleEdgeInsets {
    
    return UIEdgeInsetsMake(3.0f, 5.0f, 0, 0);
}

#pragma mark - Private -

- (void)setIconWithState:(BOOL)isOn {
    
    UIImage *image = nil;
    
    if (isOn) {
        
        image = [UIImage imageNamed:@"iconCheckboxOn"];
        
        [self setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
        
    } else {
        
        image = [UIImage imageNamed:@"iconCheckboxOff"];
        
        [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    }
    
    [self setImage:image forState:UIControlStateNormal];
    //[self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)buttonPressed {
    
    self.isOn = !self.isOn;
    
    [_delegate normalCheckbox:self didSelectValue:@(_isOn)];
}

- (void)moveImageToRightSide {
    
    // TODO...
}

@end
