//
//  UserContainerViewController_ipad.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 27/05/15.
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

#import "UserContainerViewController_ipad.h"

@interface UserContainerViewController_ipad () {
 
    BOOL _isKeyboardShown;
}

@end

@implementation UserContainerViewController_ipad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Observe keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard handling

- (void)keyboardWillAppear:(NSNotification *)notification {
    
    _isKeyboardShown = YES;
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    
    _isKeyboardShown = NO;
}

#pragma mark - Override

- (CGSize)containerViewSizeForLogin {
    
    return self.containerView.bounds.size;
}

- (CGSize)containerViewSizeForSignUp {
    
    return self.containerView.bounds.size;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    __weak typeof (UIView *) weakBackgroundMaskView = _backgroundMaskView;
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        weakBackgroundMaskView.alpha = 0.6f;
        
    } completion:nil];
}

#pragma mark - IBOutlets

- (IBAction)outsideContentViewTapPressed:(id)sender {
    
    if (_isKeyboardShown) {
        
        [self closeKeyboard];
        
    } else {
        
        _backgroundMaskView.alpha = 0;
        
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Helpers

- (void)closeKeyboard {
    
    BaseDetailsViewController *currentVc = [self.childViewControllers lastObject];
    [currentVc.keyboardControls.activeField resignFirstResponder];
}

@end
