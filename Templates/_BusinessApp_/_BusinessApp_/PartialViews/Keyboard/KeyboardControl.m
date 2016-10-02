//
//  KeyboardControl.m
//  MyHappyGrowth
//
//  Created by Gytenis Mikulėnas on 3/5/14.
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

#pragma mark - KeyboardControlProtocol -

- (id)initWithFields:(NSArray *)fields actionTitle:(NSString *)actionTitle {
    
    self = [super init];
    if (self) {
        
        _actionTitle = actionTitle;
        
        [self commonInit];
        [self setFields:fields];
    }
    return self;
}

#pragma mark - Private -

- (void)commonInit {
    
    CGFloat keyboardWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat keyboardHeight = 50.0f;
    
    _keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, keyboardWidth, keyboardHeight)];
    _keyboardToolBar.translucent = NO;
    //_keyboardToolBar.barTintColor = kColorGrayLight2;
    _keyboardToolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:GMLocalizedString(kCancelKey) style:UIBarButtonItemStylePlain target:self action:@selector(toolbarCancelPressed)];
    cancelButton.accessibilityLabel = @"keyboardToolbarCancelButton";
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorGrayDark} forState:UIControlStateNormal];
    
    UIBarButtonItem *separator = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]initWithTitle:_actionTitle style:UIBarButtonItemStylePlain/*UIBarButtonItemStyleDone*/ target:self action:@selector(toolbarActionPressed)];
    actionButton.accessibilityLabel = @"keyboardToolbarActionButton";
    [actionButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kColorGrayDark} forState:UIControlStateNormal];
    
    [_keyboardToolBar setItems:@[cancelButton, separator, actionButton]];
}

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
                
                //[(UITextView *)field setInputAccessoryView:_keyboardToolBar];
                [(UITextView *)field setInputAccessoryView:[self toolBarForTextView]];
                
                if (i < fields.count - 1) {
                    
                    [self setNextForField:(UITextField *)field];
                    
                } else {
                    
                    [(UITextView *)field setReturnKeyType:UIReturnKeyDefault];
                    // UITextViews always use returnKey for enter, so there's no point to use different style. It's not possible to get callback from the press of returnKey
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
    
    for (id field in _fields) {
        
        [field resignFirstResponder];
    }
    
    if ([_delegate respondsToSelector:@selector(didPressToolbarAction)]) {
        
        [_delegate didPressToolbarAction];
    }
}

- (UIToolbar *)toolBarForTextView {
    
    // Add done to textView
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    toolBar.items = [NSArray arrayWithObjects:
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toolbarCancelPressed)],
                     [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(toolbarActionPressed)],
                     nil];
    
    return toolBar;
}

@end
