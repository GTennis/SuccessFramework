//
//  KeyboardControl.swift
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

protocol KeyboardControlDelegate: AnyObject {

    // When last text field is active then GO button is shown right+bottom on the keyboard and it should be used for handling action (Save, Send, Register, ...)
    func didPressGo()
    
    // MARK: Optional
    
    func didPressToolbarAction()
    func didPressToolbarCancel()
}

extension KeyboardControlDelegate {
    
    func didPressToolbarAction() {
        
        // Override in for customization
    }
    
    func didPressToolbarCancel() {
        
        // Override in for customization
    }
}

class KeyboardControl: NSObject, KeyboardControlProtocol {

    // MARK: KeyboardControlProtocol
    
    var activeField: UITextInput?
    var fields: NSMutableArray!
    weak var delegate: KeyboardControlDelegate?
    
    required init(fields: Array<UITextInput>, actionTitle: String) {
        
        super.init()
        
        self.fields = NSMutableArray()
        
        self._actionTitle = actionTitle;
        self.setFields(list: fields)
    }
    
    // MARK: UITextFieldDelegate
    
    func nextTextField() -> UITextField? {
        
        let nextTextField: UITextField? = self.nextFieldFromField(fromField: self.activeField as! UITextField)
        
        return nextTextField;
    }
    
    func nextFieldFromField(fromField: UITextField) -> UITextField? {
        
        var nextTextField: UITextField?
        
        // Current field index
        var fieldIndex: Int = self.fields.index(of: fromField)
        
        // Proceed if there's at least one field managed by _keyboardControls
        if (self.fields?.lastObject) != nil {
            
            // Next field index
            if (fieldIndex < self.fields.count - 1) {
                
                fieldIndex = fieldIndex + 1
                
                nextTextField = self.fields[fieldIndex] as? UITextField
                
                // If textField is already last field
            } else if (fieldIndex + 1 == self.fields.count) {
                
                //[self donePressed];
            }
        }
        
        if let unwrappedNextTextField = nextTextField {
            
            // If text field is disable AND it's not the last field
            if (!unwrappedNextTextField.isEnabled && !(fieldIndex + 1 == self.fields.count)) {
                
                // Jump to the next field
                nextTextField = self.nextFieldFromField(fromField: unwrappedNextTextField)
            }
        }
        
        return nextTextField
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTextField: UITextField? = self.nextTextField()
        
        if let nextTextField = nextTextField {
            
            nextTextField.becomeFirstResponder()
            
        } else {
            
            self.lastFieldReturnPressed()
        }
        
        return true
    }

    func lastFieldReturnPressed() {
        
        for field in self.fields! {
            
            (field as! UIControl).resignFirstResponder()
        }
        
        self.delegate?.didPressGo()
    }
    
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal lazy var _keyboardToolBar: UIToolbar = {
        
        let keyboardWidth: CGFloat = UIScreen.main.bounds.size.width
        let keyboardHeight: CGFloat = 50.0
        
        let rect = CGRect(x: 0, y: 0, width: keyboardWidth, height: keyboardHeight)
        let toolbar = UIToolbar(frame: rect)
        toolbar.isTranslucent = false
        //toolbar.barTintColor = kColorGrayLight2;
        toolbar.barStyle = UIBarStyle.default
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: localizedString(key: ConstLangKeys.cancel), style: UIBarButtonItemStyle.plain, target: self, action: #selector(KeyboardControl.toolbarCancelPressed))
        cancelButton.accessibilityLabel = "keyboardToolbarCancelButton"
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName:kColorGrayDark], for: UIControlState.normal)
        
        let separator: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let actionButton: UIBarButtonItem = UIBarButtonItem(title: self._actionTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(KeyboardControl.toolbarActionPressed))
        actionButton.accessibilityLabel = "keyboardToolbarActionButton"
        actionButton.setTitleTextAttributes([NSForegroundColorAttributeName:kColorGrayDark], for: UIControlState.normal)

        toolbar.items = [cancelButton, separator, actionButton]
        
        return toolbar
    }()
    
    internal var _actionTitle: String?
    
    internal func setFields(list: Array<UITextInput>) {
    
        var i: Int = 0
        
        for field in list {
            
            if (field is UITextField) {
                
                let textField = field as! UITextField
                textField.inputAccessoryView = self._keyboardToolBar
                
                if (i < list.count - 1) {
                    
                    self.setNextForField(field: textField)
                    
                } else {
                    
                    self.setGoForField(field: textField)
                }
                
            } else if (field is UITextView) {
                
                let textView = field as! UITextView
                textView.inputAccessoryView = self._keyboardToolBar
                
                if (i < list.count - 1) {
                    
                    self.setNextForField(field: field as! UITextField)
                    
                } else {
                    
                    self.setGoForField(field: field as! UITextField)
                }
            }
            
            i = i + 1
        }
        
        for field in list {
            
            self.fields.add(field)
        }
    }
    
    internal func setNextForField(field: UITextField) {
        
        field.returnKeyType = UIReturnKeyType.next
    }
    

    internal func setGoForField(field: UITextField) {
        
        field.returnKeyType = UIReturnKeyType.go
    }
    
    func toolbarCancelPressed() {
        
        for field in self.fields! {
            
            (field as! UIControl).resignFirstResponder()
        }

        self.delegate?.didPressToolbarCancel()
    }

    func toolbarActionPressed() {
        
        self.delegate?.didPressToolbarAction()
    }
}
