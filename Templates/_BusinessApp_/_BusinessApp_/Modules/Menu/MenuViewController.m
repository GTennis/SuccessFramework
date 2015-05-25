//
//  MenuViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuNavigator.h"
#import "MenuModel.h"
#import "MenuItemObject.h"

#import "HomeViewController.h"
#import "TableViewExampleViewController.h"
#import "ScrollViewExampleViewController.h"
#import "SettingsViewController.h"
#import "TermsConditionsViewController.h"
#import "ScrollViewExampleViewController.h"
#import "TableViewExampleViewController.h"

#define kMenuCellIdentifier @"MenuCellIdentifier"

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark - UITableViewDataSource

// For hiding separators between empty cell below table view
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    // This will create a "invisible" footer
    return 0.01f;
}

// For hiding separators between empty cell below table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _model.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kMenuCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        UIView *bgView = [[UIView alloc] initWithFrame:cell.frame];
        [bgView setBackgroundColor:[UIColor lightGrayColor]];
        cell.selectedBackgroundView = bgView;
        cell.textLabel.fontType = kFontNormalType;
    }
    
    cell.textLabel.text = [self titleForMenuSection:indexPath.section row:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuItemObject *menuItem = _model.menuItems[indexPath.row];
    
    MenuNavigator *menuNavigator = [REGISTRY getObject:[MenuNavigator class]];
    [menuNavigator setViewController:[[UINavigationController alloc] initWithRootViewController:menuItem.viewController]];
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark - Helpers

- (void)prepareUI {
    
    [super prepareUI];
}

- (void)renderUI {
    
    [super renderUI];
    
    [_tableView reloadData];
}

- (void)loadModel {
    
    [super loadModel];
    
    __weak typeof(self) weakSelf = self;
    
    [_model loadData:^(BOOL success, id result, NSError *error) {
        
        [weakSelf renderUI];
    }];
}

- (NSString *)titleForMenuSection:(NSInteger)section row:(NSInteger)row {
    
    NSString *result = nil;
    
    MenuItemObject *menuItem = _model.menuItems[row];
    result = menuItem.menuTitle;
    
    return result;
}

@end
