//
//  ScrollViewExampleViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
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
//  An example of scrollView with text fields, navigation, keyboard prev/next, scrollView autoschrinking. Setup:
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

@end
