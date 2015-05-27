//
//  HomeViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  (https://github.com/GitTennis/SuccessFramework)
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

#import "HomeViewController.h"
#import "HomeModel.h"
#import "ImagesObject.h"

#define kHomeViewControllerTitle @"Home"
#define kHomeViewControllerDataLoadingProgressLabel @"HomeProgressLabel"

@interface HomeViewController () {
    
}

@end

@implementation HomeViewController

- (void)commonInit {
    
    [super commonInit];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Render static labels
    [self prepareUI];
    
    // Initialize model
    [self loadModel];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Log user behaviour
    [self.analyticsManager logScreen:kAnalyticsManagerScreenHome];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _model.images.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeListItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeListItemCellReusableIdentifier forIndexPath:indexPath];
    cell.delegate = self;
        
    ImageObject *image = _model.images.list[indexPath.row];
    [cell renderWithObject:image];
    
    return (UICollectionViewCell *)cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.collectionViewCellSize;
}

- (CGSize)collectionViewCellSize {
    
    // Override in child classes
    return CGSizeZero;
}

#pragma mark - HomeListItemViewDelegate

- (void)didPressedWithImage:(ImageObject *)image {
    
    UIViewController *viewController = (UIViewController *)[self.viewControllerFactory photoDetailsViewControllerWithContext:image];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Helpers

- (void)prepareUI {
    
    [super prepareUI];
    
    // Set title
    self.title = GMLocalizedString(kHomeViewControllerTitle);
    _progressLabel.text = GMLocalizedString(kHomeViewControllerDataLoadingProgressLabel);
}

- (void)renderUI {
    
    [super renderUI];
    
    // Hide/unhide empty data list label
    if (_model.images.list.count > 0) {
        
        //_refreshButtonWhenListIsEmpty.hidden = YES;
        //_collectionView.hidden = NO;
        
        // Reload
        [self.collectionView reloadData];
        
    } else {
        
        //_refreshButtonWhenListIsEmpty.hidden = NO;
        //_collectionView.hidden = YES;
    }
}

- (void)loadModel {
    
    [super loadModel];
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf showScreenActivityIndicator];
    _progressLabel.hidden = NO;
    
    [_model loadData:^(BOOL success, id result, NSError *error) {
        
        [weakSelf hideScreenActivityIndicator];
        weakSelf.progressLabel.hidden = YES;
        
        if (success) {
            
            // Render UI
            [weakSelf renderUI];
            
        } else {
            
            // Show refresh button when error happens
            // ...
        }
    }];
}

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

@end
