//
//  ScrollViewExampleViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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

#pragma mark - Helpers

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
    
    // Update UI with loaded data
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    // ...
    
    [self renderUI];
}

@end
