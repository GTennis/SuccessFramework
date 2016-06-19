//
//  BaseTextField.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
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

#import "BaseTextField.h"
#import "SeparatorHorizontalLineView.h"
#import <QuartzCore/QuartzCore.h>

@interface BaseTextField ()

@end

@implementation BaseTextField

@synthesize isRequired = _isRequired;

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self customize];
    }
    return self;
}

#pragma mark - Public -

- (void)setPosition:(TextFieldPosition)position {
    
    _position = position;
    
    switch (position) {
            
        case kTextFieldPositionIsSingle:
            
            _hasTopSeparatorLine = YES;
            _hasBottomSeparatorLine = YES;
            
            break;
            
        case kTextFieldPositionIsFirst:
            
            _hasTopSeparatorLine = YES;
            
            break;
            
        case kTextFieldPositionIsMiddle:
            
            _hasMiddleSeparatorLine = YES;
            
            break;
            
        case kTextFieldPositionIsLast:
            
            _hasMiddleSeparatorLine = YES;
            _hasBottomSeparatorLine = YES;
            
            break;
    }
}

- (void)setFieldState:(TextFieldStateType)fieldState {
    
    _fieldState = fieldState;
    
    switch (fieldState) {
            
        case kTextFieldStateNormal:
            [self setStyleNormal];
            break;
            
        case kTextFieldStateValueMissing:
            [self setStyleValueMissing];
            break;
    }
}

#pragma mark - Overwritten methods

#pragma mark Main Rects

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!_separatorsAlreadyAdded) {
        
        if (_hasTopSeparatorLine) {
            
            [self addTopSeparatorLine];
        }
        
        if (_hasMiddleSeparatorLine) {
            
            [self addMiddleSeparatorLine];
        }
        
        if (_hasBottomSeparatorLine) {
            
            [self addBottomSeparatorLine];
        }
    }
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    
    CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];
    clearButtonRect.origin.y = self.frame.size.height / 2 - clearButtonRect.size.height / 2;
    
    return clearButtonRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    // You can control how much to move placeholder down and right if it's too high/left
    CGFloat placeholderOriginXFix = self.textOffset.x;
    CGFloat placeholderOriginYFix = self.textOffset.y;
    
    CGRect placeholderBounds = bounds;
    placeholderBounds.origin.y = self.frame.size.height / 2 - placeholderBounds.size.height / 2 + placeholderOriginYFix;
    placeholderBounds.origin.x += placeholderOriginXFix;
    
    return placeholderBounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGRect editedBounds = bounds;
    editedBounds.origin.x += self.textOffset.x;
    editedBounds.origin.y += self.textOffset.y;
    
    return editedBounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGRect editedBounds = bounds;
    editedBounds.origin.x += self.textOffsetWhileEditing.x;
    editedBounds.origin.y += self.textOffsetWhileEditing.y;
    
    // Reduce width of text field editable area if clear button is shown, in order to overlap text with clear button
    if (self.clearButtonMode != UITextFieldViewModeNever) {
        
        editedBounds.size.width -= (self.textOffsetWhileEditing.x + self.textClearButtonSizeWhileEditing.width);
    }
    
    return editedBounds;
}

- (UIEdgeInsets)outsidePadding {
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (UIEdgeInsets)insidePadding {
    
    CGFloat extraSizeToCompensateTooSmallHeight = 2;
    
    return UIEdgeInsetsMake(6 + extraSizeToCompensateTooSmallHeight, 0, 6 + extraSizeToCompensateTooSmallHeight, 0);
}

#pragma mark Other

- (void)setEnabled:(BOOL)enabled {
    
    // UI consistency: use the same text colors for all inputs
    [super setEnabled:enabled];
    
    self.textColor = enabled ? [UIColor darkGrayColor]:[UIColor lightGrayColor];
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    if (self.fieldState == kTextFieldStateValueMissing && text.length > 0) {
        self.fieldState = kTextFieldStateNormal;
    }
}


- (void)setPlaceholder:(NSString *)placeholder {
    
    [super setPlaceholder:placeholder];
    
    // Re'apply placeholder style
    [self setCommonStyle];
}

#pragma mark - Protected -

- (CGSize)intrinsicContentSize {
    
    // Height doesnt' matter because TextField is single line control
    CGSize size = [@"Text" sizeWithAttributes:@{NSFontAttributeName:self.font}];
    
    CGSize resultSize = CGSizeMake(size.width + self.insidePadding.left + self.insidePadding.right + self.outsidePadding.left + self.outsidePadding.right,
                                   size.height + self.insidePadding.top + self.insidePadding.bottom + self.outsidePadding.top + self.outsidePadding.bottom);
    
    return resultSize;
}

- (void)customize {
    
    [self setCommonStyle];
    [self customizeFloatingLabel];
    [self setStyleNormal];
    
    self.tintColor = self.textCursorColor;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // Add corner radius if defined
    if (self.borderCornerRadius) {
        
        self.layer.cornerRadius = self.borderCornerRadius;
        self.layer.masksToBounds = YES;
    }
    
    // Add border if defined
    if (self.borderWidth) {
        
        self.layer.borderColor = nil;//kTextFieldBorderColor;
        self.layer.borderWidth = self.borderWidth;
    }
    
    [self observeStateChanges];
}

#pragma mark Corners

- (CGFloat)borderCornerRadius {
    
    return 0.0f;
}

- (CGFloat)borderWidth {
    
    return 0.0f;
}

- (UIColor *)borderColor {
    
    return kColorGrayLight1;
}

#pragma mark Text

- (UIColor *)textBackgroundColor {
    
    return [UIColor clearColor];
}

- (UIColor *)textColor_ {
    
    return kColorGrayDark;
}

- (NSString *)textFont {
    
    return kFontNormal;
}

- (CGFloat)textSize {
    
    return 15.0f;
}

- (UIColor *)textCursorColor {
    
    return kColorGrayDark;
}

#pragma mark Text offsets

- (CGPoint)textOffset {
    
    return CGPointMake(12.0f, 5.0f);
}

- (CGPoint)textOffsetWhileEditing {
    
    return CGPointMake(12.0f, 5.0f);
}

- (CGSize)textClearButtonSizeWhileEditing {
    
    return CGSizeMake(20.0f, self.frame.size.height) ;
}

#pragma mark Placeholder

- (UIColor *)placeholderBackgroundColor {
    
    return [UIColor clearColor];
}

- (UIColor *)placeholderTextColor {
    
    return kColorGrayLight1;
}

- (UIColor *)placeholderTextColorWhileEditing {
    
    return kColorGreen;
}

- (NSString *)placeholderTextFont {
    
    return kFontNormal;
}

- (CGFloat)placeholderTextSize {
    
    return 12.0f;
}

- (CGFloat)placeholderTextOffsetY {
    
    return 5.0f;
}

- (CGFloat)separatorLineOffsetY {
    
    return 12.0f;
}

#pragma mark - Private -

- (void)setCommonStyle {
    
    self.backgroundColor = self.textBackgroundColor;
    
    // Check if empty
    if (!self.placeholder) {
        
        // Placeholder might not be set yet, but we need some not nil value in order to apply color
        self.placeholder = @" ";
    }
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderTextColor}];
    
    self.textColor = self.textColor_;
}

- (void)customizeFloatingLabel {
    
    self.floatingLabel.backgroundColor = self.placeholderBackgroundColor;
    self.floatingLabelActiveTextColor = self.placeholderTextColorWhileEditing;
    self.floatingLabelTextColor = self.placeholderTextColor;
    self.floatingLabelFont = [UIFont fontWithName:self.placeholderTextFont size:self.textSize]; 
    self.floatingLabelYPadding = self.placeholderTextOffsetY;
}

- (void)addTopSeparatorLine {
    
    // Add separator line
    SeparatorHorizontalLineView *lineView = [SeparatorHorizontalLineView autolayoutView];
     [lineView fitIntoContainerView:self color:nil alignTop:YES leftOffset:0 rightOffset:0];
     [self addSubview:lineView];
}

- (void)addMiddleSeparatorLine {
    
    // Add separator line
    SeparatorHorizontalLineView *lineView = [SeparatorHorizontalLineView autolayoutView];
     [lineView fitIntoContainerView:self color:nil alignTop:YES leftOffset:self.separatorLineOffsetY rightOffset:0];
     [self addSubview:lineView];
}

- (void)addBottomSeparatorLine {
    
    // Add separator line
    SeparatorHorizontalLineView *lineView = [SeparatorHorizontalLineView autolayoutView];
     [lineView fitIntoContainerView:self color:nil alignTop:NO leftOffset:0 rightOffset:0];
     [self addSubview:lineView];
}

- (void)observeStateChanges {
    
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark Style change handling

- (void)setStyleNormal {
    
    if (self.enabled) {
        
        self.textColor = self.textColor_;
        
        UIFont *font = [UIFont fontWithName:self.textFont size:self.textSize];
        self.font = font;
        
        // Apply color for placeholder if its not nil
        if (self.placeholder) {
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderTextColor, NSFontAttributeName:font}];
        }
    }
}

- (void)setStyleValueMissing {
    
    if (self.enabled) {
        
        self.textColor = kColorRed;
        // Apply color for placeholder if its not nil
        
        if (self.placeholder) {
            
            UIFont *font = [UIFont fontWithName:self.textFont size:self.textSize];
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:kColorRed, NSFontAttributeName:font}];
        }
    }
}

#pragma mark Change observation

- (void)validateValue {
    
    if (self.isRequired) {
        
        if (!self.text.length) {
            
            self.fieldState = kTextFieldStateValueMissing;
        }
    }
}

- (void)resetValidatedValues {
    
    self.fieldState = kTextFieldStateNormal;
}

- (void)textChanged:(UITextField *)textField {
    
    if (self.fieldState == kTextFieldStateValueMissing && textField.text.length > 0) {
        
        self.fieldState = kTextFieldStateNormal;
    }
}

@end
