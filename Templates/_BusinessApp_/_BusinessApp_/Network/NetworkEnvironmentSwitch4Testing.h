//
//  NetworkEnvironmentSwitch4Testing.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#define kNetworkEnvironmentChangeNotification @"NetworkEnvironmentChangeNotification"

typedef NS_ENUM(NSInteger, NetworkEnvironmentType) {
    
    kEnvironmentStaging,
    kEnvironmentDevelopment,
    kEnvironmentProduction,
    kEnvironmentCount   // For static tableViews it's very convenient to define last enum entry for total rows count and use in numberOfRowsAtSection:
};

@protocol NetworkEnvironmentSwitch4TestingDelegate <NSObject>

- (void)didChangeNetworkEnvironment;

@end

@interface NetworkEnvironmentSwitch4Testing : NSObject

@property (nonatomic, weak) id<NetworkEnvironmentSwitch4TestingDelegate> delegate;

- (void)addNetworkEnvironmentChangeButtonsInsideView:(UIView *)containerView;
- (void)removeNetworkEnvironmentChangeButtons;

@end