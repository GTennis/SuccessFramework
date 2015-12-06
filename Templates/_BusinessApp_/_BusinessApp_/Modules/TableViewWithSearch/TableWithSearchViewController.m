//
//  TableWithSearchViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 12/6/15.
//  Copyright © 2015 Gytenis Mikulėnas 
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

#import "TableWithSearchViewController.h"
#import "UIView+Autolayout.h"

@interface TableWithSearchViewController ()

@end

@implementation TableWithSearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareUI];
    [self loadModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protected

- (void)commonInit {
    
    [super commonInit];
    
    // ...
}

- (void)prepareUI {
    
    [super prepareUI];
    
    // ...
}

- (void)renderUI {
    
    [super renderUI];
    
    // initialise MJNIndexView
    _indexView = [[MJNIndexView alloc] initWithFrame:self.view.bounds];
    _indexView.dataSource = self;
    [self setupDefaultAttributesForMJNIndexView];
    [self.view addSubview:_indexView];

    [_tableView reloadData];
    [_tableView reloadSectionIndexTitles];
    [_indexView refreshIndexItems];
    
    /*[self.indexView viewAddLeadingSpace:0 containerView:self.view];
     [self.indexView viewAddTrailingSpace:0 containerView:self.view];
     [self.indexView viewAddTopSpace:0 containerView:self.view];
     [self.indexView viewAddBottomSpace:0 containerView:self.view];*/
}

- (void)loadModel {
    
    [super loadModel];
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf showScreenActivityIndicator];
    
    [_model loadData:^(BOOL success, id result, NSError *error) {
        
        [weakSelf hideScreenActivityIndicator];
        
        if (success) {
            
            // Render UI
            [weakSelf renderUI];
            
        } else {
            
            // Show refresh button when error happens
            // ...
        }
    }];
}

#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [_model.sectionsWithRows allKeys][section];
}

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
    
    return [_model.sectionsWithRows allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionTitle = [_model.sectionsWithRows allKeys][section];
    
    return [_model.sectionsWithRows[sectionTitle] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableWithSearchViewControllerCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableWithSearchViewControllerCellIdentifier];
    }
    
    NSString *sectionTitle = [_model.sectionsWithRows allKeys][indexPath.section];
    NSString *title = _model.sectionsWithRows[sectionTitle][indexPath.row];
    cell.textLabel.text = title;;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Todo...
}

#pragma mark MJNIndexViewDataSource

- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView {
    
    return [_model.sectionsWithRows allKeys];
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - Private -

- (void)setupDefaultAttributesForMJNIndexView {
    
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    self.indexView.font = kFontNormalWithSize(13.0f);
    self.indexView.selectedItemFont = kFontBoldWithSize(40.0f);
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainStays = NO;
    self.indexView.curtainMoves = YES;
    self.indexView.curtainMargins = NO;
    self.indexView.ergonomicHeight = NO;
    self.indexView.upperMargin = 40.0;
    self.indexView.lowerMargin = 22.0;
    self.indexView.rightMargin = -40.0;
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    self.indexView.maxItemDeflection = 100.0;
    self.indexView.rangeOfDeflection = 5;
    self.indexView.fontColor = kColorGray;
    self.indexView.selectedItemFontColor = kColorBlue;
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
}

@end
