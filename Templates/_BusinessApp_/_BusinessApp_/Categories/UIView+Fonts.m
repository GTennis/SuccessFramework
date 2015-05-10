//
//  UIView+Fonts.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
