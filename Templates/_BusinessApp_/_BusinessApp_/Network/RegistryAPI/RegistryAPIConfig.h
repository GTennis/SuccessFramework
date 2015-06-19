//
//  RegistryAPIConfig.h
//  HereChallenge
//
//  Created by Gytenis Mikulenas on 17/06/15.
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

//-------- App authentification ids and codes -------//

#define kRegistryAPIClientDevelopmentAppId @"AAA"
#define kRegistryAPIClientDevelopmentAppCode @"BBB"

#define kRegistryAPIClientStageAppId @"stageAppId"
#define kRegistryAPIClientStageAppCode @"stageAppCode"

#define kRegistryAPIClientProductionAppId @"prodAppId"
#define kRegistryAPIClientProductionAppCode @"prodAppCode"

//------- Backend base url configs -------//

#define REGISTRY_DEVELOPMENT_BASE_URL      @"http://dotheapp.com"
#define REGISTRY_STAGE_BASE_URL          @"http://dotheapp.com"
#define REGISTRY_PRODUCTION_BASE_URL       @"http://dotheapp.com"

// Web root environment auto selection
#ifdef DEBUG

    #define REGISTRY_BASE_URL REGISTRY_DEVELOPMENT_BASE_URL // For internal testing

#else

    #ifdef ENTERPRISE_BUILD

        #define REGISTRY_BASE_URL REGISTRY_STAGE_BASE_URL // For testing release build

    #else

        #define REGISTRY_BASE_URL REGISTRY_PRODUCTION_BASE_URL // Don't change this. For app store.

    #endif

#endif
