//
//  ViewManagerProtocol.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 9/27/15.
//  Copyright © 2015 Gytenis Mikulėnas 
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

@protocol ViewManagerProtocol <NSObject>

#pragma mark - Xib loading

- (UIView *)loadViewFromXib:(NSString *)name class:(Class)theClass;
- (UIView *)loadViewFromXibWithClass:(Class)theClass;

#pragma mark - Progress indicators

- (void)showScreenActivityIndicatorInView:(UIView *)view;
- (void)hideScreenActivityIndicatorFromView:(UIView *)view;

#pragma mark - Internet connection status labels

- (void)showNoInternetConnectionLabelInView:(UIView *)containerView;
- (void)hideNoInternetConnectionLabelInView:(UIView *)containerView;

#pragma mark - For functional testing

- (void)prepareAccesibilityInViewController:(UIViewController *)viewController;

@end
