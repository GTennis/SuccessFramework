//
//  ViewManager.m
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

#import "ViewManager.h"
#import "MBProgressHUD.h"
#import "ConnectionStatusLabel.h"

// Activity indicator tag
#define kScreenActivityIndicatorTag 20131217

@implementation ViewManager

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

#pragma mark - Progress indicators -

- (void)showScreenActivityIndicatorInView:(UIView *)view {
    
    // Disable user interface
    view.userInteractionEnabled = NO;
    
    MBProgressHUD *activityView = (MBProgressHUD *) [view viewWithTag:kScreenActivityIndicatorTag];
    
    if (!activityView) {
        
        activityView = [[MBProgressHUD alloc] initWithView:view];
        activityView.tag = kScreenActivityIndicatorTag;
        activityView.color = [UIColor blackColor];
        activityView.center = view.center;
    }
    
    [view addSubview:activityView];
    [view bringSubviewToFront:activityView];
    [activityView show:YES];
}

- (void)hideScreenActivityIndicatorFromView:(UIView *)view {
    
    MBProgressHUD *activityView = (MBProgressHUD *) [view viewWithTag:kScreenActivityIndicatorTag];
    
    if (activityView) {
        
        [activityView hide:YES];
        [activityView removeFromSuperview];
    }
    
    view.userInteractionEnabled = YES;
}

#pragma mark - Internet connection status labels

- (void)showNoInternetConnectionLabelInView:(UIView *)containerView {
    
    ConnectionStatusLabel *label = (ConnectionStatusLabel *)[containerView viewWithTag:kConnectionStatusLabelTag];
    
    if (!label) {
        
        ConnectionStatusLabel *label = [[ConnectionStatusLabel alloc] init];
        [containerView addSubview:label];
        
        CGFloat margin = containerView.bounds.size.width * 0.1f;
        
        [label viewAddLeadingSpace:margin containerView:containerView];
        [label viewAddTrailingSpace:-margin containerView:containerView];
        [label viewAddTopSpace:margin containerView:containerView];
    }
}

- (void)hideNoInternetConnectionLabelInView:(UIView *)containerView {
    
    ConnectionStatusLabel *label = (ConnectionStatusLabel *)[containerView viewWithTag:kConnectionStatusLabelTag];
    [label removeFromSuperview];
}

#pragma mark - For functional testing

- (void)prepareAccesibilityInViewController:(UIViewController *)viewController {
    
    // Add identifiers for functional tests
    viewController.view.isAccessibilityElement = YES;
    NSString *screenName = NSStringFromClass(viewController.class);
    screenName = [screenName stringByReplacingOccurrencesOfString:@"_iphone" withString:@""];
    screenName = [screenName stringByReplacingOccurrencesOfString:@"_ipad" withString:@""];
    viewController.view.accessibilityLabel = screenName;
    viewController.view.accessibilityIdentifier = screenName;
}

@end
