//
//  SettingsViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseViewController.h"

@class SettingsModel;

@interface SettingsViewController : BaseViewController

@property (nonatomic, strong) SettingsModel *model;

@property (weak, nonatomic) IBOutlet UILabel *languageLabel;

- (IBAction)englishPressed:(id)sender;
- (IBAction)germanPressed:(id)sender;

@end
