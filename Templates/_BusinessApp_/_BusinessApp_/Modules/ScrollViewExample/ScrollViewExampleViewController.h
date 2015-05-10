//
//  ScrollViewExampleViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//
//  Example of scrollView with text fields, navigation, keyboard prev/next, scrollView autoschrinking. Setup:
//
//  1. Add scrollView under rootView. Place everything inside the scrollView
//  2. Most top element in scrollView should have leading, top and trailing constraint to superView
//  3. Most bottom element in scrollView should have bottom constraint to superView
//  4. Connect scrollView IBOutlet property from BaseViewController to the scrollView
//  5. Setup fields for navigation in viewDidLoad

#import "BaseDetailsViewController.h"

@interface ScrollViewExampleViewController : BaseDetailsViewController

@property (nonatomic, strong) IBOutlet BaseTextField *countryTextField;
@property (nonatomic, strong) IBOutlet BaseTextField *firstNameTextField;
@property (nonatomic, strong) IBOutlet BaseTextField *lastNameTextField;
@property (nonatomic, strong) IBOutlet BaseTextField *birthDateTextField;

- (id)initWithUser:(UserObject *)user;

@end
