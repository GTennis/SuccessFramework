//
//  ErrorObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ErrorObject.h"

@implementation ErrorObject

@synthesize code = _code;
@synthesize message = _message;

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        NSString *errorCodeString = dict[kNetworkErrorCodeKey];
        
        if (errorCodeString.length > 0) {
            
            _code = [errorCodeString integerValue];
            _message = dict[kNetworkErrorMessageKey];
            
        } else {

            return nil;
        }
    }
    
    return self;
}

@end
