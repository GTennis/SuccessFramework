//
//  HomeViewController.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "ImagesObject.h"

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

#pragma mark - Model

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

#pragma mark - HomeListItemViewDelegate

- (void)didPressedWithImage:(ImageObject *)image {
    
    // Handle cell click
    // ...
}

#pragma mark - Helpers

- (void)prepareUI {
    
    [super prepareUI];
    
    // Set title
    self.title = GMLocalizedString(@"Home");
    _progressLabel.text = GMLocalizedString(@"HomeProgressLabel");
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

#pragma mark - Handling language change

- (void)notificationLocalizationHasChanged {
    
    [self prepareUI];
    [self loadModel];
}

@end
