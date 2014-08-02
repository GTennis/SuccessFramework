//
//  BaseViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#if defined(ENTERPRISE_BUILD) || defined(DEBUG)
    #import "NetworkEnvironmentSwitch4Testing.h"
    #import "ConsoleLogViewController.h"
#endif

#import "BaseViewController.h"
#import "GMAlertView.h"
#import "TopNavigationBar.h"
#import "APIClientErrorHandler.h"
#import "ViewControllerFactoryProtocol.h"
#import "MenuNavigator.h"

@interface BaseViewController () <TopNavigationBarDelegate, UIGestureRecognizerDelegate> {
    
#if defined(ENTERPRISE_BUILD) || defined(DEBUG)
    NetworkEnvironmentSwitch4Testing *_networkSwitch4Testing;
    UISwipeGestureRecognizer *_swipeNetworkChangeGestureRecognizer;
    BOOL _isVisibleDebugNetworkEnvironmentSwich;
    
    ConsoleLogViewController *_consoleLoggerVC;
    UISwipeGestureRecognizer *_swipeConsoleLoggerGestureRecognizer;
    BOOL _isVisibleConsoleLogger;
#endif
}

@end

@implementation BaseViewController

#pragma mark - Override

- (void)dealloc {
    
    DLog(@"[%@]: dealloc", NSStringFromClass([self class]));
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithCrashManager:(id<CrashManagerProtocol>)crashManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager messageBarManager:(id<MessageBarManagerProtocol>)messageBarManager viewControllerFactory:(id<ViewControllerFactoryProtocol>)viewControllerFactory context:(id)context {
    
    self = [self init];
    if (self) {
        
        _crashManager = crashManager;
        _analyticsManager = analyticsManager;
        _messageBarManager = messageBarManager;
        _viewControllerFactory = viewControllerFactory;
        
        _context = context;
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    [super commonInit];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addCustomNavigationBar];
    
    //Adding environment switch buttons for DEBUG only
#if defined(ENTERPRISE_BUILD) || defined(DEBUG)
    
    // Add network change switch
    _networkSwitch4Testing = [[NetworkEnvironmentSwitch4Testing alloc] init];
    _networkSwitch4Testing.delegate = (id<NetworkEnvironmentSwitch4TestingDelegate>) self;
    _swipeNetworkChangeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleNetworkChangeSwitch)];
    _swipeNetworkChangeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.navigationItem.titleView addGestureRecognizer:_swipeNetworkChangeGestureRecognizer];
    
    // Add console log
    _swipeConsoleLoggerGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleConsoleLog)];
    _swipeConsoleLoggerGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.navigationItem.titleView addGestureRecognizer:_swipeConsoleLoggerGestureRecognizer];
    
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Log current screen
    [self logForCrashReports];
    
    // Listen for notifications
    [self subcribeForGeneralNotifications];
    
    // Make sure menu will be closed when user wants to open and tapps on any button which opens new screen. It's needed for iPad because otherwise swipe to go back stops working.
    [self closeMenuIfOpened];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Stop listening for notifications
    [self unsubcribeFromGeneralNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    /*
    // Fix: if navigation controller contains only single view controller AND user swipes back on any screen place (native back interactive gesture) AND clicks on button which pushes next view controller THEN next screen is pushed but not shown. Therefore disabling native back swipe for the first view controller because swipe back does nothing anyway
    // Partially used from: https://bhaveshdhaduk.wordpress.com/2014/05/17/ios-7-enable-or-disable-back-swipe-gesture-in-uinavigationcontroller/
    if ((self.navigationController.viewControllers.count == 1)) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        // enable swiping on the top view
        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
        
        
    } else {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        // disable swiping on the top view
        [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    DLog(@"[%@]: didReceiveMemoryWarning", NSStringFromClass([self class]));
}

- (void)loadModel {
    
    // Implement in child classes
    //NSAssert(NO, @"loadModel is not implemented in class: %@", NSStringFromClass([self class]));
}

// Override for custom log
- (void)logForCrashReports {
    
    [_crashManager logScreenAction:NSStringFromClass([self class])];
}

#pragma mark - Override Notification error handling


- (void)handleNetworkRequestError:(NSNotification *)notification {
    
    [super handleNetworkRequestError:notification];
    
#warning TODO
    // Get error code and update error image and labels
    //NSError *error = notification.userInfo[kNetworkRequestErrorNotificationUserInfoKey];
    
    GMAlertView *alertView = [APIClientErrorHandler alertViewFromAPIErrorNotification:notification presentingViewController:self];
    
    // Ideally every request could return AppNeedsUpdate in case of app is too old. But we don't have it now and we have to make a separate call to handle it
    /*if (error.code == kNetworkRequestAppNeedsUpdateError) {
     
     alertView.completion = ^(NSInteger buttonIndex) {
     
     if (buttonIndex == 0) {
     
     NSString *iTunesLink = kAppItunesLink;
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
     
     [super closeTheApp];
     
     } else {
     
     [super closeTheApp];
     }
     };
     
     }*/

    [alertView show];
    
}

- (void)handleNetworkRequestSuccess:(NSNotification *)notification {
    
    [super handleNetworkRequestSuccess:notification];
}

#pragma mark - Override Navigation

- (void)handleBackPressed {
    
    [super handleBackPressed];
}

- (void)handleMenuPressed {
    
    MenuNavigator *menuNavigator = [REGISTRY getObject:[MenuNavigator class]];
    [menuNavigator toggleMenu];
}

#pragma mark - Override

- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    
    // Setting title for our custom titleView which is actualy used
    TopNavigationBar *navigationBar = (TopNavigationBar *)self.navigationItem.titleView;
    navigationBar.titleLabel.text = title;
}

/*- (void)showNavigationBarRightButton {
 
 AppNavigationBar *navigationBar = (AppNavigationBar *) self.navigationItem.titleView;
 navigationBar.btnSearch.hidden = NO;
 }
 
 - (void)hideNavigationBarRightButton {
 
 AppNavigationBar *navigationBar = (AppNavigationBar *) self.navigationItem.titleView;
 navigationBar.btnSearch.hidden = YES;
 }*/

#pragma mark - Helpers

- (void)addCustomNavigationBar {
    
    // Creating and adding custom navigation bar
    TopNavigationBar *navigationBar = (TopNavigationBar *)[self loadViewFromXibOfClass:[TopNavigationBar class]];
    navigationBar.delegate = self;
    self.navigationItem.titleView = navigationBar;
    //this is a work around to get rid of ellipsis when navigating back
    //taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    
    // Hide back button if it's root view controller
    if (self.navigationController.viewControllers.count > 1) {
        
        navigationBar.backButton.hidden = NO;
        navigationBar.menuButton.hidden = YES;
        
    } else {
        
        navigationBar.backButton.hidden = YES;
        navigationBar.menuButton.hidden = NO;
    }
}

- (void)closeMenuIfOpened {
    
    // TODO...
}

#pragma mark - AppNavigationBarDelegate

- (void)didPressedContacts {
    
    UIViewController *vc = (UIViewController *) [self.viewControllerFactory contactsViewControllerWithContext:nil];
    [self presentModalViewController:vc animated:YES];
}

- (void)didPressedBack {
    
    [self handleBackPressed];
}

- (void)didPressedMenu {
    
    [self handleMenuPressed];
}

#pragma mark - Rotations

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    if (isIpad) {
        
        return (UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft);
        
    } else if (isIphone) {
        
        return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
        
    } else {
        
        return UIInterfaceOrientationMaskPortrait;
    }
}

// This method is needed when we support several orientations but screen looks best for one particular rotation. This is good when need to present screen in specific exceptional orientation. However, in our partical case we don't have and it causes screens to flip upside when app launched in not prefered orientation.
/*- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
 
 if (isIpad) {
 
 return UIInterfaceOrientationLandscapeRight;
 
 } else if (isIphone) {
 
 return UIInterfaceOrientationPortraitUpsideDown;
 
 } else {
 
 return UIInterfaceOrientationPortrait;
 }
 }*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    if (isIpad) {
        
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
        
    } else if (isIphone) {
        
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
        
    } else {
        
        return UIInterfaceOrientationPortrait;
    }
}

#pragma mark - Notifications

- (void)subcribeForGeneralNotifications {
    
    // Reset previous observing (due to multiple calls through viewWillAppear:)
    [self unsubcribeFromGeneralNotifications];
    
    // Subscribe for network requests status notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkRequestError:) name:kNetworkRequestErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkRequestSuccess:) name:kNetworkRequestSuccessNotification object:nil];
}

- (void)unsubcribeFromGeneralNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNetworkRequestErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNetworkRequestSuccessNotification object:nil];
}

#pragma mark - For ENTERPRISE_BUILD: network switch and console logger

#if defined(ENTERPRISE_BUILD) || defined(DEBUG)

- (void)handleNetworkChangeSwitch {
    
    if (!_isVisibleDebugNetworkEnvironmentSwich) {
        
        [_networkSwitch4Testing addNetworkEnvironmentChangeButtonsInsideView:self.view];
        
        _isVisibleDebugNetworkEnvironmentSwich = YES;
        
    } else {
        
        [_networkSwitch4Testing removeNetworkEnvironmentChangeButtons];
        
        _isVisibleDebugNetworkEnvironmentSwich = NO;
    }
}

- (void)didChangeNetworkEnvironment {
    
    [self loadModel];
}

- (void)handleConsoleLog {
    
    if (!_isVisibleConsoleLogger) {
        
        _consoleLoggerVC = [[ConsoleLogViewController alloc] init];
        _consoleLoggerVC.view.frame = self.view.bounds;
        
        [self.view addSubview:_consoleLoggerVC.view];
        
        _isVisibleConsoleLogger = YES;
        
    } else {
        
        [_consoleLoggerVC.view removeFromSuperview];
        _consoleLoggerVC = nil;
        
        _isVisibleConsoleLogger = NO;
    }
}

#endif

@end
