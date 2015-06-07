//
//  UserContainerViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
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

#import "UserContainerViewController.h"
#import "UserLoginViewController.h"
#import "UserSignUpViewController.h"
#import "UserForgotPasswordViewController.h"
#import "TopModalNavigationBar.h"

#define kUserContainerViewControllerLoginTitle @"Login"
#define kUserContainerViewControllerSignUpTitle @"SignUp"
#define kUserContainerViewControllerForgotPasswordTitle @"Forgot password"

@interface UserContainerViewController ()

@end

@implementation UserContainerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
    [self showLoginWithAnimation:NO];
}

- (void)showLoginWithAnimation:(BOOL)animated {

    // Prepare UI
    self.title = GMLocalizedString(kUserContainerViewControllerLoginTitle);
    [self.topModalNavigationBar showCancelButton];
    
    // Perform transition
    [self transitionWithNextViewController:_userLoginVC animated:animated];
}

- (void)showSignUpWithAnimation:(BOOL)animated {

    // Prepare UI
    self.title = GMLocalizedString(kUserContainerViewControllerSignUpTitle);
    [self.topModalNavigationBar showBackButton];

    // Perform transition
    [self transitionWithNextViewController:_userSignUpVC animated:animated];
}

- (void)showForgotPasswordWithAnimation:(BOOL)animated email:(NSString *)email {
    
    // Prepare UI
    self.title = GMLocalizedString(kUserContainerViewControllerForgotPasswordTitle);
    //[_userForgotPasswordVC setEmail:email];
    [self.topModalNavigationBar showBackButton];

    // Perform transition
    [self transitionWithNextViewController:_userForgotPasswordVC animated:animated];
}

#pragma mark - Protected methods

- (void)commonInit {
    
    [super commonInit];
    
    _userLoginVC = [self.viewControllerFactory userLoginViewControllerWithContext:nil];
    _userLoginVC.delegate = self;
    
    _userSignUpVC = [self.viewControllerFactory userSignUpViewControllerWithContext:nil];
    _userSignUpVC.delegate = self;
    
    _userForgotPasswordVC = [self.viewControllerFactory userForgotPasswordViewControllerWithContext:nil];
    _userForgotPasswordVC.delegate = self;
}

- (void)prepareUI {
    
    [super prepareUI];
    
    // ...
}

- (void)renderUI {
    
    [super renderUI];
    
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    // ...
}

#pragma mark - Override TopModalNavigationBarDelegate

- (void)didPressedBackModal {
    
     [self showLoginWithAnimation:YES];
}

- (void)didPressedCancelModal {
    
    [super didPressedCancelModal];
    
    [_userLoginVC clearTextFields];
}

#pragma mark - UserLoginViewControllerDelegate

- (void)didFinishLogin {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didFinishSignUp {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didPressSignUp {
    
    [self showSignUpWithAnimation:YES];
}

- (void)didPressForgotPasswordWithEmail:(NSString *)email {
    
    
}

- (CGSize)containerViewSizeForLogin {
    
    return CGSizeZero;
}

#pragma mark - UserSignUpViewControllerDelegate

- (CGSize)containerViewSizeForSignUp {
    
    return CGSizeZero;
}

#pragma mark - UserForgotPasswordViewControllerDelegate

- (void)didSendEmailToUser {
    
    [self showLoginWithAnimation:YES];
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
}

#pragma mark - Helpers

- (void)transitionWithNextViewController:(UIViewController *)nextViewController animated:(BOOL)animated {
    
    UIViewController *currentViewController = [self.childViewControllers firstObject];
    
    if (animated) {
        
        __weak typeof (self) weakSelf = self;
        
        [currentViewController removeFromParentViewController];
        [self addNextViewController:nextViewController];
        
        [UIView transitionWithView:self.containerView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            
                        } completion:^(BOOL finished){
                        
                            [weakSelf removePreviousViewController:currentViewController];
                        }
         ];
        
    } else {
        
        [self removePreviousViewController:currentViewController];
        [self addNextViewController:nextViewController];
    }
}

- (void)removePreviousViewController:(UIViewController *)viewController {
    
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)addNextViewController:(UIViewController *)nextViewController {
    
    // Adjust size
    nextViewController.view.frame = self.containerView.bounds;
    
    // Add
    [self addChildViewController:nextViewController];
    [self.containerView addSubview:nextViewController.view];
}

@end
