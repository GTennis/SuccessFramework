//
//  HomeViewController_ipad.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "HomeViewController_ipad.h"

#define kHomeListCellSizeIpad CGSizeMake(762.0f, 704.0f)
#define kHomeListCellNibNameIpad @"HomeListItemView_ipad"

@implementation HomeViewController_ipad

#pragma mark - Override

- (void)prepareUI {
    
    [super prepareUI];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kHomeListCellNibNameIpad bundle:nil] forCellWithReuseIdentifier:kHomeListItemCellReusableIdentifier];
}

- (CGSize)collectionViewCellSize {
    
    return kHomeListCellSizeIpad;
}

@end
