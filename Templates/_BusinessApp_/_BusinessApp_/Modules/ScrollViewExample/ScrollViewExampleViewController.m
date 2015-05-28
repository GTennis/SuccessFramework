//
//  ScrollViewExampleViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
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

#import "ScrollViewExampleViewController.h"
#import "UserObject.h"

#define kScrollViewExampleViewControllerTitle @"ScrollViewExample"

@interface ScrollViewExampleViewController () {
    
}

@end

@implementation ScrollViewExampleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self prepareUI];
    [self loadModel];
}

#pragma mark - IBActions

- (IBAction)savePressed:(id)sender {
    
    // Perform data checking (user has entered all required fields
    // if no then mark them
    
    [self applyStyleForMissingRequiredFields];
}

#pragma mark - Input fields

- (void)adjustStyleForTextFields {
    
    // Apply custom colors
    self.countryTextField.backgroundColor = self.view.backgroundColor;
    
    // Apply other attributes
    self.countryTextField.enabled = NO;
    self.firstNameTextField.enabled = YES;
    self.lastNameTextField.enabled = YES;
    self.birthDateTextField.enabled = YES;

}

// Add toolbar with previous and next buttons for navigating between input fields
- (void)setupInputFields {
    
    // Set required fields
    self.firstNameTextField.isRequired = YES;
    self.lastNameTextField.isRequired = YES;
    
    // Setup keyboard nvigation
    NSArray *textFields = @[self.firstNameTextField, self.lastNameTextField,
                            self.birthDateTextField];
    
    [self setTextFieldsForKeyboard:textFields];
}

#pragma mark - Base methods

- (void)prepareUI {
    
    [super prepareUI];
    
    // Render UI
    self.title = GMLocalizedString(kScrollViewExampleViewControllerTitle);
    
    // Add styles
    [self adjustStyleForTextFields];
    
    // Setup input fields
    [self setupInputFields];
}

- (void)renderUI {
    
    [super renderUI];
    
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    [self renderUI];
}

#pragma mark - Helpers

@end
