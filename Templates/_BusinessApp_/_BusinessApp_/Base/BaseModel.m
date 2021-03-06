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

#if defined(DEBUG)

#import "NetworkEnvironmentSwitch4Testing.h"
#import "UserManagerProtocol.h"

#endif

@implementation BaseModel

@synthesize isLoaded = _isLoaded;
@synthesize delegate = _delegate;
@synthesize networkOperationFactory = _networkOperationFactory;
@synthesize settingsManager = _settingsManager;
@synthesize userManager = _userManager;
@synthesize reachabilityManager = _reachabilityManager;
@synthesize analyticsManager = _analyticsManager;
@synthesize context = _context;

- (void)dealloc {
    
    DDLogDebug(@"[%@]: dealloc", NSStringFromClass([self class]));
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public -

- (instancetype)initWithUserManager:(id <UserManagerProtocol>)userManager networkOperationFactory:(id <NetworkOperationFactoryProtocol>)networkOperationFactory settingsManager:(id <SettingsManagerProtocol>)settingsManager reachabilityManager:(id<ReachabilityManagerProtocol>)reachabilityManager analyticsManager:(id<AnalyticsManagerProtocol>)analyticsManager context:(id)context {
    
    self = [self init];
    if (self) {
        
        _userManager = userManager;
        _settingsManager = settingsManager;
        _networkOperationFactory = networkOperationFactory;
        _reachabilityManager = reachabilityManager;
        _analyticsManager = analyticsManager;
        
        _context = context;
        
        [self commonInit];
        
#if defined(DEBUG)
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkEnvironmentChange:) name:kNetworkEnvironmentChangeNotification object:nil];
#endif
    }
    return self;
}

- (void)loadData:(Callback)callback {
    
    __weak typeof(self) weakSelf = self;
    
    Callback wrappedCallback = ^(BOOL success, id result, NSError *error) {
        
        if (success) {
            
            weakSelf.isLoaded = YES;
            
        } else {
            
            weakSelf.isLoaded = NO;
        }
        
        DDLogDebug(@"[%@]: didFinishModelLoadingWithData:error:%@", NSStringFromClass([self class]), error);
        
        [weakSelf didFinishModelLoadingWithData:result error:error];
        
        callback(success, result, error);
    };
    
    DDLogDebug(@"[%@]: willStartModelLoading", NSStringFromClass([self class]));
    
    [self willStartModelLoading:wrappedCallback];
}

#pragma mark - Protected -

- (void)commonInit {
    
    // Override this method in child classes for setting initial values. In this method all the needed dependencies are already injected
    // ...
}

#pragma mark - ViewControllerModelProtocol -

// Every subclass shoud override this method and perform data loading
- (void)didFinishModelLoadingWithData:(id)data error:(NSError *)error {
    
    // Implement in child classes
    NSAssert(NO, @"didFinishModelLoadingWithData:error: is not implemented in class: %@", NSStringFromClass([self class]));
}

// Every subclass shoud override this method and assign passed data to its internal property
- (void)willStartModelLoading:(Callback)callback {
    
    // Implement in child classes
    NSAssert(NO, @"willStartModelLoading is not implemented in class: %@", NSStringFromClass([self class]));
}

#pragma mark - DEBUG: Network change handling

#if defined(DEBUG)

- (void)handleNetworkEnvironmentChange:(NSNotification *)notification {

    // Previously APIClients were used and injected to models. Currently there's a factory factory
    // ...
    // Replace dependencies with new dependencies
    //_backendAPIClient = [REGISTRY getObject:[BackendAPIClient class]];
}

#endif

@end
