//
//  ConstNetworkConfig.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

//------- Backend base url configs -------//

#define DEVELOPMENT_BASE_URL      @"http://dotheapp.com"
#define STAGE_BASE_URL          @"http://dotheapp.com"
#define PRODUCTION_BASE_URL       @"http://dotheapp.com"

// Web root environment auto selection
#ifdef DEBUG

    #define BASE_URL DEVELOPMENT_BASE_URL // For internal testingTS_APPLICATION

#else

    #ifdef ENTERPRISE_BUILD

        #define BASE_URL STAGE_BASE_URL // For testing release build

    #else

        #define BASE_URL PRODUCTION_BASE_URL // Don't change this. For app store.

    #endif

#endif
