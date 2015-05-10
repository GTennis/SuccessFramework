//
//  SettingObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "SettingObject.h"

@implementation SettingObject

@synthesize isAppNeedUpdate = _isAppNeedUpdate;

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [self init];
    if (self && dict) {
        
        NSNumber *appNeedsUpdate = dict[kSettingIsAppNeedUpdateKey];
        
        // Treat it as forceToUpdate when response doesn't contain kSettingIsAppNeedUpdateKey property
        if (!appNeedsUpdate) {
            
            _isAppNeedUpdate = YES;
            
        } else {

            _isAppNeedUpdate = [appNeedsUpdate boolValue];
        }
    }
    
    return self;
}

@end
