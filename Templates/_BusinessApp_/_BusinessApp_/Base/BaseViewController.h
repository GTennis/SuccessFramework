//
//  BaseViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "CoreViewController.h"
#import "SettingsManagerProtocol.h"
#import "CrashManagerProtocol.h"
#import "AnalyticsManagerProtocol.h"
#import "MessageBarManagerProtocol.h"
#import "ViewControllerFactoryProtocol.h"
#import "BaseModel.h"

@protocol ViewControllerFactoryProtocol;

@interface BaseViewController : CoreViewController <BaseModelDelegate>

// For passing parameters between view controlers
@property (nonatomic, strong) id context;

// Dependencies
@property (nonatomic, strong) id<CrashManagerProtocol> crashManager;
@property (nonatomic, strong) id<AnalyticsManagerProtocol> analyticsManager;
@property (nonatomic, strong) id<MessageBarManagerProtocol> messageBarManager;
@property (nonatomic, strong) id<ViewControllerFactoryProtocol> viewControllerFactory;

- (instancetype)initWithCrashManager:(id<CrashManagerProtocol>)crashManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager messageBarManager:(id<MessageBarManagerProtocol>)messageBarManager viewControllerFactory:(id<ViewControllerFactoryProtocol>)viewControllerFactory context:(id)context;

//- (void)showNavigationBarRightButton;
//- (void)hideNavigationBarRightButton;
- (void)loadModel;
// Override for custom log
- (void)logForCrashReports;

@end
