//
//  ConstNetworkConfig.h
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

//------- Backend base url configs -------//

#define DEVELOPMENT_BASE_URL      @"http://dotheapp.com"
#define STAGE_BASE_URL          @"http://dotheapp.com"
#define PRODUCTION_BASE_URL       @"http://dotheapp.com"

// Web root environment auto selection
#ifdef DEBUG

    #define BASE_URL DEVELOPMENT_BASE_URL // For internal testing

#else

    #ifdef ENTERPRISE_BUILD

        #define BASE_URL STAGE_BASE_URL // For testing release build

    #else

        #define BASE_URL PRODUCTION_BASE_URL // Don't change this. For app store.

    #endif

#endif
