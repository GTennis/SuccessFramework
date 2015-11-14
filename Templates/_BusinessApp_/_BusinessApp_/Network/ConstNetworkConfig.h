//
//  ConstNetworkConfig.h
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

/* Description:
    
    There is only one backend API url which is hardcoded within the app - app config request which is performed by ConfigNetworkOperation. App performs initial call upon launching and when returning from the background. This requests returns all backend app configs including all the backend API urls for all of the 3 environments (production, stage and development).

    Backend environment is determined during runtime reading a value from BackendAPIEnvironmentType key from main plist file
*/

// Plist key
#define kAppConfigBackendEnvironmentPlistKey @"BackendAPIEnvironmentType"

// Possible values for BackendAPIEnvironmentType key. By default should be set to development. Other values should be set via CI when creating particular builds for concrete environments
typedef NS_ENUM(NSInteger, BackendEnvironment) {
    
    kBackendEnvironmentProduction = 0,
    kBackendEnvironmentStage = 1,
    kBackendEnvironmentDevelopment = 2
};

// Production
#define kProductionAppConfigBaseUrl @"http://www.dotheapp.com"
#define kProductionAppConfigRelativeUrl @"/ws/config.json"
#define kProductionAppConfigMethod @"GET"

// Stage
#define kStageAppConfigBaseUrl @"http://www.dotheapp.com"
#define kStageAppConfigRelativeUrl @"/ws/config.json"
#define kStageAppConfigMethod @"GET"

// Development
#define kDevelopmentAppConfigBaseUrl @"http://www.dotheapp.com"
#define kDevelopmentAppConfigRelativeUrl @"/ws/config.json"
#define kDevelopmentAppConfigMethod @"GET"
