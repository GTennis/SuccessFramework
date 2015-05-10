//
//  TableViewExampleCell.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseTableViewCell.h"

#define kTableViewExampleCellIdentifier @"TableViewExampleCell"

@class UserObject;

@interface TableViewExampleCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)renderCellWithUser:(UserObject *)user;

@end
