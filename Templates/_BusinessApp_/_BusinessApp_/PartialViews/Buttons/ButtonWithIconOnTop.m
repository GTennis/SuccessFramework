//
//  ButtonWithIconOnTop.m
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

#import "ButtonWithIconOnTop.h"

@implementation ButtonWithIconOnTop

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:15.0f];
    [self setTitleColor:kColorWhite forState:UIControlStateNormal];
    self.fontType = kFontNormalType;
    
    [self setEnabled:self.isEnabled];
}

// Used from: http://stackoverflow.com/a/22621613/597292
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self centerVertically];
}

- (void)setEnabled:(BOOL)enabled {

    [super setEnabled:enabled];
    
    if (enabled) {
        
        [self setTitleColor:kColorWhite forState:UIControlStateNormal];
        
    } else {
        
        [self setTitleColor:kColorGray forState:UIControlStateNormal];
    }
}

- (void)centerVerticallyWithPadding:(float)padding {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
}


- (void)centerVertically {
    
    const CGFloat kDefaultPadding = 0; //6.0f;
    
    [self centerVerticallyWithPadding:kDefaultPadding];
}

@end
