//
//  ConstNetworkErrorCodes.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

// Keys
#define kNetworkErrorsKey @"Errors"
#define kErrorMessageKey @"ErrorMessage"

// Common predefined iOS network error codes
#define kNetworkRequestErrorCanceledCode -999
#define kNetworkRequestErrorTimeoutCode -1001
#define kNetworkRequestErrorIsOfflineCode -1009

// Your custom error codes returned from your backend
#define kNetworkRequestErrorAppNeedsUpdateCode -123
#define kNetworkRequestErrorBadInputDataErrorCode -234
