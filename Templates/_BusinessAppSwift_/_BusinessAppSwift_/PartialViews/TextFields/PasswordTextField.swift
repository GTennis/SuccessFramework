//
//  PasswordTextField.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 30/10/16.
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

import UIKit

let kTogglePasswordButtonToggleButtonTitleKey = "Toggle"
let kTogglePasswordButtonToggleButtonTitleFontSize = 12.0
let kTogglePasswordButtonToggleButtonTitleColor = kColorGrayDark

protocol PasswordTextFieldDelegate: AnyObject {
    
    func didPressedTogglePassword()
}

class PasswordTextField: BaseTextField {
    
    weak var toggleDelegate: PasswordTextFieldDelegate?
    var isPasswordShown: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.isPasswordShown = (self.isSecureTextEntry) ? false : true
    }
    
    func togglePasswordReveal() {
        
        if (self.isPasswordShown!) {
            
            self.isSecureTextEntry = true
            //   [_togglePasswordRevealButton setTitle:GMLocalizedString(kShowKey) forState:UIControlStateNormal];
            
            _togglePasswordRevealButton?.setImage(UIImage.init(named: "password-show"), for: UIControlState.normal)
            
            self.isPasswordShown = false
            
        } else {
            
            self.isSecureTextEntry = false
            // [_togglePasswordRevealButton setTitle:GMLocalizedString(kHideKey) forState:UIControlStateNormal];
            _togglePasswordRevealButton?.setImage(UIImage.init(named: "password-hide"), for: UIControlState.normal)
            
            self.isPasswordShown = true
        }
        
        self.toggleDelegate?.didPressedTogglePassword()
        self.moveCursorToTheEndOfText()
    }
    
    override var textClearButtonSizeWhileEditing: CGSize {
        
        get {
            
            return CGSize(width: 50.0, height: 30.0)
        }
    }
    
    override func commonInit_() {
        
        super.commonInit_()
        self.addShowHidePasswordControl()
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _togglePasswordRevealButton: UIButton?
    
    internal func addShowHidePasswordControl() {
        
        // Button size
        let togglePasswordButtonWidth: CGFloat = self.textClearButtonSizeWhileEditing.width
        let togglePasswordButtonHeight: CGFloat = self.textClearButtonSizeWhileEditing.height
        
        // Right separator size
        let rightSpaceSeparatorViewWidth: CGFloat = 10
        let rightSpaceSeparatorViewHeight: CGFloat = togglePasswordButtonHeight
        
        // Container view size
        let showHideContainerViewWidth: CGFloat = togglePasswordButtonWidth + rightSpaceSeparatorViewWidth
        let showHideContainerViewHeight: CGFloat = togglePasswordButtonHeight
        
        // Create toggle button
        self._togglePasswordRevealButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: togglePasswordButtonWidth, height: togglePasswordButtonHeight))
        let font: UIFont = (self._togglePasswordRevealButton!.titleLabel!.font)!
        _togglePasswordRevealButton?.titleLabel?.font = font.withSize(CGFloat(kTogglePasswordButtonToggleButtonTitleFontSize))
        self._togglePasswordRevealButton?.setTitle(kTogglePasswordButtonToggleButtonTitleKey, for: UIControlState.normal)
        self._togglePasswordRevealButton?.setTitleColor(kTogglePasswordButtonToggleButtonTitleColor, for: UIControlState.normal)
        
        //[_togglePasswordRevealButton setImage:[UIImage imageNamed:@"IconShowHidePassword"] forState:UIControlStateNormal];
        _togglePasswordRevealButton?.addTarget(self, action: #selector(PasswordTextField.togglePasswordReveal), for: UIControlEvents.touchUpInside)
        
        // Add identifiers for functional tests
        let buttonName: String = "ShowHidePasswordButton"
        self._togglePasswordRevealButton?.isAccessibilityElement = true
        self._togglePasswordRevealButton?.accessibilityLabel = buttonName
        self._togglePasswordRevealButton?.accessibilityIdentifier = buttonName
        
        // Create separator
        let rightSpaceSeparatorView: UIView = UIView(frame: CGRect(x: togglePasswordButtonWidth, y: 0, width: rightSpaceSeparatorViewWidth, height: rightSpaceSeparatorViewHeight))
        
        // Create container view
        let showHideContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: showHideContainerViewWidth, height: showHideContainerViewHeight))
        
        showHideContainerView.addSubview(self._togglePasswordRevealButton!)
        showHideContainerView.addSubview(rightSpaceSeparatorView)
        
        // Add right view
        self.rightView = showHideContainerView
        self.rightViewMode = UITextFieldViewMode.whileEditing
    }
    
    // Used from http://stackoverflow.com/questions/11157791/how-to-move-cursor-in-uitextfield-after-setting-its-value
    internal func moveCursorToTheEndOfText() {
        
        let beginning: UITextPosition = self.beginningOfDocument
        let start: UITextPosition = self.position(from: beginning, offset: 0)!
        let end: UITextPosition = self.position(from: start, offset: (self.text?.characters.count)!)!
        let textRange: UITextRange = self.textRange(from: start, to: end)!
        
        // this will be the new cursor location after insert/paste/typing
        let cursorOffset: Int = self.offset(from: beginning, to: start) + (self.text?.characters.count)!
        
        // now apply the text changes that were typed or pasted in to the text field
        self.replace(textRange, withText: self.text!)
        
        // now update the reposition the cursor afterwards
        let newCursorPosition: UITextPosition = self.position(from: self.beginningOfDocument, offset: cursorOffset)!
        let newSelectedRange: UITextRange = self.textRange(from: newCursorPosition, to: newCursorPosition)!
        self.selectedTextRange = newSelectedRange
    }
}
