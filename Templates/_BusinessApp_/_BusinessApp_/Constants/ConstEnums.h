//
//  ConstEnums.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

typedef NS_ENUM(NSInteger, NetworkRequestErrorType) {
    
    kNetworkRequestNoError,
    kNetworkRequestTimeoutError,
    kNetworkRequestIsOfflineError,
    kNetworkRequestServerError,
    kNetworkRequestBadInputDataError,
    kNetworkRequestAppNeedsUpdateError
};