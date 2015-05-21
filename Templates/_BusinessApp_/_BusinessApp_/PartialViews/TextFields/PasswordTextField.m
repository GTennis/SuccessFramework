//
//  PasswordTextField.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/17/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "PasswordTextField.h"

#define kTogglePasswordButtonWidth 50.0f
#define kTogglePasswordButtonHeight 30.0f

@interface PasswordTextField () {
    
    UIButton *_togglePasswordRevealButton;
}

@end

@implementation PasswordTextField

- (void)customize {
    
    [super customize];
    [self addShowHidePasswordControl];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGRect editedBounds = bounds;
    editedBounds.origin.x += kTextFieldDefaultOffset.x;
    editedBounds.origin.y += kTextFieldDefaultOffset.y;
    editedBounds.size.width -= (kTextFieldDefaultEditingMargins + kTogglePasswordButtonWidth);
    
    return editedBounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGRect editedBounds = bounds;
    editedBounds.origin.x += kTextFieldDefaultEditingOffset.x;
    editedBounds.origin.y += kTextFieldDefaultEditingOffset.y;
    editedBounds.size.width -= (kTextFieldDefaultEditingMargins + kTogglePasswordButtonWidth);
    
    return editedBounds;
}

- (void)addShowHidePasswordControl {
    
    // Button size
    CGFloat togglePasswordButtonWidth = kTogglePasswordButtonWidth;
    CGFloat togglePasswordButtonHeight = kTogglePasswordButtonHeight;
    
    // Right separator size
    CGFloat rightSpaceSeparatorViewWidth = 10;
    CGFloat rightSpaceSeparatorViewHeight = togglePasswordButtonHeight;
    
    // Container view size
    CGFloat showHideContainerViewWidth = togglePasswordButtonWidth + rightSpaceSeparatorViewWidth;
    CGFloat showHideContainerViewHeight = togglePasswordButtonHeight;
    
    // Create toggle button
    _togglePasswordRevealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, togglePasswordButtonWidth, togglePasswordButtonHeight)];
    UIFont *font = _togglePasswordRevealButton.titleLabel.font;
    _togglePasswordRevealButton.titleLabel.font = [font fontWithSize:10];
    [_togglePasswordRevealButton setTitle:@"" forState:UIControlStateNormal];
    [_togglePasswordRevealButton setImage:[UIImage imageNamed:@"password-show"] forState:UIControlStateNormal];
    [_togglePasswordRevealButton addTarget:self action:@selector(togglePasswordReveal) forControlEvents:UIControlEventTouchUpInside];
    
    // Add identifiers for functional tests
    NSString *buttonName = @"ShowHidePasswordButton";
    _togglePasswordRevealButton.isAccessibilityElement = YES;
    _togglePasswordRevealButton.accessibilityLabel = buttonName;
    _togglePasswordRevealButton.accessibilityIdentifier = buttonName;
    
    // Create separator
    UIView *rightSpaceSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(togglePasswordButtonWidth, 0, rightSpaceSeparatorViewWidth, rightSpaceSeparatorViewHeight)];
    
    // Create container view
    UIView *showHideContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showHideContainerViewWidth, showHideContainerViewHeight)];
    [showHideContainerView addSubview:_togglePasswordRevealButton];
    [showHideContainerView addSubview:rightSpaceSeparatorView];
    
    // Add right view
    self.rightView = showHideContainerView;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
}

- (void)togglePasswordReveal {
    
    if (_isPasswordShown) {
        
        self.secureTextEntry = YES;
        //   [_togglePasswordRevealButton setTitle:GMLocalizedString(kShowKey) forState:UIControlStateNormal];
        
        [_togglePasswordRevealButton setImage:[UIImage imageNamed:@"password-show"] forState:UIControlStateNormal];
        
        
        _isPasswordShown = NO;
        
    } else {
        
        self.secureTextEntry = NO;
        // [_togglePasswordRevealButton setTitle:GMLocalizedString(kHideKey) forState:UIControlStateNormal];
        [_togglePasswordRevealButton setImage:[UIImage imageNamed:@"password-hide"] forState:UIControlStateNormal];
        
        
        _isPasswordShown = YES;
    }
    
    if ([_toggleDelegate respondsToSelector:@selector(didPressedTogglePassword)]) {
        
        [_toggleDelegate didPressedTogglePassword];
    }
    
    [self moveCursorToTheEndOfText];
}

// Used from http://stackoverflow.com/questions/11157791/how-to-move-cursor-in-uitextfield-after-setting-its-value
- (void)moveCursorToTheEndOfText {
    
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:0];
    UITextPosition *end = [self positionFromPosition:start offset:self.text.length];
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
    
    // this will be the new cursor location after insert/paste/typing
    NSInteger cursorOffset = [self offsetFromPosition:beginning toPosition:start] + self.text.length;
    
    // now apply the text changes that were typed or pasted in to the text field
    [self replaceRange:textRange withText:self.text];
    
    // now update the reposition the cursor afterwards
    UITextPosition *newCursorPosition = [self positionFromPosition:self.beginningOfDocument offset:cursorOffset];
    UITextRange *newSelectedRange = [self textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
    [self setSelectedTextRange:newSelectedRange];
}

@end
