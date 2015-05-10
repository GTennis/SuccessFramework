//
//  ScrollViewExampleViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ScrollViewExampleViewController.h"
#import "UserObject.h"

@interface ScrollViewExampleViewController () {
    
    UserObject *_user;
}

@end

@implementation ScrollViewExampleViewController

- (void)commonInit {
    
    // Setup models and other
    
    //_detailsModel = [[EventDetailsModel alloc] initWithDelegate:self];
    //_detailsModel.progressIndicatorController = self;
    //_detailsModel.observer = self;
}

- (id)initWithUser:(UserObject *)user {
    
    self = [super init];
    if (self) {
        
        _user = user;
        
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Render UI
    self.title = GMLocalizedString(@"Details screen");
    
    // Add styles
    [self adjustStyleForTextFields];
    
    // Setup input fields
    [self setupInputFields];
}

#pragma mark - IBActions

- (IBAction)savePressed:(id)sender {
    
    // Perform data checking (user has entered all required fields
    // if no then mark them
    
    [self applyStyleForMissingRequiredFields];
}

#pragma mark - Model

- (void)initializeModel {
    
    // Do network requests, load data or other
    // ...
}

- (void)updateModel {
    
    // Update data if needed
    [self initializeModel];
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



@end
