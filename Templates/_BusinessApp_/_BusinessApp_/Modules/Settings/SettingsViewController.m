//
//  SettingsViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
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
    
    [self loadModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protected -

- (void)prepareUI {
    
    [super prepareUI];
    
    self.title = GMLocalizedString(kSettingsViewControllerTitleKey);
    
    NSString *versionNo = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *buildNo = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    _versionLabel.text = [NSString stringWithFormat:@"version: %@ (%@)", versionNo, buildNo];
}

- (void)renderUI {
    
    [super renderUI];
    
    [_tableView reloadData];
}

- (void)loadModel {
    
    [super loadModel];
    
    [self renderUI];
}

#pragma mark Language change handing

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self renderUI];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_model setLanguageWithRow:indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_model languageCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"LanguageTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.textColor = kColorBlue;
        UIImageView *checkBoxView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        checkBoxView.image = [UIImage imageNamed:@"iconCheckboxOff"];
        checkBoxView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryView = checkBoxView;
    }
    
    cell.textLabel.text = [_model languageAtRow:indexPath.row];
    
    UIImageView *checkBoxView = (UIImageView *)cell.accessoryView;
    if ([_model isLanguageCurrentAtRow:indexPath.row]) {
        
        checkBoxView.image = [UIImage imageNamed:@"iconCheckboxOn"];
        
    } else {
        
        checkBoxView.image = [UIImage imageNamed:@"iconCheckboxOff"];
    }
    
    return cell;
}

// Hide empty rows
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == tableView.numberOfSections - 1) {
        return 1;
    }
    return 0;
}

@end
