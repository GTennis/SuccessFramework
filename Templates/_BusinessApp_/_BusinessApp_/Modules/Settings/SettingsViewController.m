//
//  SettingsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsModel.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Update UI
    [self prepareUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareUI {
    
    self.title = GMLocalizedString(@"Settings");
}

#pragma mark - IBActions

- (IBAction)englishPressed:(id)sender {
    
    [_model setLanguageEnglish];
}

- (IBAction)germanPressed:(id)sender {
    
    [_model setLanguageGerman];
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self renderUI];
}

@end
