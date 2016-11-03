//
//  SeparatorHorizontalLineView.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 03/11/16.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

import UIKit

// Stroke size
let kSeparatorLineSize: CGFloat = 0.5

let kSeparatorLineDefaultBackgroundColor = UIColor.lightGray
//#define kSeparatorTopLineColor rgbColor(228, 228, 228)
//#define kSeparatorTopLineColor rgbColor(142, 142, 142)
//#define kSeparatorMiddleLineColor rgbColor(246, 246, 246)
//#define kSeparatorBottomLineColor rgbColor(250, 250, 250)

class SeparatorHorizontalLineView: UIView {

    // For using line views from IB only. Just set height constraint in SB with 1 px and it will be changed to 0.5 during runtime
    override func awakeFromNib() {
        
        super.awakeFromNib()

        for appliedConstraint in self.constraints {
            
            if (appliedConstraint.firstAttribute == NSLayoutAttribute.height) {
                
                appliedConstraint.constant = kSeparatorLineSize
            }
        }
    }
    
    func fitInto(containerView: UIView, color: UIColor?, alignTop: Bool, leftOffset: CGFloat, rightOffset: CGFloat) {
        
        var originY: CGFloat = 0
        
        if (!alignTop) {
            
            originY = containerView.bounds.size.height - kSeparatorLineSize
        }
        
        let originX: CGFloat = 0 + leftOffset
        let width: CGFloat = containerView.bounds.size.width - originX - rightOffset
        
        let rect: CGRect =  CGRect(x: originX, y: originY, width: width, height: kSeparatorLineSize)
        self.frame = rect
        
        if let color = color {
            
            self.backgroundColor = color
            
        } else {
            
            // Apply default color if param was not passed
            self.backgroundColor = kSeparatorLineDefaultBackgroundColor
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
}
