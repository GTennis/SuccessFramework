//
//  BaseModel.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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

#import "ParsableObject.h"
#import "UserManagerProtocol.h"
#import "BackendAPIClientProtocol.h"
#import "SettingsManagerProtocol.h"
#import "AnalyticsManagerProtocol.h"
#import "ReachabilityManagerProtocol.h"

@protocol BaseModelDelegate;

// Base model protocol
@protocol BaseModel <NSObject>

@property (nonatomic, weak) id<BaseModelDelegate> delegate;
@property (nonatomic) BOOL isLoaded;

// For passed parameters
@property (nonatomic, strong) id context;

// Dependencies
@property (nonatomic, strong) id<UserManagerProtocol> userManager;
@property (nonatomic, strong) id<SettingsManagerProtocol> settingsManager;
@property (nonatomic, strong) id<BackendAPIClientProtocol> backendAPIClient;
@property (nonatomic, strong) id<ReachabilityManagerProtocol> reachabilityManager;
@property (nonatomic, strong) id<AnalyticsManagerProtocol> analyticsManager;

- (instancetype)initWithUserManager:(id <UserManagerProtocol>)userManager backendAPIClient:(id <BackendAPIClientProtocol>)backendAPIClient settingsManager:(id <SettingsManagerProtocol>)settingsManager reachabilityManager:(id<ReachabilityManagerProtocol>)reachabilityManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager context:(id)context;

- (void)loadData:(Callback)callback;

//-- Protected --
- (void)commonInit;
- (void)willStartModelLoading:(Callback)callback;
- (void)didFinishModelLoadingWithData:(id)data;
//-- End of Protected --

@optional

@property (nonatomic, readonly) id<ParsableObject> list;
@property (nonatomic, readonly) id<ParsableObject> details;

@end

// BaseModelDelegate
@protocol BaseModelDelegate <NSObject>

@optional

- (void)modelHasChangedWithData:(id)data;
- (void)modelFailedToChangeDataWithError:(NSError *)error;

@end

// Base class
@interface BaseModel : NSObject <BaseModel>

@end
