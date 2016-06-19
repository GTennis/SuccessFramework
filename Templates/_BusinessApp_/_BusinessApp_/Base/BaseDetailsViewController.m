//
//  BaseDetailsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
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

#import "BaseDetailsViewController.h"
#import "DataInputFormTextFieldProtocol.h"
//#import "KeyboardControlPrevNext.h"
#import "KeyboardControl.h"

//@interface BaseDetailsViewController () <UITextFieldDelegate, KeyboardControlPrevNextDelegate>
@interface BaseDetailsViewController () <UITextFieldDelegate, KeyboardControlDelegate> {
 
    // Keyboard height
    CGFloat _keyboardHeight;
    
    // For closing keyboard
    UITapGestureRecognizer *_tapGestureRecognizer;
    
    // Fields for keyboard navigation and form validation
    NSArray *_textFieldsForKeyboard;
    
    // Keyboard observing
    BOOL _observeKeyboard;
}

@end

@implementation BaseDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self unSubscribeFromKeyboardNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self subscribeForKeyboardNotifications];
}

#pragma mark - Protected -

#pragma mark ScrollView related

// Looks like this is not needed anymore
// Screens containing scrollView with content inside are mostly targeted for data input form screens. Therefore, need to calculate and set scrollView content height with respect to containing items.
/*- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    // Proceed only for screens with text fields contained in scrollView (details screens)
    if (self.contentScrollView && !_keyboardControls.activeField) {
        
        UIView *firstSubview = self.contentScrollView.subviews.firstObject;
        CGFloat maxViewOriginY = firstSubview.frame.origin.y;
        CGFloat viewOriginY = 0;
    
        // Disabling scroll indicators. Otherwise two UIImageViews will exist inside scrollView and vertical image will be causing scrolling issue
        // http://stackoverflow.com/questions/5388703/strange-uiimageview-in-uiscrollview
        self.contentScrollView.showsVerticalScrollIndicator = NO;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        
        // Find most bottom view
        for (UIView *subView in self.contentScrollView.subviews) {
            
            viewOriginY = CGRectGetMaxY(subView.frame);
            
            if (viewOriginY > maxViewOriginY) {
                
                maxViewOriginY = viewOriginY;
            }
        }
        
        CGFloat contentWidth = CGRectGetWidth(self.view.bounds) + _keyboardScrollViewContentEdgeInsets.left + _keyboardScrollViewContentEdgeInsets.right;
        CGFloat contentHeight = maxViewOriginY + _keyboardScrollViewContentEdgeInsets.top + _keyboardScrollViewContentEdgeInsets.bottom;
        
        // Set content height using most bottom view position
        self.contentScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    }
}*/

- (void)scrollToActiveField:(UIView *)textField {
    
    CGRect rect;
    
    if (!_alwaysAutoScrollToThisField) {
        
        rect = textField.frame;
        
    } else {
        
        rect = _alwaysAutoScrollToThisField.frame;
    }
    
    // Scroll to show textField if needed. Actually not clear why but need to add _keyboardHeight to field's frame origin, in order to do correct scrolling
    
    rect.origin.y += _keyboardHeight + _keyboardScrollViewContentEdgeInsets.top;
    [self.contentScrollView scrollRectToVisible:rect animated:YES];
}

- (void)adjustScrollVieWidthToFitScreen {
    
    //self.contentScrollView.scrollEnabled = NO;
    //self.shouldReturnToZeroScrollOffset = YES;
    
    CGFloat edgeMarginSize = 8.0;
    _keyboardScrollViewContentEdgeInsets = UIEdgeInsetsMake(0, 0, edgeMarginSize, 0);
    
    // Adjust scrollView width
    _scrollViewWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width; // - edgeMarginSize * 2;
}

#pragma mark Keyboard control handling

- (void)setTextFieldsForKeyboard:(NSArray *)fields {
    
    _textFieldsForKeyboard = fields;
    
    _observeKeyboard = YES;
    
    // Use tap gesture for closing keyboard when user taps anywhere on the screen
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponder:)];
    
    // Listen for keyboard notifications
    [self subscribeForKeyboardNotifications];
    
    // Add self delegate to all fields
    for (UITextField *field in fields) {
        
        field.delegate = self;
    }
    
    // Create class for managing field navigation
    _keyboardControls = [self keyboardControlsWithFields:fields];
}

- (id<KeyboardControlProtocol>)keyboardControlsWithFields:(NSArray *)fields {
    
    //KeyboardControlsPrevNext *keyboardControls = [[KeyboardControlsPrevNext alloc] initWithFields:fields actionTitle:GMLocalizedString(kDoneKey)];
    KeyboardControl *keyboardControl = [[KeyboardControl alloc] initWithFields:fields actionTitle:self.keyboardToolbarActionTitle];
    keyboardControl.delegate = self;
    
    return (id<KeyboardControlProtocol>) keyboardControl;
}

- (void)subscribeForKeyboardNotifications {
    
    if (_observeKeyboard) {
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardWithNotification:)];
        
        // Reset previous observing (due to multiple calls through viewWillAppear:)
        [self unSubscribeFromKeyboardNotifications];
        
        // Observe keyboard notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)unSubscribeFromKeyboardNotifications {
    
    //Removing from observing
    if (_observeKeyboard) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)keyboardWillAppear:(NSNotification *)aNotification {
    
    if (self.contentTableView) {
        
        [self handleKeyBoardWillAppearNotification:aNotification withScrollView:self.contentTableView];
        
    } else if (self.contentScrollView) {
        
        [self handleKeyBoardWillAppearNotification:aNotification withScrollView:self.contentScrollView];
    }
}

- (void)keyboardWillDisappear:(NSNotification *)aNotification {
    
    if (self.contentTableView) {
        
        [self handleKeyboardWillDisappearNotification:aNotification withScrollView:self.contentTableView];
        
    } else if (self.contentScrollView) {
        
        [self handleKeyboardWillDisappearNotification:aNotification withScrollView:self.contentScrollView];
    }
}

// Called when the UIKeyboardDidShowNotification is sent.
// Used from: https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
- (void)handleKeyBoardWillAppearNotification:(NSNotification *)aNotification withScrollView:(UIScrollView *)scrollView {
    
    if (!_isKeyboardActive) {
        
        _isKeyboardActive = YES;
    }
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.keyboardControls.activeField.frame.origin) ) {
        [scrollView scrollRectToVisible:self.keyboardControls.activeField.frame animated:YES];
    }
    
    [self.view addGestureRecognizer:_tapGestureRecognizer];
}

- (void)handleKeyboardWillDisappearNotification:(NSNotification *)aNotification withScrollView:(UIScrollView *)scrollView {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    [self.view removeGestureRecognizer:_tapGestureRecognizer];
}

- (void)hideKeyboardWithNotification:(NSNotification *)notification {
    
    [_keyboardControls.activeField resignFirstResponder];
}

- (void)resignFirstResponder:(UIGestureRecognizer *)tapGestureRecognizer {
    
    [_keyboardControls.activeField resignFirstResponder];
}

#pragma mark Validation styling

- (void)applyStyleForMissingRequiredFields {
    
    for (id<DataInputFormTextFieldProtocol> field in _textFieldsForKeyboard) {
        
        [field validateValue];
    }
}

- (void)resetStyleForMissingRequiredFields {
    
    for (id<DataInputFormTextFieldProtocol> field in _textFieldsForKeyboard) {
        
        [field resetValidatedValues];
    }
}

#pragma mark - UITextFieldDelegate -

- (UITextField *)nextTextField {
    
    UITextField *nextTextField = [self nextFieldFromField:(UITextField *)_keyboardControls.activeField];
    
    return nextTextField;
}

- (UITextField *)nextFieldFromField:(UITextField *)fromField {
    
    UITextField *nextTextField = nil;
    
    // Current field index
    NSInteger fieldIndex = [_keyboardControls.fields indexOfObject:fromField];
    
    // Proceed if there's at least one field managed by _keyboardControls
    if (_keyboardControls.fields.lastObject) {
        
        // Next field index
        if (fieldIndex < _keyboardControls.fields.count - 1) {
            
            fieldIndex++;
            
            nextTextField = _keyboardControls.fields[fieldIndex];
            
            // If textField is already last field
        } else if (fieldIndex + 1 == _keyboardControls.fields.count) {
            
            //[self donePressed];
        }
    }
    
    // If text field is disable AND it's not the last field
    if (!nextTextField.enabled && !(fieldIndex + 1 == _keyboardControls.fields.count)) {
        
        // Jump to the next field
        nextTextField = [self nextFieldFromField:nextTextField];
    }
    
    return nextTextField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (_keyboardControls && textField) {
        
        [_keyboardControls setActiveField:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (_keyboardControls && textField) {
        
        UITextField *nextTextField = [self nextTextField];
        
        if (nextTextField) {
            
            [nextTextField becomeFirstResponder];
            
            // Scroll to show textField if needed. Actually not clear why but need to add _keyboardHeight to field's frame origin, in order to do correct scrolling
            CGRect rect = _keyboardControls.activeField.frame;
            rect.origin.y += _keyboardHeight;
            [self.contentScrollView scrollRectToVisible:rect animated:YES];
            
        } else {
            
            [self lastFieldReturnPressed];
        }
    }
    
    return YES;
}

- (void)lastFieldReturnPressed {
    
    [self didPressGo];
}

#pragma mark - KeyboardControlDelegate -

- (NSString *)keyboardToolbarActionTitle {
    
    // Override in child classes
    // ...
    
    return nil;
}

- (void)didPressToolbarAction {
    
    // Override in child classes
    // ...
}

- (void)didPressToolbarCancel {
    
    // Override in child classes
    // ...
}

- (void)didPressGo {
    
    // Implement in child classes for handling GO click on the last field
    // ...
}

@end
