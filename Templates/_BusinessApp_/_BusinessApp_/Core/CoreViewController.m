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
#import "AppDelegate.h"

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

/*
 Transparent solution for universal apps. Every module (screen) should have its primary (base) view controller, for example MyModuleViewController, but without xib. Then,  create a separate class with its xib for iPhone using format MyModuleViewController_iphone. And then, create the same using MyModuleViewController_ipad for iPad.
 
 In the all app code FORGET about conditional creation of viewControllers, like:
 
 ...
 if (device == iPad) {
 
 viewController = [[MyModuleViewController_ipad alloc] init];
 
 } else {
 
 viewController = [[MyModuleViewController_iphone alloc] init];
 }
 
 Just use [[MyModuleViewController alloc] init] and the method below will take care which subclass it should use for creating controller.
 */
+ (id)alloc {
    
    NSString *viewControllerClassName = NSStringFromClass([self class]);
    
    // This method gets called two times during creation of viewController
    
    // The first time the method is called from MyModuleViewController class declaration. We need to override MyModuleViewController class name into device specific class name, so this first condition checks if class name doesn't contain appended suffix
    
    if ([viewControllerClassName rangeOfString:@"ipad"].location == NSNotFound && [viewControllerClassName rangeOfString:@"iphone"].location == NSNotFound) {
        
        if (isIpad) {
            
            viewControllerClassName = [NSString stringWithFormat:@"%@_ipad", viewControllerClassName];
            
        } else {
            
            viewControllerClassName = [NSString stringWithFormat:@"%@_iphone", viewControllerClassName];
        }
        
        return [NSClassFromString(viewControllerClassName) alloc];
        
        // The second call will be made from within correct device specific  subclass, so we just need to pass execution flow to its regular place
    } else {
        
        return [super alloc];
    }
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

#pragma mark - Protected: for overriding

- (void)commonInit {
    
    // Implement in child classes to initialize all required properties
    // ...
}

- (void)prepareUI {

    // Set cancel button target and title in case screen is presented modally
    _cancelButton.target = self;
    _cancelButton.action = @selector(cancelPressed:);
    _cancelButton.title = GMLocalizedString(kCancelKey);
    
    // Add identifiers for functional tests
    NSString *buttonName = [NSString stringWithFormat:@"%@ModalScreenToolbarCancelButton", NSStringFromClass([self class])];
    _cancelButton.isAccessibilityElement = YES;
    _cancelButton.accessibilityLabel = buttonName;
    _cancelButton.accessibilityIdentifier = buttonName;
    
    NSString *labelName = [NSString stringWithFormat:@"%@ModalScreenToolbarTitleLabel", NSStringFromClass([self class])];
    _titleLabel.isAccessibilityElement = YES;
    _titleLabel.accessibilityLabel = labelName;
    _titleLabel.accessibilityIdentifier = labelName;
}

- (void)renderUI {
    
    // Implement in child classes
    //NSAssert(NO, @"renderUI is not implemented in class: %@", NSStringFromClass([self class]));
}

- (void)loadModel {
    
    // Implement in child classes
    //NSAssert(NO, @"renderUI is not implemented in class: %@", NSStringFromClass([self class]));
}

#pragma mark - Navigation

- (void)handleBackPressed {
    
    // Disable user interaction is used for keeping user in screen
    // So need to check before poping
    //if (self.view.isUserInteractionEnabled) {
        
        [self.navigationController popViewControllerAnimated:YES];
    //}
}

- (void)showDefaultNavigationBar {
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)hideDefaultNavigationBar {
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)hasNavigationBar {
    
    return !self.navigationController.navigationBarHidden;
}

#pragma mark - Modal screen handling

- (void)presentModalViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (SYSTEM_VERSION_LESS_THAN(@"8")) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [self presentViewController:viewController animated:animated completion:^{
            
            [viewController dismissViewControllerAnimated:NO completion:^{
                
                appDelegate.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentViewController:viewController animated:NO completion:nil];
                appDelegate.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                
            }];
        }];
        
    } else {
        
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:viewController animated:animated completion:nil];
    }
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
    
    [self.presentingViewController dismissViewControllerAnimated:animated completion:nil];
}

- (IBAction)cancelPressed:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)setToolbarHidden:(BOOL)hidden {
    
    if (hidden) {
        
        [_modalToolbar removeFromSuperview];
        
    } else {
        
        [self.view addSubview:_modalToolbar];
    }
    
    [_titleLabel setHidden:hidden];
}

#pragma mark - Override

- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
}

#pragma mark - Xib loading

- (UIView *)loadViewFromXibOfClass:(Class)class {
    
    NSString *xibName = NSStringFromClass(class);
    
    if (isIpad) {
        
        xibName = [NSString stringWithFormat:@"%@_ipad", xibName];
        
    } else {
        
        xibName = [NSString stringWithFormat:@"%@_iphone", xibName];
    }
    
    UIView *view = [self loadViewFromXib:xibName ofClass:class];
    return view;
}

- (UIView *)loadViewFromXib:(NSString *)name ofClass:(Class)class {
    
    UIView *loadedView = nil;
    
    NSArray *viewFromXib = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    if (viewFromXib.count > 0)
    {
        UIView *view = [viewFromXib objectAtIndex:0];
        if ([view isKindOfClass:class])
        {
            loadedView = view;
        }
    }
    return loadedView;
}

#pragma mark - Screen activity indicators

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

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark - Notification error handling

// Solution used from http://stackoverflow.com/questions/355168/proper-way-to-exit-iphone-application
/*- (void)closeTheApp {
    
    //home button press programmatically
    UIApplication *app = [UIApplication sharedApplication];
    [app performSelector:@selector(suspend)];
    
    //wait 2 seconds while app is going background
    [NSThread sleepForTimeInterval:2.0];
    
    //exit app when app is in background
    exit(EXIT_SUCCESS);
}*/

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

//#pragma mark - Popup loading

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
