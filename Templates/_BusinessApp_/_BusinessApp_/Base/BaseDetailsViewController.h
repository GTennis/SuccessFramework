//
//  BaseDetailsViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
