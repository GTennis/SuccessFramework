//
//  TableViewExampleViewController.m
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

#import "TableViewExampleViewController.h"
#import "UserObject.h"

@interface TableViewExampleViewController () {
    
    NSArray *_userArray;
}

@end

@implementation TableViewExampleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
    [self loadModel];
}

#pragma mark - Protected

- (void)commonInit {
    
    [super commonInit];
    
    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    self.title = GMLocalizedString(@"List screen");
}

- (void)renderUI {
    
    [super renderUI];
    
    // ...
}

- (void)loadModel {
    
    [super loadModel];
    
    // Prepare data
    UserObject *user1 = [UserObject new];
    UserObject *user2 = [UserObject new];
    UserObject *user3 = [UserObject new];
    
    user1.firstName = @"First user";
    user2.firstName = @"Second user";
    user3.firstName = @"Third user";
    
    _userArray = @[user1, user2, user3];
    
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource

// For hiding blank lines at the bottom of the table view
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    // This will create a "invisible" footer
    return 0.01f;
}

// For hiding blank lines at the bottom of the table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* strCellIdentifier = kTableViewExampleCellIdentifier;
    
	TableViewExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    
    UserObject *user = [_userArray objectAtIndex:indexPath.row];
    
    /*if (!event.logoImage.localFilename && event.logoImage.imageUrl) {
        
        if (_listModel.isLoaded) {
            
            [_listModel downloadImage:event.logoImage withSize:cell.logoImageView.bounds.size atIndexPath:indexPath];
        }
    }*/
    
    [cell renderCellWithUser:user];
	
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Todo...
}

@end
