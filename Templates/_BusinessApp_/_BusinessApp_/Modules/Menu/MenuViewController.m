//
//  MenuViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuNavigator.h"
#import "HomeViewController.h"
#import "TableViewExampleViewController.h"
#import "ScrollViewExampleViewController.h"
#import "SettingsViewController.h"
#import "TermsConditionsViewController.h"
#import "ScrollViewExampleViewController.h"
#import "TableViewExampleViewController.h"

#define kMenuCellIdentifier @"MenuCellIdentifier"

@implementation MenuViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
    }
    
    cell.textLabel.text = [self titleForMenuSection:indexPath.section row:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseViewController *viewController = nil;
    
    switch (indexPath.row) {
            
        case 0:
            
            viewController = [self.viewControllerFactory homeViewControllerWithContext:nil];
            
            break;
            
        case 1:
            
            viewController = [self.viewControllerFactory settingsViewControllerWithContext:nil];
            break;
            
        case 2:
            
            viewController = [self.viewControllerFactory termsConditionsViewControllerWithContext:nil];
            break;
            
        case 3:
            
            viewController = [self.viewControllerFactory scrollViewExampleViewControllerWithContext:nil];
            break;
            
        case 4:
            
            viewController = [self.viewControllerFactory tableViewExampleViewControllerWithContext:nil];
            break;
            
        default:
            break;
    }
    
    MenuNavigator *menuNavigator = [REGISTRY getObject:[MenuNavigator class]];
    [menuNavigator setViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
}

#pragma mark - Helpers

- (NSString *)titleForMenuSection:(NSInteger)section row:(NSInteger)row {
    
    NSString *result = nil;
    
    switch (row) {
        case 0:
            
            result = GMLocalizedString(@"Home");
            break;
            
        case 1:
            
            result = GMLocalizedString(@"Settings");
            break;
            
        case 2:
            
            result = GMLocalizedString(@"TermsConditions");
            break;
        
        case 3:
            
            result = GMLocalizedString(@"ScrollViewExample");
            break;
            
        case 4:
            
            result = GMLocalizedString(@"TableViewExample");
            break;
            
        default:
            break;
    }
            
    return result;
}

@end
