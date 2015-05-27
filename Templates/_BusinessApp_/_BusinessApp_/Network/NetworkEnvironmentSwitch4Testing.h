//
//  NetworkEnvironmentSwitch4Testing.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
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