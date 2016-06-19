//
//  BaseViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 2/6/14.
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

#if defined(DEBUG)
    #import "NetworkEnvironmentSwitch4Testing.h"
    #import "ConsoleLogViewController.h"
#endif

#import "BaseViewController.h"

#import "ViewControllerFactoryProtocol.h"
#import "MenuNavigator.h"

#import "AppDelegate.h"
#import "UserManager.h"

#import "ConstNetworkErrorCodes.h"

@interface BaseViewController () <UIGestureRecognizerDelegate> {
    
#if defined(DEBUG)
    NetworkEnvironmentSwitch4Testing *_networkSwitch4Testing;
    UITapGestureRecognizer *_networkChangeGestureRecognizer;
    BOOL _isVisibleDebugNetworkEnvironmentSwich;
    
    ConsoleLogViewController *_consoleLoggerVC;
    UILongPressGestureRecognizer *_consoleLoggerGestureRecognizer;
    BOOL _isVisibleConsoleLogger;
#endif
}

@end

@implementation BaseViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.reachabilityManager removeServiceObserver:self];
}

/*
 // This causes commonInit to be called twice upon creation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        [self commonInit];
    }
    
    return self;
}*/

/*
 // This causes commonInit to be called twice upon creation
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // Custom initialization
        [self commonInit];
    }
    return self;
}*/

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.reachabilityManager addServiceObserver:self];
    
    if (self.isModallyPressented) {
        
        [self addCustomModalNavigationBar];
        
    } else {
        
        [self addCustomNavigationBar];
    }
    
    [_viewManager prepareAccesibilityInViewController:self];
    
    // Observe for changes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationLocalizationHasChanged)
                                                 name:kNOTIFICATION_LOCALIZATION_HAS_CHANGED
                                               object:nil];
    
    //Adding environment switch buttons for DEBUG only
#if defined(DEBUG)
    
    [self addNetworkSwitches];
    
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Enable user interaction
    self.view.userInteractionEnabled = YES;
    
    // Log current screen
    [self logForCrashReports];
    
    // Listen for notifications
    [self subcribeForGeneralNotifications];
    
    // Make sure menu will be closed when user wants to open and tapps on any button which opens new screen. It's needed for iPad because otherwise swipe to go back stops working.
    [self closeMenuIfOpened];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Disable user interaction
    self.view.userInteractionEnabled = NO;
    
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
    
    DDLogError(@"[%@]: didReceiveMemoryWarning", NSStringFromClass([self class]));
}

// Logs current screen name
- (void)logForCrashReports {
    
    [_crashManager logScreenAction:NSStringFromClass([self class])];
}

#pragma mark - Public -

#pragma mark Custom initialization

- (instancetype)initWithViewManager:(id <ViewManagerProtocol>)viewManager crashManager:(id<CrashManagerProtocol>)crashManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager messageBarManager:(id<MessageBarManagerProtocol>)messageBarManager viewControllerFactory:(id<ViewControllerFactoryProtocol>)viewControllerFactory reachabilityManager:(id<ReachabilityManagerProtocol>)reachabilityManager context:(id)context model:(BaseModel *)model {
    
    self = [self init];
    if (self) {
        
        _viewManager = viewManager;
        _crashManager = crashManager;
        _analyticsManager = analyticsManager;
        _messageBarManager = messageBarManager;
        _viewControllerFactory = viewControllerFactory;
        _reachabilityManager = reachabilityManager;
        
        _context = context;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(setModel:)]) {
            
            [self performSelector:@selector(setModel:) withObject:model];
        }
#pragma clang diagnostic pop
        
        [self commonInit];
    }
    return self;
}

#pragma mark Modal screen handling

- (void)presentModalViewController:(BaseViewController *)viewController animated:(BOOL)animated {
    
    viewController.isModallyPressented = YES;
    
    UINavigationController *navController = nil;
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        navController = (UINavigationController *)viewController;
        
    } else {
        
        navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    
    if (isIpad && _shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad) {
        
        navController.navigationBar.hidden = YES;
    }
    
    navController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    // Changing from side menu to tabs.
    /*[self presentViewController:navController animated:animated completion:^{
     
     }];*/
    // This will make modal appear on top (and not behind) of tabs
    
    if (self.isModallyPressented) {
        
        [self presentViewController:navController animated:animated completion:^{
            
        }];
        
    } else {
        
        // For TabBar application
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController presentViewController:navController animated:animated completion:^{
            
       }];
    }
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
    
    [self.presentingViewController dismissViewControllerAnimated:animated completion:nil];
}

#pragma mark - Protected -

#pragma mark Common

// These methods are the main custom methods for initialing custom objects (commonInit), updating static UI (prepareUI), loading data (loadModel) and updating with data (renderUI)

- (void)commonInit {
    
    DDLogDebug(@"[%@]: commonInit", NSStringFromClass([self class]));
    
    // iPad related setting
    _shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad = YES;
}

- (void)prepareUI {
    
    DDLogDebug(@"[%@]: prepareUI", NSStringFromClass([self class]));
    
    // Removes blank header space when using tableViews and scrollViews
    // http://stackoverflow.com/a/19648625
    // TODO: causes login to show weirdly when opened for the second time
    //self.automaticallyAdjustsScrollViewInsets = NO;
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

#pragma mark Progress indicators

- (void)showScreenActivityIndicator {
    
    [_viewManager showScreenActivityIndicatorInView:self.view];
}

- (void)hideScreenActivityIndicator {
    
    [_viewManager hideScreenActivityIndicatorFromView:self.view];
}

#pragma mark Xib loading

- (UIView *)loadViewFromXib:(NSString *)name class:(Class)theClass {
    
    return [_viewManager loadViewFromXib:name class:theClass];
}

- (UIView *)loadViewFromXibWithClass:(Class)theClass {
    
    return [_viewManager loadViewFromXibWithClass:theClass];
}

#pragma mark Navigation handling

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

#pragma mark Rotation handling

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
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

#pragma mark Error handling

- (void)handleNetworkRequestSuccess:(NSNotification *)notification {
    
    // ..
}

- (void)handleNetworkRequestError:(NSNotification *)notification {
    
    // ...
    
    NSError *error = notification.userInfo[kNetworkRequestErrorNotificationUserInfoKey];
    
    // Check for error and only handle once, inside last screen
    if ([error isKindOfClass:[NSError class]] && self.navigationController.viewControllers.lastObject == self) {
        
        if (error.code == kNetworkRequestUnauthorizedCode) {
            
            // Go to start
            [self logoutAndGoBackToAppStartWithError:error];
            
        } else {
            
            [self.messageBarManager showMessageWithTitle:@"" description:error.localizedDescription type:MessageBarMessageTypeError duration:kMessageBarManagerMessageDuration];
        }
    }
}

#pragma mark Language change handling

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark Override: Screen title

- (void)setTitle:(NSString *)title {
    
    //[super setTitle:upperCaseTitle];
    self.navigationItem.title = title;
    
    // Setting title for top main or modal navigation bar
    BaseNavigationBar *navigationBar = (BaseNavigationBar *)self.navigationItem.titleView;
    navigationBar.titleLabel.text = title;
}

#pragma mark TopModalNavigationBarDelegate

- (void)didPressedCancelModal {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didPressedBackModal {
    
    [self.topModalNavigationBar showCancelButton];
}

#pragma mark TopNavigationBarDelegate

- (void)didPressedContacts {
    
    BaseViewController *vc = (BaseViewController *) [self.viewControllerFactory contactsViewControllerWithContext:nil];
    [self presentModalViewController:vc animated:YES];
}

- (void)didPressedBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didPressedMenu {
    
    MenuNavigator *menuNavigator = [REGISTRY getObject:[MenuNavigator class]];
    [menuNavigator toggleMenu];
}

#pragma mark ReachabilityManagerObserver

- (void)internetDidBecomeOn {
    
    [_viewManager hideNoInternetConnectionLabelInView:self.view];
}

- (void)internetDidBecomeOff {
    
    [_viewManager showNoInternetConnectionLabelInView:self.view];
}

#pragma mark Refresh control

- (void)addRefreshControlForView:(UIView *)view selector:(SEL)selector {
    
    if (!_refreshControl) {
        
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:selector
                  forControlEvents:UIControlEventValueChanged];
        [view addSubview:_refreshControl];
    }
}

#pragma mark Empty list label

- (UIButton *)addEmptyListLabelOnView:(UIView *)containerView message:(NSString *)message refreshSelector:(SEL)refreshSelector {
    
    UIButton *result = [self.viewManager addEmptyListLabelOnView:containerView message:message refreshSelector:refreshSelector refreshTarget:self];
    return result;
}

- (void)removeEmptyListLabelIfWasAddedBeforeOnView:(UIView *)containerView {
    
    [self.viewManager removeEmptyListLabelIfWasAddedBeforeOnView:containerView];
}

#pragma mark - Private -

- (void)addCustomNavigationBar {
    
    // No need to add navCtrl for screens without nagivation (for example menuVC)
    if (!self.navigationController) {
        
        return;
    }
    
    // Creating and adding custom navigation bar
    TopNavigationBar *navigationBar = (TopNavigationBar *)[self loadViewFromXibWithClass:[TopNavigationBar class]];
    navigationBar.delegate = self;
    
    self.navigationItem.titleView = navigationBar;
    
    // Add navigation bar style
    [TopNavigationBar applyStyleForNavigationBar:self.navigationController.navigationBar];
    
    // Hides default 1px gray bottom separator line
    //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // This is a work around to get rid of ellipsis when navigating back
    // Taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    // Hide back button if it's root view controller
    if (self.navigationController.viewControllers.count > 1) {
        
        [navigationBar showBackButton];
        
    } else {
        
        [navigationBar showMenuButton];
    }
}

- (void)addCustomModalNavigationBar {
    
    // Creating and adding custom navigation bar
    _topModalNavigationBar = (TopModalNavigationBar *)[self loadViewFromXibWithClass:[TopModalNavigationBar class]];
    _topModalNavigationBar.delegate = self;
    
    // Add navigation bar style
    [TopModalNavigationBar applyStyleForModalNavigationBar:self.navigationController.navigationBar];
    
    if (_shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad && isIpad) {
        
        // Add separator line
        [_topModalNavigationBar showHoritontalSeparatorLineView];
        
        // Add view and constraints
        [_modalContainerView addSubview:_topModalNavigationBar];
        [_topModalNavigationBar viewAddLeadingSpace:0 containerView:_modalContainerView];
        [_topModalNavigationBar viewAddTrailingSpace:0 containerView:_modalContainerView];
        [_topModalNavigationBar viewAddTopSpace:0 containerView:_modalContainerView];
        
    } else {
        
        // This will add navigation bar onto navigation controller's bar
        self.navigationItem.titleView = _topModalNavigationBar;
        // this is a work around to get rid of ellipsis when navigating back
        // taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    }
    
    // Show cancel by default
    [_topModalNavigationBar showCancelButton];
}

- (void)closeMenuIfOpened {
    
    // TODO...
}

- (void)subcribeForGeneralNotifications {
    
    // Reset previous observing (due to multiple calls through viewWillAppear:)
    [self unsubcribeFromGeneralNotifications];
    
    // Subscribe for network requests status notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkRequestError:) name:kNetworkRequestErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkRequestSuccess:) name:kNetworkRequestSuccessNotification object:nil];
    
    // Subscribe for language change notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationLocalizationHasChanged)
                                                 name:kNOTIFICATION_LOCALIZATION_HAS_CHANGED
                                               object:nil];
}

- (void)unsubcribeFromGeneralNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNetworkRequestErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNetworkRequestSuccessNotification object:nil];
}

- (void)logoutAndGoBackToAppStartWithError:(NSError *)error {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UserManager *userManager = [REGISTRY getObject:[UserManager class]];
    [userManager logout];
    
    [appDelegate showWalkthroughWithError:error];
}

#pragma mark - DEBUG: network switch and console logger -

#if defined(DEBUG)

- (void)addNetworkSwitches {
    
    // Add network change switch
    _networkSwitch4Testing = [[NetworkEnvironmentSwitch4Testing alloc] init];
    _networkSwitch4Testing.delegate = (id<NetworkEnvironmentSwitch4TestingDelegate>) self;
    //_networkChangeGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNetworkChangeSwitch)];
    //_networkChangeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    //_networkChangeGestureRecognizer.numberOfTapsRequired = 3;
    
    //[self.navigationItem.titleView addGestureRecognizer:_networkChangeGestureRecognizer];
    
    UIButton *networkChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    networkChangeButton.frame = CGRectMake(54, 5, 40, 30);
    networkChangeButton.backgroundColor = [UIColor grayColor]; //[UIColor greenColor];
    [networkChangeButton setTitle:@"Env" forState:UIControlStateNormal];
    [networkChangeButton addTarget:self action:@selector(handleNetworkChangeSwitch) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.titleView addSubview:networkChangeButton];
    
    // Add console log
    //_consoleLoggerGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleConsoleLog:)];
    //_consoleLoggerGestureRecognizer.minimumPressDuration = 0.5f;
    //_consoleLoggerGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    //[self.navigationItem.titleView addGestureRecognizer:_consoleLoggerGestureRecognizer];
    
    UIButton *consoleLoggerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    consoleLoggerButton.frame = CGRectMake(95, 5, 40, 30);
    consoleLoggerButton.backgroundColor = [UIColor grayColor]; //[UIColor magentaColor];
    [consoleLoggerButton setTitle:@"Log" forState:UIControlStateNormal];
    [consoleLoggerButton addTarget:self action:@selector(handleConsoleLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.titleView addSubview:consoleLoggerButton];
}

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

- (void)handleConsoleLog:(UILongPressGestureRecognizer*)sender {
    
    /*if (sender.state != UIGestureRecognizerStateEnded) {
        
        return;
    }*/
    
    if (!_isVisibleConsoleLogger) {
        
        _consoleLoggerVC = [self.viewControllerFactory consoleLogViewControllerWithContext:nil];
        _consoleLoggerVC.view.frame = self.view.bounds;
        
        [self.view addSubview:_consoleLoggerVC.view];
        
        // Need to showing alert/email sending
        [self addChildViewController:_consoleLoggerVC];
        [_consoleLoggerVC didMoveToParentViewController:self];
        
        _isVisibleConsoleLogger = YES;
        
    } else {
        
        [_consoleLoggerVC.view removeFromSuperview];
        [_consoleLoggerVC removeFromParentViewController];
        _consoleLoggerVC = nil;
        
        _isVisibleConsoleLogger = NO;
    }
}

#endif

@end
