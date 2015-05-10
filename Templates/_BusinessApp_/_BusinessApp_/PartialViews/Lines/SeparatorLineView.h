//
//  SeparatorLineView.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 3/24/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeparatorLineView : UIView

- (void)fitIntoContainerView:(UIView *)containerView color:(UIColor *)color alignTop:(BOOL)alignTop leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset;

@end
