//
//  SeparatorHorizontalLineView.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 21/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeparatorHorizontalLineView : UIView

- (void)fitIntoContainerView:(UIView *)containerView color:(UIColor *)color alignTop:(BOOL)alignTop leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset;

@end
