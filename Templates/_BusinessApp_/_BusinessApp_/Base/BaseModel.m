//
//  BaseModel.m
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

#import "BaseModel.h"

#if defined(ENTERPRISE_BUILD) || defined(DEBUG)

#import "NetworkEnvironmentSwitch4Testing.h"
#import "BackendAPIClient.h"
#import "UserManagerProtocol.h"

#endif

@implementation BaseModel

@synthesize isLoaded = _isLoaded;
@synthesize delegate = _delegate;
@synthesize backendAPIClient = _backendAPIClient;
@synthesize settingsManager = _settingsManager;
@synthesize userManager = _userManager;
@synthesize reachabilityManager = _reachabilityManager;
@synthesize analyticsManager = _analyticsManager;
@synthesize context = _context;

- (instancetype)initWithUserManager:(id <UserManagerProtocol>)userManager backendAPIClient:(id <BackendAPIClientProtocol>)backendAPIClient settingsManager:(id <SettingsManagerProtocol>)settingsManager reachabilityManager:(id<ReachabilityManagerProtocol>)reachabilityManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager context:(id)context {
    
    self = [self init];
    if (self) {
        
        _userManager = userManager;
        _settingsManager = settingsManager;
        _backendAPIClient = backendAPIClient;
        _reachabilityManager = reachabilityManager;
        _analyticsManager = analyticsManager;
        
        // Not needed subscribe for all models for now. Instead every model should subscribe explicitly
        //[_realTimeDataManager addObserver:self];
        
        _context = context;
      
        [self commonInit];
        
#if defined(ENTERPRISE_BUILD) || defined(DEBUG)
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkEnvironmentChange:) name:kNetworkEnvironmentChangeNotification object:nil];
#endif
    }
    return self;
}

// Usualy unit tests instantiate model objects directly through init but we need commonInit to be called for setting initial values
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    
    return self;
}

- (void)dealloc {
    
    DLog(@"[%@]: dealloc", NSStringFromClass([self class]));
    
    //[_realTimeDataManager removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)commonInit {
    
    // Override this method in child classes for setting initial values. In this method all the needed dependencies are already injected
    // ...
}

- (void)loadData:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;

    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.isLoaded = YES;
            
            DLog(@"[%@]: didFinishModelLoadingWithData", NSStringFromClass([self class]));
            
            [weakSelf didFinishModelLoadingWithData:result];
        }
        else {
            
            weakSelf.isLoaded = NO;
        }
        
        callback(success, result, error);
    };
    
    DLog(@"[%@]: willStartModelLoading", NSStringFromClass([self class]));
    
    [self willStartModelLoading:wrappedCallback];
}

// Every subclass shoud override this method and perform data loading
- (void)didFinishModelLoadingWithData:(id)data {
    
    // Implement in child classes
    NSAssert(NO, @"didFinishModelLoadingWithData is not implemented in class: %@", NSStringFromClass([self class]));
}

// Every subclass shoud override this method and assign passed data to its internal property
- (void)willStartModelLoading:(Callback)callback {
    
    // Implement in child classes
    NSAssert(NO, @"willStartModelLoading is not implemented in class: %@", NSStringFromClass([self class]));
}

#pragma mark - Network change

#if defined(ENTERPRISE_BUILD) || defined(DEBUG)

- (void)handleNetworkEnvironmentChange:(NSNotification *)notification {

    // Replace dependencies with new dependencies
    self.backendAPIClient = [REGISTRY getObject:[BackendAPIClient class]];
}

#endif

@end
