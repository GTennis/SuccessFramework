//
//  BaseLabel.m
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

#import "BaseLabel.h"

@implementation BaseLabel

#pragma mark - Public -

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self commonInit];
}

#pragma mark - Protected -

- (void)commonInit {
    
    self.font = [UIFont fontWithName:self.font.fontName size:self.labelTextSize];
    self.textColor = self.labelTextColor;
    
    self.fontType = self.labelTextFontType;
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    if (!self.lineSpacing) {
        
        return;
    }
    
    // Apply line size if needed
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSpacing;
    paragraphStyle.alignment = self.textAlignment;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle};
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    self.attributedText = attributedText;
}

/*- (void)drawTextInRect:(CGRect)rect {
 
    UIEdgeInsets insets = {40.0f, kLabelTextLeftOffset, 0, 40.0f};
 
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}*/

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    UIEdgeInsets insets = self.insets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

#pragma mark CustomizableLabel

// Default style for labels

- (UIEdgeInsets)insets {
    
    CGFloat marginSize = 8.0f;
    
    UIEdgeInsets insets = {marginSize, marginSize, marginSize, marginSize};
    
    return insets;
}

- (NSString *)labelTextFontType {
    
    return kFontNormalType;
}

- (CGFloat)labelTextSize {
    
    return 15.0f;
}

- (UIColor *)labelTextColor {
    
    return kColorBlack;
}

- (CGFloat)lineSpacing {
    
    return 0;
}

@end
