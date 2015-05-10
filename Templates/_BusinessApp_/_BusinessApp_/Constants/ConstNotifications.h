//
//  ConstNotifications.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/4/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

// Any component might listen for network success or fail and do custom things
#define kNetworkRequestErrorNotification @"NetworkRequestErrorOccured"
#define kNetworkRequestSuccessNotification @"NetworkRequestSuccessOccured"

// In case backend returns error, app broadcasts this error with via user info dictionary
// These are the keys for retrieving error code and message in models or viewControllers
#define kNetworkRequestErrorNotificationUserInfoKey @"NetworkError"
