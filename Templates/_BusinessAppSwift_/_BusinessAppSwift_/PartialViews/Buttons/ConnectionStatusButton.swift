//
//  ConnectionStatusButton.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 23/10/16.
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

let kConnectionStatusLabelTag = 20141206

// Border
let kConnectionStatusLabelBorderCornerRadius = 4.0
let kConnectionStatusLabelBorderWidth = 1.0

let kConnectionStatusLabelBorderColor = kColorGrayDark.cgColor

// Text
let kConnectionStatusLabelTextColor = kColorWhite
let kConnectionStatusLabelBackgroundColor = kColorGrayDark

let kConnectionStatusLabelTextFont = kFontNormal
let kConnectionStatusLabelTextSize = 15.0

let kConnnectionStatusLabelMessageKey = "NoIternetMessage"
let kConnectionStatusLabelPhoneNumber = "123456789"

class ConnectionStatusButton: UIButton {
    
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        self.commonInit()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    func didPressed() {
        
        var error: ErrorEntity = ErrorEntity.init(code: nil, message: nil)
        let canExecute: Bool = (_phoneCallCommand?.canExecute(error: &error))!
        
        if (canExecute) {
            
            _phoneCallCommand?.executeWithCallback(callback: nil)
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _phoneCallCommand: PhoneCallCommand?
    
    internal func commonInit() {
        
        // Add corner radius if defined
        if (kConnectionStatusLabelBorderCornerRadius > 0) {
            
            self.layer.cornerRadius = CGFloat(kConnectionStatusLabelBorderCornerRadius)
            self.layer.masksToBounds = true
        }
        
        // Add border if defined
        if (kConnectionStatusLabelBorderWidth > 0) {
            
            self.layer.borderColor = kConnectionStatusLabelBorderColor
            self.layer.borderWidth = CGFloat(kConnectionStatusLabelBorderWidth)
        }
        
        self.backgroundColor = kConnectionStatusLabelBackgroundColor;
        
        self.setTitle(localizedString(key: kConnnectionStatusLabelMessageKey), for:UIControlState.normal)
        self.titleLabel?.textColor = kConnectionStatusLabelTextColor;
        self.titleLabel?.font = UIFont(name: kConnectionStatusLabelTextFont, size: CGFloat(kConnectionStatusLabelTextSize))
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.numberOfLines = 0;
        
        self.tag = kConnectionStatusLabelTag;
        
        self.addTarget(self, action: #selector(ConnectionStatusButton.didPressed), for: UIControlEvents.touchUpInside)
        
        _phoneCallCommand = PhoneCallCommand.init(phoneNumber: kConnectionStatusLabelPhoneNumber)
    }
}
