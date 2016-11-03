//
//  UIView+Fonts.swift
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

extension UIView {
    
    var fontType: String {
        
        get {
            
            var fontType: String?
            
            // For UILabels
            if (self is UILabel) {
                
                let label: UILabel = self as! UILabel
                fontType = label.font.fontName
                
            // For UITextFields
            } else if (self is UITextField) {
                
                let textField: UITextField = self as! UITextField
                fontType = textField.font?.fontName
                
            // For UIButtons
            } else if (self is UIButton) {
                
                let button: UIButton = self as! UIButton
                fontType = button.titleLabel?.font.fontName
            }
            
            return fontType!
        }
        set {
            
            // For UILabels
            if (self is UILabel) {
                
                let label: UILabel = self as! UILabel
                label.font = UIFont(name: self.fontForType(fontType: fontType), size: label.font.pointSize)
                
            // For UITextFields
            } else if (self is UITextField) {
                
                let textField: UITextField = self as! UITextField
                textField.font = UIFont(name: self.fontForType(fontType: fontType), size: (textField.font?.pointSize)!)
                
            // For UIButtons
            } else if (self is UIButton) {
                
                let button = self as! UIButton
                button.titleLabel?.font = UIFont(name: self.fontForType(fontType: fontType), size: (button.titleLabel?.font.pointSize)!)
            }
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
        
    func fontForType(fontType: String) -> String {
        
        var font: String?
        
        if (fontType.isEqual(kFontBoldType)) {
            
            font = kFontBold
            
        } else if (fontType.isEqual(kFontNormalType)) {
            
            font = kFontNormal
            
        } else {
            
            font = kFontNormal
        }
        
        return font!
    }
}
