//
//  BaseButton.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 02/11/16.
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
import QuartzCore

class BaseButton: UIButton, CustomButtonProtocol {

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
    
    // MARK: Default style
    
    // Borders
    var borderSize: CGFloat {
     
        get {
            
            return 1.0
        }
    }
    
    var borderColor: UIColor {
        
        get {
            
            return kColorBlack
        }
    }
    
    // Corners
    var cornerRadius: CGFloat {
        
        get {
            
            return 0
        }
    }
    
    // Normal state
    var backgroundNormalColor: UIColor {
    
        get {
            
            return kColorGreen
        }
    }
    
    var textNormalColor: UIColor {
        
        get {
            
            return kColorBlack
        }
    }
    
    // Highlighted state
    var backgroundHighlightedColor: UIColor {
        
        get {
            
            return UIColor.clear
        }
    }
    
    var textHighlightedColor: UIColor {
        
        get {
            
            return kColorBlack
        }
    }
        
    // Disabled state
    var backgroundDisabledColor: UIColor {
        
        get {
            
            return UIColor.clear
        }
    }
    
    var textDisabledColor: UIColor {
        
        get {
            
            return kColorGrayLight
        }
    }
    
    // Font
    var fontName: String {
        
        get {
            
            return kFontNormal
        }
    }
    
    var fontSize: CGFloat {
        
        get {
            
            return 20.0
        }
    }
    
    // MARK:
    // MARK: Protected
    // MARK:
    
    // http://stackoverflow.com/a/17806333/597292
    override var intrinsicContentSize: CGSize {
        
        var size = super.intrinsicContentSize
        
        size.height = 50.0
        
        return CGSize(width: size.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right, height: size.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)
    }
    
    func commonInit() {
        
        if (self.cornerRadius > 0) {
            
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
        
        if (self.borderSize > 0) {
            
            self.layer.borderWidth = self.borderSize
            self.layer.borderColor = self.borderColor.cgColor
        }
        
        let bgAlphaDefault: CGFloat = 1.0
        let bgAlphaHighlighted: CGFloat = 0.3
        var bgAlpha: CGFloat = bgAlphaDefault
        
        // Set style for normal
        self.setTitleColor(self.textNormalColor, for: UIControlState.normal)
        bgAlpha = equalColors(color1: self.backgroundNormalColor, color2: UIColor.clear) ? bgAlphaDefault : bgAlphaHighlighted
        
        var bgColor = UIImage.init(color: self.backgroundNormalColor, alpha: bgAlpha)
        self.setBackgroundImage(bgColor, for: UIControlState.normal)
        
        // Use Custom NOT SYSTEM button in IB in order to work UIControlStateHighlighted correctly!!! More info:
        // http://stackoverflow.com/a/22696409/597292
        // Set style for highlighted
        self.setTitleColor(self.textHighlightedColor, for: UIControlState.highlighted)
        bgAlpha = equalColors(color1: self.backgroundHighlightedColor, color2: UIColor.clear) ? bgAlphaDefault : bgAlphaHighlighted
        bgColor = UIImage.init(color: self.backgroundHighlightedColor, alpha: bgAlpha)
        self.setBackgroundImage(bgColor, for: UIControlState.highlighted)
        
        // Set style for disabled
        self.setTitleColor(self.textDisabledColor, for: UIControlState.disabled)
        bgAlpha = equalColors(color1: self.backgroundDisabledColor, color2: UIColor.clear) ? bgAlphaDefault : bgAlphaHighlighted
        bgColor = UIImage.init(color: self.backgroundDisabledColor, alpha: bgAlpha)
        self.setBackgroundImage(bgColor, for: UIControlState.disabled)
        
        let font: UIFont = UIFont(name: self.fontName, size: self.fontSize)!
        self.titleLabel?.font = font
    }
}
