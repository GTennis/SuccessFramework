//
//  CoreViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/14/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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

- (IBAction)cancelButtonTapped:(id)sender;

@end
