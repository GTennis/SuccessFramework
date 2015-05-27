//
//  NetworkEnvironmentSwitch4Testing.m
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

#import "NetworkEnvironmentSwitch4Testing.h"
#import "ConstNetworkConfig.h"
#import "BackendAPIClient.h"
#import "AnalyticsManager.h"

// Used for testing only
#define kDevButtonTag 201409181
#define kStageButtonTag 201409182
#define kProductionButtonTag 201409183

@interface NetworkEnvironmentSwitch4Testing () {
    
    __weak UIView *_containerView;
}

@end

@implementation NetworkEnvironmentSwitch4Testing

- (void)addNetworkEnvironmentChangeButtonsInsideView:(UIView *)containerView {
    
    _containerView = containerView;
    
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = 44;
    CGFloat buttonSeparatorSize = 10;
    //CGFloat buttonOffsetY = 40;
    CGFloat buttonOriginY = _containerView.bounds.size.height - buttonHeight;
    CGFloat buttonOriginX = 0;
    
    //NSLog(@"%@", NSStringFromCGSize(self.view.bounds.size));
    //NSLog(@"%@", NSStringFromCGSize([[UIApplication sharedApplication] statusBarFrame].size));
    
    // http://stackoverflow.com/questions/2518695/how-to-get-iphones-current-orientation
    /*UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
     if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
     
     buttonOriginY = self.view.bounds.size.height - buttonHeight - buttonOffsetY - [[UIApplication sharedApplication] statusBarFrame].size.height;
     
     } else {
     
     buttonOriginY = self.view.bounds.size.height - buttonHeight - buttonOffsetY - [[UIApplication sharedApplication] statusBarFrame].size.width;
     }*/
    
    UIFont *font = [UIFont systemFontOfSize:12];
    
    UIButton *devButton = [[UIButton alloc] initWithFrame:(CGRect){buttonOriginX, buttonOriginY, buttonWidth, buttonHeight}];
    [devButton setTitle:@"DEV" forState:UIControlStateNormal];
    [devButton addTarget:self action:@selector(networkEnvironmentDevPressed:) forControlEvents:UIControlEventTouchDown];
    [devButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    devButton.backgroundColor = [UIColor lightGrayColor];
    devButton.titleLabel.font = font;
    devButton.tag = kDevButtonTag;
    
    UIButton *stagButton = [[UIButton alloc] initWithFrame:(CGRect){(buttonOriginX +buttonWidth + buttonSeparatorSize) * 1, buttonOriginY, buttonWidth, buttonHeight}];
    [stagButton setTitle:@"STAGE" forState:UIControlStateNormal];
    [stagButton addTarget:self action:@selector(networkEnvironmentStagePressed:) forControlEvents:UIControlEventTouchDown];
    [stagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    stagButton.backgroundColor = [UIColor lightGrayColor];
    stagButton.titleLabel.font = font;
    stagButton.tag = kStageButtonTag;
    
    UIButton *prodButton = [[UIButton alloc] initWithFrame:(CGRect){buttonOriginX +  (buttonWidth + buttonSeparatorSize) * 2, buttonOriginY, buttonWidth, buttonHeight}];
    [prodButton setTitle:@"PROD" forState:UIControlStateNormal];
    [prodButton addTarget:self action:@selector(networkEnvironmentProductionPressed:) forControlEvents:UIControlEventTouchDown];
    [prodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    prodButton.backgroundColor = [UIColor lightGrayColor];
    prodButton.titleLabel.font = font;
    prodButton.tag = kProductionButtonTag;
    
    [_containerView addSubview:devButton];
    [_containerView addSubview:stagButton];
    [_containerView addSubview:prodButton];
}

- (void)removeNetworkEnvironmentChangeButtons {
    
    UIButton *devButton = (UIButton *)[_containerView viewWithTag:kDevButtonTag];
    UIButton *stageButton = (UIButton *)[_containerView viewWithTag:kStageButtonTag];
    UIButton *productionButton = (UIButton *)[_containerView viewWithTag:kProductionButtonTag];
    
    [devButton removeFromSuperview];
    [stageButton removeFromSuperview];
    [productionButton removeFromSuperview];
}

#pragma mark - Helpers

- (void)changeNetworkEnvironment:(NetworkEnvironmentType)environment {
    
    NSString *baseBackendUrlString = nil;
    
    switch (environment) {
            
        case kEnvironmentStaging:
            
            baseBackendUrlString = STAGE_BASE_URL;
            break;
            
        case kEnvironmentDevelopment:
            
            baseBackendUrlString = DEVELOPMENT_BASE_URL;
            break;
            
        case kEnvironmentProduction:
            
            baseBackendUrlString = PRODUCTION_BASE_URL;
            break;
            
        default:
            break;
    }
    
    [REGISTRY unRegisterObject:[BackendAPIClient class]];
    
    NSURL *backendBaseUrl = [NSURL URLWithString:baseBackendUrlString];
    id<AnalyticsManagerProtocol> analyticsManager = [REGISTRY getObject:[AnalyticsManager class]];
    
    BackendAPIClient *backendAPIClient = [[BackendAPIClient alloc] initWithBaseURL:backendBaseUrl analyticsManager:analyticsManager];
    
    [REGISTRY registerObject:backendAPIClient];
    
    // Notify observers
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkEnvironmentChangeNotification object:nil];
}

- (void)clearPreviousNetworkEnvironmentSelections {
    
    // Retrieve buttons
    UIButton *devButton = (UIButton *)[_containerView viewWithTag:kDevButtonTag];
    UIButton *stageButton = (UIButton *)[_containerView viewWithTag:kStageButtonTag];
    UIButton *productionButton = (UIButton *)[_containerView viewWithTag:kProductionButtonTag];
    
    // Clear selections
    devButton.backgroundColor = [UIColor lightGrayColor];
    stageButton.backgroundColor = [UIColor lightGrayColor];
    productionButton.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)networkEnvironmentDevPressed:(id)sender {
    
    [self changeNetworkEnvironment:kEnvironmentDevelopment];
    
    [self clearPreviousNetworkEnvironmentSelections];
    UIButton *button = (UIButton *)[_containerView viewWithTag:kDevButtonTag];
    button.backgroundColor = [UIColor redColor];
    
    // Inform the delegate
    if ([_delegate respondsToSelector:@selector(didChangeNetworkEnvironment)]) {
        
        [_delegate didChangeNetworkEnvironment];
    }
}

- (IBAction)networkEnvironmentStagePressed:(id)sender {
    
    [self changeNetworkEnvironment:kEnvironmentStaging];
    
    [self clearPreviousNetworkEnvironmentSelections];
    UIButton *button = (UIButton *)[_containerView viewWithTag:kStageButtonTag];
    button.backgroundColor = [UIColor redColor];
    
    // Inform the delegate
    if ([_delegate respondsToSelector:@selector(didChangeNetworkEnvironment)]) {
        
        [_delegate didChangeNetworkEnvironment];
    }
}

- (IBAction)networkEnvironmentProductionPressed:(id)sender {
    
    [self changeNetworkEnvironment:kEnvironmentProduction];
    
    [self clearPreviousNetworkEnvironmentSelections];
    UIButton *button = (UIButton *)[_containerView viewWithTag:kProductionButtonTag];
    button.backgroundColor = [UIColor redColor];
    
    // Inform the delegate
    if ([_delegate respondsToSelector:@selector(didChangeNetworkEnvironment)]) {
        
        [_delegate didChangeNetworkEnvironment];
    }
}

@end
