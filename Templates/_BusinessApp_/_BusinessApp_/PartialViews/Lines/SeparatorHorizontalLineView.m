//
//  SeparatorHorizontalLineView.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 21/05/15.
//  Copyright (c) 2015 Gytenis Mikulėnas. All rights reserved.
//

#import "SeparatorHorizontalLineView.h"

// Stroke size
#define kSeparatorLineSize 0.5f

#define kSeparatorLineDefaultBackgroundColor [UIColor lightGrayColor]
//#define kSeparatorTopLineColor rgbColor(228, 228, 228)
//#define kSeparatorTopLineColor rgbColor(142, 142, 142)
//#define kSeparatorMiddleLineColor rgbColor(246, 246, 246)
//#define kSeparatorBottomLineColor rgbColor(250, 250, 250)

@implementation SeparatorHorizontalLineView

// For using line views from IB only. Just set height constraint in SB with 1 px and it will be changed to 0.5 during runtime.
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    for (NSLayoutConstraint *appliedConstraint in self.constraints) {
        
        if (appliedConstraint.firstAttribute == NSLayoutAttributeHeight) {
            
            appliedConstraint.constant = kSeparatorLineSize;
        }
    }
}

// The method used when dynamicly creating or adding separator line
- (void)fitIntoContainerView:(UIView *)containerView color:(UIColor *)color alignTop:(BOOL)alignTop leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset {
    
    CGFloat originY = 0;
    if (!alignTop) {
        
        originY = CGRectGetHeight(containerView.bounds) - kSeparatorLineSize;
    }
    
    CGFloat originX = 0 + leftOffset;
    CGFloat width = CGRectGetWidth(containerView.bounds) - originX - rightOffset;
    
    CGRect rect = CGRectMake(originX, originY, width, kSeparatorLineSize);
    self.frame = rect;
    
    if (color) {
        
        self.backgroundColor = color;
        
    } else {
        
        // Apply default color if param was not passed
        self.backgroundColor = kSeparatorLineDefaultBackgroundColor;
    }
}

// This implementation was drawing 1 px line: 0.5 px with one color and 0.5px with a shadow. But currently, not need. Using 0.5 solid line.
/*- (void)setLineWidth:(CGFloat)lineWidth
 {
 CGRect rect = self.frame;
 rect.size.width = lineWidth;
 self.frame = rect;
 }
 
 // Don't allow height of line to be different than predefined
 - (void)setFrame:(CGRect)frame
 {
 CGRect rect = frame;
 rect.size.height = kSeparatorViewSize;
 
 [super setFrame:rect];
 }
 
 #pragma mark - Drawing
 
 - (void)drawRect:(CGRect)rect
 {
 [super drawRect:rect];
 
 // Get graphic context
 CGContextRef c = UIGraphicsGetCurrentContext();
 CGContextSetLineWidth(c, kSeparatorLineSize);
 
 // Calculate points
 CGFloat minx = CGRectGetMinX(rect), maxx = CGRectGetMaxX(rect);
 CGFloat miny = CGRectGetMinY(rect);
 
 // ----- Draw top line ------
 CGContextSetStrokeColorWithColor(c, [kAppSeparatorTopLineColor CGColor]);
 CGContextMoveToPoint(c, minx, miny);
 CGContextAddLineToPoint(c, maxx, miny);
 
 // Close top line the path:
 CGContextClosePath(c);
 
 // Fill & stroke top line path:
 CGContextDrawPath(c, kCGPathFillStroke);
 
 // ----- Draw middle line ------
 miny += kSeparatorLineSize;
 CGContextSetStrokeColorWithColor(c, [kAppSeparatorMiddleLineColor CGColor]);
 CGContextMoveToPoint(c, maxx, miny);
 CGContextAddLineToPoint(c, minx, miny);
 
 // Close top line path:
 CGContextClosePath(c);
 
 // Fill & stroke top line path:
 CGContextDrawPath(c, kCGPathFillStroke);
 
 // ----- Draw bottom line ------
 miny += kSeparatorLineSize;
 CGContextSetStrokeColorWithColor(c, [kAppSeparatorBottomLineColor CGColor]);
 CGContextMoveToPoint(c, maxx, miny);
 CGContextAddLineToPoint(c, minx, miny);
 
 // Close bottom line path:
 CGContextClosePath(c);
 
 // Fill & stroke bottom line:
 CGContextDrawPath(c, kCGPathFillStroke);
 }*/

@end