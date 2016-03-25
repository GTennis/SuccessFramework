//
//  ButtonWithIconOnRight.m
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

#import "ButtonWithIconOnRight.h"

@implementation ButtonWithIconOnRight

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:18.0f];
    [self setTitleColor:kColorBlue forState:UIControlStateNormal];
    self.fontType = kFontNormalType;

    // Used from: http://stackoverflow.com/a/22621613/597292
    [self moveImageToRightSide];
    
    [self setEnabled:self.isEnabled];
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    if (enabled) {
        
        [self setTitleColor:kColorBlue forState:UIControlStateNormal];
        
    } else {
        
        [self setTitleColor:kColorGray forState:UIControlStateNormal];
    }
}

// http://stackoverflow.com/a/25277016/597292
- (void)moveImageToRightSide {
    
    [self sizeToFit];
    
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat gapWidth = self.frame.size.width - titleWidth - imageWidth;
    self.titleEdgeInsets = UIEdgeInsetsMake(self.titleEdgeInsets.top,
                                            -imageWidth + self.titleEdgeInsets.left,
                                            self.titleEdgeInsets.bottom,
                                            imageWidth - self.titleEdgeInsets.right);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(self.imageEdgeInsets.top,
                                            titleWidth + self.imageEdgeInsets.left + gapWidth,
                                            self.imageEdgeInsets.bottom,
                                            -titleWidth + self.imageEdgeInsets.right - gapWidth);
}

@end
