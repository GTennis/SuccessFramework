//
//  BaseNetworkOperation.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/2/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface BaseNetworkOperation : AFHTTPRequestOperation

- (id)initWithUrlString:(NSString *)urlString;
- (void)getDataWithCallback:(Callback)callback;

// Protected
- (NSString *)baseUrl;
- (NSString *)method;
- (NSString *)urlString;
- (void)handleReceivedDataWithSuccess:(BOOL)success result:(id)result error:(NSError *)error callback:(Callback)callback;

@end
