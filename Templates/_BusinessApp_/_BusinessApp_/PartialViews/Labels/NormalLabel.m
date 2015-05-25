//
//  NormalLabel.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/20/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "NormalLabel.h"
#import "UIView+Fonts.h"

@implementation NormalLabel

- (void)commonInit {
    
    self.fontType = kFontNormalType;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

@end
