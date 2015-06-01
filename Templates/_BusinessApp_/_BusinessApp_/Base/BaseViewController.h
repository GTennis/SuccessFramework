//
//  BaseViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
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
#import "SettingsManagerProtocol.h"
#import "CrashManagerProtocol.h"
#import "AnalyticsManagerProtocol.h"
#import "MessageBarManagerProtocol.h"
#import "ViewControllerFactoryProtocol.h"
#import "BaseModel.h"

@class TopModalNavigationBar;

@protocol ViewControllerFactoryProtocol;

@interface BaseViewController : CoreViewController <BaseModelDelegate>

// For passing parameters between view controlers
@property (nonatomic, strong) id context;

// Dependencies
@property (nonatomic, strong) id<CrashManagerProtocol> crashManager;
@property (nonatomic, strong) id<AnalyticsManagerProtocol> analyticsManager;
@property (nonatomic, strong) id<MessageBarManagerProtocol> messageBarManager;
@property (nonatomic, strong) id<ViewControllerFactoryProtocol> viewControllerFactory;

@property (nonatomic) BOOL isModallyPressented;
@property (nonatomic, strong) IBOutlet UIView *modalContainerView;
@property (nonatomic) BOOL shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad; // iPad related setting

- (instancetype)initWithCrashManager:(id<CrashManagerProtocol>)crashManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager messageBarManager:(id<MessageBarManagerProtocol>)messageBarManager viewControllerFactory:(id<ViewControllerFactoryProtocol>)viewControllerFactory context:(id)context;

// Modal screen handling
@property (nonatomic, readonly) TopModalNavigationBar *modalNavigationBar;
- (void)presentModalViewController:(BaseViewController *)viewController animated:(BOOL)animated;
- (void)dismissModalViewControllerAnimated:(BOOL)animated;

// Override for custom handling
- (void)didPressedCancelModal;
- (void)didPressedBackModal;

// Override for custom screen name log
- (void)logForCrashReports;

@end
