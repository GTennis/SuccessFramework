//
//  ErrorObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ParsableObject.h"

#define kNetworkErrorCodeKey @"ErrorCode"
#define kNetworkErrorMessageKey @"ErrorMessage"

@protocol ErrorObject <ParsableObject>

@property (nonatomic) NSInteger code;
@property (nonatomic, strong) NSString *message;

@end

@interface ErrorObject : NSObject <ErrorObject>

@end