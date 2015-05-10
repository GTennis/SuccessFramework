//
//  BaseTableViewCell.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 2/6/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (CGFloat)heightForCell {
    
    NSString *cellClassName = NSStringFromClass([self class]);
    CGFloat cellHeight = 44.0f;
    
    if (isIpad) {
        
        cellClassName = [NSString stringWithFormat:@"%@_ipad", cellClassName];
        cellHeight = [NSClassFromString(cellClassName) heightForCell];
        
    } else {
        
        cellClassName = [NSString stringWithFormat:@"%@_iphone", cellClassName];
        cellHeight= [NSClassFromString(cellClassName) heightForCell];
    }
    
    return cellHeight;
}

@end
