//
//  MenuModel.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseModel.h"
#import "UserManagerObserver.h"

@interface MenuModel : BaseModel <UserManagerObserver>

@property (nonatomic, strong) NSMutableArray *menuItems;

@end
