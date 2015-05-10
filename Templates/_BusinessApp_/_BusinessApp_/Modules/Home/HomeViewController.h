//
//  HomeViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeListItemView.h"

#define kHomeListItemCellReusableIdentifier @"HomeListItemCellIdentifier"

@class HomeModel;

@interface HomeViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, HomeListItemViewDelegate>

@property (nonatomic, strong) HomeModel *model;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NormalLabel *progressLabel;

@end
