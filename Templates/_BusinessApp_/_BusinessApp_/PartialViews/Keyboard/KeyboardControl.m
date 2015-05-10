//
//  KeyboardControl.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/5/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "KeyboardControl.h"
#import "ConstColors.h"
#import "ConstStrings.h"

@interface KeyboardControl () {
    
    UIToolbar *_keyboardToolBar;
    NSArray *_fields;
    NSString *_actionTitle;
}

@end

@implementation KeyboardControl

@synthesize activeField = _activeField;
@synthesize fields = _fields;

- (void)dealloc {
    
    _delegate = nil;
}

- (void)commonInit {
    
    CGFloat keyboardWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat keyboardHeight = 50.0f;
    
    _keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, keyboardWidth, keyboardHeight)];
    _keyboardToolBar.translucent = NO;
    //_keyboardToolBar.barTintColor = kColorGrayLight2;
    _keyboardToolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:GMLocalizedString(kCancelKey) style:UIBarButtonItemStyleBordered target:self action:@selector(toolbarCancelPressed)];
    cancelButton.accessibilityLabel = @"keyboard_btnCancel";
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorGrayDark} forState:UIControlStateNormal];
    
    UIBarButtonItem *separator = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]initWithTitle:_actionTitle style:UIBarButtonItemStyleBordered/*UIBarButtonItemStyleDone*/ target:self action:@selector(toolbarActionPressed)];
    actionButton.accessibilityLabel = @"keyboard_btnAction";
    [actionButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorGrayDark} forState:UIControlStateNormal];
    
    [_keyboardToolBar setItems:@[cancelButton, separator, actionButton]];
}

- (id)initWithFields:(NSArray *)fields actionTitle:(NSString *)actionTitle {
    
    self = [super init];
    if (self) {
        
        _actionTitle = actionTitle;
        
        [self commonInit];
        [self setFields:fields];
    }
    return self;
}

#pragma mark - Helpers

- (void)setFields:(NSArray *)fields {
    
    NSInteger i = 0;
    
    if (fields != _fields) {
        
        for (UIView *field in fields) {
            
            if ([field isKindOfClass:[UITextField class]]) {
                
                [(UITextField *)field setInputAccessoryView:_keyboardToolBar];
                
                if (i < fields.count - 1) {
                    
                    [self setNextForField:(UITextField *)field];
                    
                } else {
                    
                    [self setGoForField:(UITextField *)field];
                }
                
            } else if ([field isKindOfClass:[UITextView class]]) {
                
                [(UITextView *)field setInputAccessoryView:_keyboardToolBar];
                
                if (i < fields.count - 1) {
                    
                    [self setNextForField:(UITextField *)field];
                    
                } else {
                    
                    [self setGoForField:(UITextField *)field];
                }
            }
            
            i++;
        }
        
        _fields = fields;
    }
}

- (void)setNextForField:(UITextField *)field {
    
    field.returnKeyType = UIReturnKeyNext;
}

- (void)setGoForField:(UITextField *)field {
    
    field.returnKeyType = UIReturnKeyGo;
}

- (void)toolbarCancelPressed {
    
    for (id field in _fields) {
        
        [field resignFirstResponder];
    }
    
    if ([_delegate respondsToSelector:@selector(didPressToolbarCancel)]) {
        
        [_delegate didPressToolbarCancel];
    }
}

- (void)toolbarActionPressed {
    
    if ([_delegate respondsToSelector:@selector(didPressToolbarAction)]) {
        
        [_delegate didPressToolbarAction];
    }
}

@end

