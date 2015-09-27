//
//  CoreViewController.m
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

#import "CoreViewController.h"
#import "MBProgressHUD.h"

// Activity indicator tags
#define kScreenActivityIndicatorTag 20131217

@interface CoreViewController ()

@end

@implementation CoreViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        [self commonInit];
    }
    
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // Custom initialization
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Observe for changes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationLocalizationHasChanged)
                                                 name:kNOTIFICATION_LOCALIZATION_HAS_CHANGED
                                               object:nil];
    
    // Add identifiers for functional tests
    self.view.isAccessibilityElement = YES;
    NSString *screenName = NSStringFromClass(self.class);
    screenName = [screenName stringByReplacingOccurrencesOfString:@"_iphone" withString:@""];
    screenName = [screenName stringByReplacingOccurrencesOfString:@"_ipad" withString:@""];
    self.view.accessibilityLabel = screenName;
    self.view.accessibilityIdentifier = screenName;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Disable user interaction
    self.view.userInteractionEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Enable user interaction
    self.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protected -

#pragma mark Common

- (void)commonInit {
    
    // Implement in child classes
    //NSAssert(NO, @"commonInit is not implemented in class: %@", NSStringFromClass([self class]));
}

- (void)prepareUI {

    // Implement in child classes
    DDLogDebug(@"[%@]: prepareUI", NSStringFromClass([self class]));
    
    //NSAssert(NO, @"prepareUI is not implemented in class: %@", NSStringFromClass([self class]));
}

- (void)renderUI {
    
    DDLogDebug(@"[%@]: renderUI", NSStringFromClass([self class]));
    
    // Implement in child classes
    //NSAssert(NO, @"renderUI is not implemented in class: %@", NSStringFromClass([self class]));
}

- (void)loadModel {
    
    DDLogDebug(@"[%@]: loadModel", NSStringFromClass([self class]));
    
    // Implement in child classes
    //NSAssert(NO, @"loadModel is not implemented in class: %@", NSStringFromClass([self class]));
}

#pragma mark Xib loading

- (UIView *)loadViewFromXibWithClass:(Class)theClass {
    
    NSString *xibName = NSStringFromClass(theClass);
    
    if (isIpad) {
        
        xibName = [NSString stringWithFormat:@"%@_ipad", xibName];
        
    } else {
        
        xibName = [NSString stringWithFormat:@"%@_iphone", xibName];
    }
    
    UIView *view = [self loadViewFromXib:xibName class:theClass];
    return view;
}

- (UIView *)loadViewFromXib:(NSString *)name class:(Class)theClass {
    
    UIView *loadedView = nil;
    
    NSArray *viewFromXib = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    if (viewFromXib.count > 0) {
        
        UIView *view = [viewFromXib objectAtIndex:0];
        if ([view isKindOfClass:theClass]) {
            
            loadedView = view;
        }
    }
    
    // loadedView.translatesAutoresizingMaskIntoConstraints = NO;
    
    return loadedView;
}

#pragma mark Navigation handling

- (void)didPressedBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showNavigationBar {
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)hideNavigationBar {
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)hasNavigationBar {
    
    return !self.navigationController.navigationBarHidden;
}

#pragma mark Progress indicators

- (void)showScreenActivityIndicator {
    
    // Disable user interface
    self.view.userInteractionEnabled = NO;
    
    MBProgressHUD *activityView = (MBProgressHUD *) [self.view viewWithTag:kScreenActivityIndicatorTag];
    
    if (!activityView) {
        
        activityView = [[MBProgressHUD alloc] initWithView:self.view];
        activityView.tag = kScreenActivityIndicatorTag;
        activityView.color = [UIColor blackColor];
        activityView.center = self.view.center;
    }
    
    [self.view addSubview:activityView];
    [self.view bringSubviewToFront:activityView];
    [activityView show:YES];
}

- (void)hideScreenActivityIndicator {
    
    MBProgressHUD *activityView = (MBProgressHUD *) [self.view viewWithTag:kScreenActivityIndicatorTag];
    
    if (activityView) {
        
        [activityView hide:YES];
        [activityView removeFromSuperview];
    }
    
    self.view.userInteractionEnabled = YES;
}

#pragma mark Error handling

/*
    Any controller can subscribe itself as an observer for network requests status by adding this code in viewDidLoad:
 
    // Listens for failed requests
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkRequestError:) name:kNetworkRequestErrorOccuredNotification object:nil];
 
    // Listens for successful requests
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkRequestSuccess:) name:kNetworkRequestSuccessNotification object:nil];
 
    These notifications transparently call these two internal methods:
 
    1. handleNetworkRequestError: could be used for generic stuff, for example showing fullscreen overlay error message
    2. handleNetworkRequestSuccess - could be used for generic stuff, for example removing shown fullscreen error
 */

- (void)handleNetworkRequestError:(NSNotification *)notification {
    
    // Override in child classes
    // ...
}

- (void)handleNetworkRequestSuccess:(NSNotification *)notification {
    
    // Override in child classes
    // ...
}

#pragma mark Language change handling

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

//#pragma mark Popup handling

/*- (void)showPartialViewController:(CoreViewController *)childViewController insideContainerView:(UIView *)containerView {
    
    CoreViewController *containerViewController = self;
    
    // Will allow user to interact with popup
    containerView.userInteractionEnabled = YES;
    
    // Removing previous views
    for (UIView *subview in containerView.subviews) {
        
        [subview removeFromSuperview];
    }
    
    // Removing previous child view controllers
    for (UIViewController *childViewController in containerViewController.childViewControllers) {
        
        [childViewController removeFromParentViewController];
    }
    
    // Fit to size
    // destinationViewController.view.frame = filterViewController.containerView.bounds;
    
    // Reset
    containerView.alpha = 0.0f;
    
    // Add child
    [containerViewController addChildViewController:childViewController];
    [containerView addSubview:childViewController.view];
    
    // Perform fade in animation
    [UIView animateWithDuration:[self popupFadeDuration] animations:^(void) {
        
        containerView.alpha = 1.0f;
    }];
}

- (void)hidePartialViewControllerFromContainerView:(UIView *)containerView {
    
    // Will disallow user to interact with popup
    containerView.userInteractionEnabled = YES;
    
    __weak typeof(self) weakContainerViewController = self;
    __weak typeof(UIView *) weakContainerView = containerView;
    
    [UIView animateWithDuration:[self popupFadeDuration] animations:^(void){
        
        containerView.alpha = 0.0f;
        
    } completion:^(BOOL finished){
        
        // Removing previous views
        for (UIView *subview in weakContainerView.subviews) {
            
            [subview removeFromSuperview];
        }
        
        // Removing previous child view controllers
        for (UIViewController *childViewController in weakContainerViewController.childViewControllers) {
            
            [childViewController removeFromParentViewController];
        }
    }];
}

// Override for customization
- (CGFloat)popupFadeDuration {
    
    return 0.4f;
}*/

@end
