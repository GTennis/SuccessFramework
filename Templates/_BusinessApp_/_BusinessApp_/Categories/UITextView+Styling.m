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

#import "UITextView+Styling.h"
#import "UITextFieldStylingIvars.h"

@implementation UITextView (Styling)

- (void)applyBoldStyleWithSubstring:(NSString *)substring {
    
    // We already setting this inside applyAttributesWithSubstring:attributes: . However need to set it earlier for setting bold style, otherwise self.font equals nil and it results in ommited string
    // http://stackoverflow.com/a/27612974/597292
    self.selectable = YES;
    
    [self applyAttributesWithSubstring:substring attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]}];
}

- (void)applyUnderlineStyleWithSubstring:(NSString *)substring {
    
    [self applyAttributesWithSubstring:substring attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
}

- (void)applyColorWithSubstring:(NSString *)substring color:(UIColor *)color {
    
    [self applyAttributesWithSubstring:substring attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)addTapGestureWithSubstring:(NSString *)substring callback:(Callback)callback {
    
    // Lazy instantiation
    if (!self.tapGestureSubstringsAndCallbacks) {
        
        self.tapGestureSubstringsAndCallbacks = [[NSMutableDictionary alloc] init];
    }
    
    // http://stackoverflow.com/a/27612974/597292
    // http://stackoverflow.com/a/17122745/597292
    self.scrollEnabled = NO;
    self.selectable = YES;
    
    // Store substring and callback
    [self.tapGestureSubstringsAndCallbacks setValue:callback forKey:substring];
    
    // Create tap gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(substringTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    // Ensure that all existing gesture recognizers are removed
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self removeGestureRecognizer:obj];
    }];

    // Add gesture
    [self addGestureRecognizer:tapGestureRecognizer];
    self.userInteractionEnabled = YES;
    
    // Find substring
    NSRange range = [self.text rangeOfString:substring];
    
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
    
    NSString *identifier = substring;
    
    // Extract current attributes
    NSMutableDictionary *mutableAttributes = [self attributesFromAttributedString:attributedText range:range];
    
    // Add new atribute
    mutableAttributes[identifier] = @(YES);
    
    // Set attributes
    [attributedText setAttributes:mutableAttributes range:range];
    
    // Set new attributed string
    self.attributedText = attributedText;
    
    self.scrollEnabled = YES;
}

#pragma mark - Gesture recognizer selectors

- (void)substringTapped:(UITapGestureRecognizer *)recognizer {
    
    UITextView *textView = (UITextView *)recognizer.view;
    
    // Location of the tap in text-container coordinates
    
    NSLayoutManager *layoutManager = textView.layoutManager;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;
    
    // Find the character that's been tapped on
    
    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location
                                           inTextContainer:textView.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (characterIndex < textView.textStorage.length) {
        
        NSRange range;
        
        for (NSString *key in self.tapGestureSubstringsAndCallbacks) {
            
            Callback callback = self.tapGestureSubstringsAndCallbacks[key];
            
            id value = [self.attributedText attribute:key atIndex:characterIndex effectiveRange:&range];
            
            if (value) {
                
                callback(YES, nil, nil);
                return;
            }
            
        }
    }
}

#pragma mark - Helpers

- (void)applyAttributesWithSubstring:(NSString *)substring attributes:(NSDictionary *)attributes {
    
    // Check if object supports attributed strings
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        
        return;
    }
    
    // http://stackoverflow.com/a/27612974/597292
    // http://stackoverflow.com/a/17122745/597292
    self.scrollEnabled = NO;
    self.selectable = YES;
    
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
    
    // Set attributes
    [attributedText setAttributes:mutableAttributes range:range];
    
    // Set new attributed string
    self.attributedText = attributedText;
    
    self.scrollEnabled = YES;
}

- (NSMutableDictionary *)tapGestureSubstringsAndCallbacks {
    
    return [UITextFieldStylingIvars fetch:self].tapGestureSubstringsAndCallbacks;
}

- (void)setTapGestureSubstringsAndCallbacks:(NSMutableDictionary *)obj {
    
    [UITextFieldStylingIvars fetch:self].tapGestureSubstringsAndCallbacks = obj;
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