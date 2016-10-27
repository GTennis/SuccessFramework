//
//  GenericDetailsViewControllerProtocol.swift
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

protocol GenericDetailsViewControllerProtocol: class, KeyboardControlDelegate {

    // MARK: Keyboard

    var keyboardControls: KeyboardControlProtocol? {get set}
    
    func newKeyboardControls(fields: Array<UITextInput>, actionTitle: String)->KeyboardControlProtocol
    func scrollToActiveField(textField: UITextInput)
    
    // MARK: Field validation styling
    
    func applyStyleForMissingRequiredFields()
    func resetStyleForMissingRequiredFields()
}

extension GenericDetailsViewControllerProtocol {
    
    func newKeyboardControls(fields: Array<UITextInput>, actionTitle: String)->KeyboardControlProtocol {

        // Create class for managing field navigation
        //KeyboardControlsPrevNext *keyboardControls = [[KeyboardControlsPrevNext alloc] initWithFields:fields actionTitle:GMLocalizedString(kDoneKey)];
        let controls: KeyboardControl = KeyboardControl.init(fields: fields, actionTitle: actionTitle)
        controls.delegate = self
        
        // Add delegate to all fields
        for field in fields {
            
            (field as! UITextField).delegate = controls
        }
        
        return controls
    }
    
    func scrollToActiveField(textField: UITextInput) {
        
        // TODO: Not implemented
    }
    
    func applyStyleForMissingRequiredFields() {
        
        var input: DataInputFormTextFieldProtocol?
        
        for field in (self.keyboardControls?.fields)! {
            
            input = field as? DataInputFormTextFieldProtocol
            input?.validateValue()
        }
    }
    
    func resetStyleForMissingRequiredFields() {
        
        var input: DataInputFormTextFieldProtocol?
        
        for field in (self.keyboardControls?.fields)! {
         
            input = field as? DataInputFormTextFieldProtocol
            input?.resetValidatedValues()
        }
    }
    
    // MARK: 
    // MARK: Internal
    // MARK: 
    
}
