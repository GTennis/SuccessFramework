//
//  ParsableObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ConstNetworkErrorCodes.h"

@protocol ParsableObject <NSObject>

@optional

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)toDict;

@end
