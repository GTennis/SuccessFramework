//
//  UILabel+Styling.m
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

#import "UILabel+Styling.h"

@implementation UILabel (Styling)

- (void)applyBoldStyleWithSubstring:(NSString *)substring {
    
    [self applyAttributesWithSubstring:substring attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]}];
}

- (void)applyUnderlineStyleWithSubstring:(NSString *)substring {
    
    [self applyAttributesWithSubstring:substring attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
}

- (void)applyColorWithSubstring:(NSString *)substring color:(UIColor *)color {
    
    [self applyAttributesWithSubstring:substring attributes:@{NSForegroundColorAttributeName: color}];
}

#pragma mark - Private

- (void)applyAttributesWithSubstring:(NSString *)substring attributes:(NSDictionary *)attributes {
    
    // Check if object supports attributed strings
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        
        return;
    }
    
    // Extract attributed string
    NSMutableAttributedString *attributedText = nil;
    
    if (self.attributedText) {
        
        attributedText = [self.attributedText mutableCopy];
        
    } else {
        
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    // Find substring location
    NSRange range = [self.text rangeOfString:substring];
    
    // Extract current attributes
    NSMutableDictionary *mutableAttributes = [self attributesFromAttributedString:attributedText range:range];
    
    // Add new attributes
    [mutableAttributes addEntriesFromDictionary:attributes];
    
    // Set style
    [attributedText setAttributes:mutableAttributes range:range];
    
    // Set new attributed string
    self.attributedText = attributedText;
}

- (NSMutableDictionary *)attributesFromAttributedString:(NSMutableAttributedString *)attributedString range:(NSRange)range {
    
    __block NSMutableDictionary *mutableAttributes = nil;
    [attributedString enumerateAttributesInRange:range options:NSAttributedStringEnumerationReverse usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         
         mutableAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
     }];
    
    return mutableAttributes;
}

@end