//
//  KeyboardControlPrevNext.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/5/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
