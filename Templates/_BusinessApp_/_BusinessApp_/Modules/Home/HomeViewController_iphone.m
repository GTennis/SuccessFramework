//
//  HomeViewController_iphone.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "HomeViewController_iphone.h"

#define kHomeListCellSizeIphone CGSizeMake(286.0f, 464.0f)
#define kHomeListCellNibNameIphone @"HomeListItemView_iphone"

@implementation HomeViewController_iphone

#pragma mark - Override

- (void)prepareUI {
    
    [super prepareUI];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeListCellNibNameIphone bundle:nil] forCellWithReuseIdentifier:kHomeListItemCellReusableIdentifier];
}

- (CGSize)collectionViewCellSize {
    
    return kHomeListCellSizeIphone;
}

@end
