//
//  NormalCheckbox.swift
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

protocol NormalCheckboxDelegate: AnyObject {

    func didSelectValue(normalCheckbox: NormalCheckbox, value: Any)
}

class NormalCheckbox: UIButton {
    
    var isOn: Bool {
        
        get {
            
            return _isOn
        }
        set {
            
            _isOn = newValue
            
            self.setIconWithState(isOn: _isOn)
        }
    }
    weak var delegate: NormalCheckboxDelegate?
    
    var isIconOnLeftSide: Bool {
        
        get {
            
            return _isIconOnLeftSide
        }
        set {
            
            _isIconOnLeftSide = newValue
            
            if (!_isIconOnLeftSide) {
                
                self.moveImageToRightSide()
            }
        }
    }
    
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
    
    var titleColor: UIColor {
        
        get {
            
            return kColorBlack
        }
    }
    
    var selectedTitleColor: UIColor {
        
        get {
            
            return kColorBlack
        }
    }
    
    // MARK:
    // MARK: Protected
    // MARK:
    
    func commonInit() {

        self.titleEdgeInsets = UIEdgeInsetsMake(10.0, 5.0, 10.0, 0.0)
        
        //self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        // Label multiline
        self.titleLabel?.numberOfLines = 0;
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.setIconWithState(isOn: _isOn)
        self.isIconOnLeftSide = _isIconOnLeftSide
        
        self.addTarget(self, action: #selector(NormalCheckbox.buttonPressed), for: UIControlEvents.touchUpInside)
        self.setTitleColor(self.titleColor, for: UIControlState.normal)
    }
        
    // http://stackoverflow.com/a/17806333/597292
    override var intrinsicContentSize: CGSize {
        
        let buttonSize: CGSize = super.intrinsicContentSize
        
        let labelSize: CGSize = self.titleLabel!.sizeThatFits(CGSize(width: self.titleLabel!.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let resultSize: CGSize = CGSize(width: buttonSize.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right, height: labelSize.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)
        
        return resultSize;
    }
    
    override func layoutSubviews() {
    
        super.layoutSubviews()
        self.titleLabel!.preferredMaxLayoutWidth = self.titleLabel!.frame.size.width
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _isOn: Bool = false
    internal var _isIconOnLeftSide: Bool = false
    
    internal func setIconWithState(isOn: Bool) {
        
        var image: UIImage?
        
        if (isOn) {
            
            image = UIImage(named: "iconCheckboxOn")
            self.setTitleColor(self.selectedTitleColor, for: UIControlState.normal)
            
        } else {
            
            image = UIImage(named: "iconCheckboxOff")
            self.setTitleColor(self.titleColor, for: UIControlState.normal)
        }

        self.setImage(image, for: UIControlState.normal)
        //[self setBackgroundImage:image forState:UIControlStateNormal];
    }

    func buttonPressed() {
        
        self.isOn = !self.isOn
        
        self.delegate?.didSelectValue(normalCheckbox: self, value: _isOn)
    }
    
    // http://stackoverflow.com/a/25277016/597292
    func moveImageToRightSide() {
        
        /*[self sizeToFit];
         
         CGFloat titleWidth = self.titleLabel.frame.size.width;
         CGFloat imageWidth = self.imageView.frame.size.width;
         CGFloat gapWidth = self.frame.size.width - titleWidth - imageWidth;
         self.titleEdgeInsets = UIEdgeInsetsMake(self.titleEdgeInsets.top,
         -imageWidth + self.titleEdgeInsets.left,
         self.titleEdgeInsets.bottom,
         imageWidth - self.titleEdgeInsets.right);
         
         self.imageEdgeInsets = UIEdgeInsetsMake(self.imageEdgeInsets.top,
         titleWidth + self.imageEdgeInsets.left + gapWidth,
         self.imageEdgeInsets.bottom,
         -titleWidth + self.imageEdgeInsets.right - gapWidth);*/
    }
}
