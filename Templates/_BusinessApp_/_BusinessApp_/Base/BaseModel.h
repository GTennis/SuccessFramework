//
//  BaseModel.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
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
