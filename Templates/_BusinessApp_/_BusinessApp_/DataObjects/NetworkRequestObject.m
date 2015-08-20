//
//  NetworkRequestObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 26/08/15.
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

#import "NetworkRequestObject.h"

@implementation NetworkRequestObject

@synthesize baseUrl = _baseUrl;
@synthesize relativeUrl = _relativeUrl;
@synthesize method = _method;
@synthesize group = _group;

#pragma mark - Public -

- (instancetype)initWithBackendEnvironment:(BackendEnvironment)backendEnvironment {
    
    self = [self init];
    if (self) {
        
        // Auto pick environment for app config request
        switch (backendEnvironment) {
                
            case kBackendEnvironmentProduction:
                
                _baseUrl = kProductionAppConfigBaseUrl;
                _relativeUrl = kProductionAppConfigRelativeUrl;
                _method = kProductionAppConfigMethod;
                
                break;
                
            case kBackendEnvironmentStage:
                
                _baseUrl = kStageAppConfigBaseUrl;
                _relativeUrl = kStageAppConfigRelativeUrl;
                _method = kStageAppConfigMethod;
                
                break;
                
            case kBackendEnvironmentDevelopment:
                
                _baseUrl = kDevelopmentAppConfigBaseUrl;
                _relativeUrl = kDevelopmentAppConfigRelativeUrl;
                _method = kDevelopmentAppConfigMethod;
                
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

#pragma mark - ParsableObject -

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        _baseUrl = dict[kNetworkRequestBaseUrlKey];
        _relativeUrl = dict[kNetworkRequestRelativeUrlKey];
        _method = dict[kNetworkRequestMethodKey];
        _group = dict[kNetworkRequestGroupKey];
    }
    
    return self;
}

@end
