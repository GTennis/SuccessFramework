//
//  BaseLabel.swift
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

import Foundation

class BaseLabel: UILabel, CustomLabelProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.commonInit()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        
        self.commonInit()
        return super.awakeAfter(using: aDecoder)
    }
    
    // MARK: CustomLabelProtocol
    
    var insets: UIEdgeInsets {
        
        get {
            
            let marginSize: CGFloat = 8.0
            let insets: UIEdgeInsets = UIEdgeInsetsMake(marginSize, marginSize, marginSize, marginSize)
            
            return insets
        }
    }
    
    var labelTextFontType: String {
        
        get {
            
            return kFontNormalType
        }
    }
    
    var labelTextSize: CGFloat {
        
        get {
            
            return 15.0
        }
    }
    
    var labelTextColor: UIColor {
        
        get {
            
            return kColorBlack
        }
    }
    
    var lineSpace: CGFloat {
        
        get {
            
            return 0
        }
    }
    
    // MARK:
    // MARK: Protected
    // MARK:
    
    func commonInit() {
        
        self.font = UIFont(name: self.font.fontName, size: self.labelTextSize)
        self.textColor = self.labelTextColor
        self.fontType = self.labelTextFontType
    }
    
    override var text: String? {
        
        didSet {
            
            if (self.lineSpace == 0) {
                
                // Apply line size if needed
                
                let paragraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                paragraphStyle.lineSpacing = self.lineSpace
                paragraphStyle.alignment = self.textAlignment
                
                self.attributedText = NSAttributedString(string: self.text!, attributes: [NSParagraphStyleAttributeName:paragraphStyle])
            }
        }
    }

    /*- (void)drawTextInRect:(CGRect)rect {
     
     UIEdgeInsets insets = {40.0f, kLabelTextLeftOffset, 0, 40.0f};
     
     return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
    }*/
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let insets: UIEdgeInsets = self.insets
        var rect: CGRect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        
        return rect
    }
    
    // http://stackoverflow.com/a/17806333/597292
    override var intrinsicContentSize: CGSize {
        
        var size: CGSize = super.intrinsicContentSize
        
        if (self.text == nil) {
            
            size = CGSize.zero
        }
        
        return size
    }
}
