//
//  BaseDetailsViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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
//  Extend this controller in screens where you have input fields and connect its scrollView property
//

#import "BaseViewController.h"
#import "KeyboardControlProtocol.h"

@interface BaseDetailsViewController : BaseViewController

// Use this property in form / text field based screens
/*

// Field navigation

- (void)setTextFielsForPrevNextNavigation:(NSArray *)textFields;
- (void)nextTextFieldBecomeFirstResponder;
- (void)donePressed; // Implement the method in child classes for callback from keyboard

// For marking required input fields
- (void)applyStyleForMissingRequiredFields;*/

// Use this property in form / text field based screens
@property (nonatomic, weak) IBOutlet UIScrollView *contentScrollView;

// Flag for checking if keybaord is present
@property (nonatomic) BOOL isKeyboardActive;

// Keyboard observing
@property BOOL observeKeyboard;

// Use this when need to move scrollView content up with some offset
@property (nonatomic) CGFloat keyboardScrollViewContentOffset;

// If set then will always scroll to this field regardless of other fields
// Usefull in small screens (login) when need fixed scrolling
@property (nonatomic, strong) UITextField *alwaysAutoScrollToThisField;

@property (nonatomic) BOOL shouldReturnToZeroScrollOffset;

// Stores a list of fields for keyboard controls
@property (nonatomic, strong) id<KeyboardControlProtocol> keyboardControls;

- (void)setTextFieldsForKeyboard:(NSArray *)fields;
- (void)scrollToActiveField:(UIView *)textField;

// For marking required input fields
- (void)applyStyleForMissingRequiredFields;
- (void)resetStyleForMissingRequiredFields;

- (void)keyboardWillAppear:(NSNotification *)notification;
- (void)keyboardWillDisappear:(NSNotification *)notification;

@end
