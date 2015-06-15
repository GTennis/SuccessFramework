//
//  MenuViewController.m
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

#import "MenuViewController.h"
#import "MenuNavigator.h"
#import "MenuModel.h"
#import "MenuItemObject.h"

#import "HomeViewController.h"
#import "TableViewExampleViewController.h"
#import "SettingsViewController.h"
#import "TermsConditionsViewController.h"
#import "TableViewExampleViewController.h"

#import "TopNavigationBar.h"

#define kMenuCellIdentifier @"MenuCellIdentifier"

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark - Protected

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
    //[menuNavigator closeMenu];
    
    if (menuItem.isPresentedModally) {
        
        [self presentModalViewController:menuItem.viewController animated:YES];
        
    } else {
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:menuItem.viewController];
        
        [TopNavigationBar applyStyleForNavigationBar:navigationController.navigationBar];
        
        [menuNavigator setViewController:navigationController];
    }
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark - Private

- (NSString *)titleForMenuSection:(NSInteger)section row:(NSInteger)row {
    
    NSString *result = nil;
    
    MenuItemObject *menuItem = _model.menuItems[row];
    result = menuItem.menuTitle;
    
    return result;
}

@end
