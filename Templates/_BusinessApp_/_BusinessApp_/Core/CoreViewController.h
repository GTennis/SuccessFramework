//
//  CoreViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/14/14.
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

#import <UIKit/UIKit.h>
#import "ConstStrings.h"

@interface CoreViewController : UIViewController

// Navigation
- (void)showDefaultNavigationBar;
/* Navigation controller and its bar is shared across all controllers. However, if we need to provide custom navigation bar for specific controller then use this method, disable navigation bar in Xib, drag-n-drop navigationBar to xib and customize it */
- (void)hideDefaultNavigationBar;
- (BOOL)hasNavigationBar;
- (void)handleBackPressed;

// Modal screen handling
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) IBOutlet UIToolbar *modalToolbar;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
- (void)presentModalViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)dismissModalViewControllerAnimated:(BOOL)animated;
- (void)setToolbarHidden:(BOOL)hidden;

// Popup showing, hiding
/*- (void)showPartialViewController:(CoreViewController *)childViewController insideContainerView:(UIView *)containerView;
- (void)hidePartialViewControllerFromContainerView:(UIView *)containerView;
- (CGFloat)popupFadeDuration;*/

// Xib loading
- (UIView *)loadViewFromXibOfClass:(Class)class;
- (UIView *)loadViewFromXib:(NSString *)name ofClass:(Class)class;

// Screen activity indicators
- (void)showScreenActivityIndicator;
- (void)hideScreenActivityIndicator;

// Protected: for overriding

// Common initialization of view controller
- (void)commonInit;
- (void)prepareUI;
- (void)renderUI;
- (void)loadModel;

// Error handling
//- (void)closeTheApp;
- (void)handleNetworkRequestError:(NSNotification *)notification;
- (void)handleNetworkRequestSuccess:(NSNotification *)notification;

// Language changed
- (void)notificationLocalizationHasChanged;

- (IBAction)cancelPressed:(id)sender;

@end
