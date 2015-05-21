//
//  BaseTextField.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseTextField.h"
#import "SeparatorHorizontalLineView.h"
#import <QuartzCore/QuartzCore.h>

@interface BaseTextField () {
    
    BOOL _separatorsAlreadyAdded;
    BOOL _hasTopSeparatorLine;
    BOOL _hasMiddleSeparatorLine;
    BOOL _hasBottomSeparatorLine;
}

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
        [self observeStateChanges];
    }
    return self;
}

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
    
    // Placeholder is a little bit too high, so need to move it down
    CGFloat placeholderOriginYFix = kTextFieldDefaultOffset.y;
    CGFloat placeholderOriginXFix = kTextFieldDefaultOffset.x;
    
    CGRect placeholderBounds = bounds;
    placeholderBounds.origin.y = self.frame.size.height / 2 - placeholderBounds.size.height / 2 + placeholderOriginYFix;
    placeholderBounds.origin.x += placeholderOriginXFix;
    
    return placeholderBounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGRect editedBounds = bounds;
    editedBounds.origin.x += kTextFieldDefaultOffset.x;
    editedBounds.origin.y += kTextFieldDefaultOffset.y;
    
    return editedBounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGRect editedBounds = bounds;
    editedBounds.origin.x += kTextFieldDefaultEditingOffset.x;
    editedBounds.origin.y += kTextFieldDefaultEditingOffset.y;
    editedBounds.size.width -= kTextFieldDefaultEditingMargins;
    
    return editedBounds;
}

#pragma mark Other

- (void)setEnabled:(BOOL)enabled {
    
    // UI consistency: use the same text colors for all inputs
    [super setEnabled:enabled];
    
    self.textColor = enabled ? [UIColor darkGrayColor]:[UIColor lightGrayColor];
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    if (self.fieldState == AucTextFieldStateValueMissing && text.length > 0) {
        self.fieldState = AucTextFieldStateNormal;
    }
}

#pragma mark - Private

#pragma mark Customization

- (void)customize {
    
    [self customizeFloatingLabel];
    [self setStyleNormal];
    
    // Add corner radius if defined
    if (kTextFieldBorderCornerRadius) {
        
        self.layer.cornerRadius = kTextFieldBorderCornerRadius;
        self.layer.masksToBounds = YES;
    }
    
    // Add border if defined
    if (kTextFieldBorderWidth) {
        
        self.layer.borderColor = nil;//kTextFieldBorderColor;
        self.layer.borderWidth = kTextFieldBorderWidth;
    }
}

- (void)customizeFloatingLabel {
    
    // Set custom font
    //self.floatingLabel.font = [UIFont fontWithName:kBookFontName size:10.0f];
    
    self.floatingLabel.backgroundColor = kTextFieldPlaceholderBackgroundColor;
    self.floatingLabelActiveTextColor = kTextFieldFloatingPlaceholderColorWhileEditing;
    self.floatingLabelTextColor = kTextFieldFloatingPlaceholderColor;
    
    self.tintColor = kTextFieldCursorColor;
}

- (void)addTopSeparatorLine{
    
    // Add separator line
    SeparatorHorizontalLineView *lineView = [SeparatorHorizontalLineView autolayoutView];
    [lineView fitIntoContainerView:self color:nil alignTop:YES leftOffset:0 rightOffset:0];
    [self addSubview:lineView];
}

- (void)addMiddleSeparatorLine{
    
    // Add separator line
    SeparatorHorizontalLineView *lineView = [SeparatorHorizontalLineView autolayoutView];
    [lineView fitIntoContainerView:self color:nil alignTop:YES leftOffset:kTextFieldSeparatorLeftOffset rightOffset:0];
    [self addSubview:lineView];
}

- (void)addBottomSeparatorLine{
    
    // Add separator line
    SeparatorHorizontalLineView *lineView = [SeparatorHorizontalLineView autolayoutView];
    [lineView fitIntoContainerView:self color:nil alignTop:NO leftOffset:0 rightOffset:0];
    [self addSubview:lineView];
}

- (void)observeStateChanges {
    
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark StyleChanges

- (void)setFieldState:(TextFieldStateType)fieldState {
    
    _fieldState = fieldState;
    
    switch (fieldState) {
            
        case AucTextFieldStateNormal:
            [self setStyleNormal];
            break;
            
        case AucTextFieldStateValueMissing:
            [self setStyleValueMissing];
            break;
    }
}

- (void)setStyleNormal {
    
    if (self.enabled) {
        
        self.textColor = kTextFieldTextColor;
        
        UIFont *font = [UIFont fontWithName:kTextFieldTextFont size:kTextFieldTextSize];
        self.font = font;
        
        // Apply color for placeholder if its not nil
        if (self.placeholder) {
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:font}];
        }
    }
}

- (void)setStyleValueMissing {
    
    if (self.enabled) {
        
        self.textColor = kColorRed;
        // Apply color for placeholder if its not nil
        
        if (self.placeholder) {
            
            UIFont *font = [UIFont fontWithName:kTextFieldTextFont size:kTextFieldTextSize];
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:kColorRed, NSFontAttributeName:font}];
        }
    }
}

#pragma mark Changes observation

- (void)validateValue {
    
    if (self.isRequired) {
        
        if (!self.text.length) {
            
            self.fieldState = AucTextFieldStateValueMissing;
        }
    }
}

- (void)resetValidatedValues {
    
    self.fieldState = AucTextFieldStateNormal;
}

- (void)textChanged:(UITextField *)textField {
    
    if (self.fieldState == AucTextFieldStateValueMissing && textField.text.length > 0) {
        
        self.fieldState = AucTextFieldStateNormal;
    }
}

@end
