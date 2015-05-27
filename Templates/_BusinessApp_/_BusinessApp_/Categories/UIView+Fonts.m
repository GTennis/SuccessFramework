//
//  UIView+Fonts.m
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

#import "UIView+Fonts.h"

@implementation UIView (Fonts)

- (NSString *)fontType {
    
    NSString *fontType = nil;
    
    // For UILabels
    if ([self isKindOfClass:[UILabel class]]) {
        
        UILabel *label = (UILabel *)self;
        fontType = label.font.fontName;
    
    // For UITextFields
    } else if ([self isKindOfClass:[UITextField class]]) {
        
        UITextField *textField = (UITextField *)self;
        fontType = textField.font.fontName;
    
    // For UIButtons
    } else if ([self isKindOfClass:[UIButton class]]) {
        
        UIButton *button = (UIButton *)self;
        fontType = button.titleLabel.font.fontName;
    }
    
    return fontType;
}

- (void)setFontType:(NSString *)fontType {
    
    // For UILabels
    if ([self isKindOfClass:[UILabel class]]) {
        
        UILabel *label = (UILabel *) self;
        label.font = [UIFont fontWithName:[self fontForType:fontType] size:label.font.pointSize];
      
    // For UITextFields
    } else if ([self isKindOfClass:[UITextField class]]) {
        
        UITextField *textField = (UITextField *)self;
        textField.font = [UIFont fontWithName:[self fontForType:fontType] size:textField.font.pointSize];
        
    // For UIButtons
    } else if ([self isKindOfClass:[UIButton class]]) {
        
        UIButton *button = (UIButton *)self;
        button.titleLabel.font = [UIFont fontWithName:[self  fontForType:fontType] size:button.titleLabel.font.pointSize];
    }
}

- (NSString *)fontForType:(NSString *)fontType {
    
    NSString *font = nil;
    
    if ([fontType isEqualToString:kFontBoldType]) {
        
        font = kFontBold;
        
    } else if ([fontType isEqualToString:kFontNormalType]) {
        
        font = kFontNormal;
    }
    
    return font;
}

@end
