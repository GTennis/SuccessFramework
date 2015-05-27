//
//  KeyboardControlPrevNext.m
//  _BusinessApp_
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

#import "KeyboardControlPrevNext.h"
#import "BSKeyboardControls.h"

@interface KeyboardControlPrevNext () <BSKeyboardControlsDelegate> {
    
    BSKeyboardControls *_keyboardControls;
}

@end

@implementation KeyboardControlPrevNext

@synthesize delegate = _delegate;
@synthesize fields = _fields;
@synthesize activeField = _activeField;

- (void)dealloc {
    
    _delegate = nil;
    _keyboardControls.delegate = nil;
}

- (id)initWithFields:(NSArray *)fields actionTitle:(NSString *)actionTitle {
    
    self = [super init];
    if (self) {
        
        _keyboardControls = [[BSKeyboardControls alloc] initWithFields:fields];
        _keyboardControls.delegate = self;
    }
    return self;
}

#pragma mark - Override

- (void)setActiveField:(UIView *)activeField {
    
    if (_keyboardControls && activeField) {
        
        [_keyboardControls setActiveField:activeField];
    }
}

- (UIView *)activeField {
    
    return _keyboardControls.activeField;
}

#pragma mark - BSKeyboardControlsDelegate

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction {
    
    [_delegate scrollToActiveField:field];
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls {
    
    [_delegate.view endEditing:YES];
    
    if ([_delegate respondsToSelector:@selector(didPressToolbarCancel)]) {
        
        [_delegate didPressToolbarCancel];
    }
}

@end
