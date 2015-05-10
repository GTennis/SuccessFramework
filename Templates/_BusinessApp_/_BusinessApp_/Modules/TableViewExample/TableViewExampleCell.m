//
//  TableViewExampleCell.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "TableViewExampleCell.h"
#import "UserObject.h"

@interface TableViewExampleCell () {
 
    // Always store received data object
    UserObject *_user;
}

@end

@implementation TableViewExampleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    // ...
    
    // Do static customization
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)reuseIdentifier {
    
    return kTableViewExampleCellIdentifier;
}

- (void)renderCellWithUser:(UserObject *)user {
    
    // Store reference
    _user = user;
    
    // Render
    _nameLabel.text = _user.firstName;
}

@end
