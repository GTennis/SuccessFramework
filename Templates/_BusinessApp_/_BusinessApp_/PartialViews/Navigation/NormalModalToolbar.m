//
//  NormalModalToolbar.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 21/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "NormalModalToolbar.h"
#import "SeparatorHorizontalLineView.h"

@implementation NormalModalToolbar

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self prepareUI];
}

- (void)prepareUI {
    
    SeparatorHorizontalLineView *lineView = [[SeparatorHorizontalLineView alloc] init];
    
    [lineView fitIntoContainerView:self color:kColorGrayDark alignTop:NO leftOffset:0 rightOffset:0];
    [self addSubview:lineView];
}

@end
