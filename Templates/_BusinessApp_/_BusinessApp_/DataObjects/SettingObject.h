//
//  SettingObject.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 4/27/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "ParsableObject.h"

#define kSettingIsAppNeedUpdateKey @"ForceUpdate"

@protocol SettingObject <ParsableObject>

@property (nonatomic) BOOL isAppNeedUpdate;

@end

@interface SettingObject : NSObject <SettingObject>

@end
