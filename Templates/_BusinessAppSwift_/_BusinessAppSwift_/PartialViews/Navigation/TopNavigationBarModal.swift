//
//  TopNavigationBarModal.swift
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

protocol TopNavigationBarModalDelegate {
    
    func didPressedCancelModal()
    func didPressedBackModal()
    func didPressedRightModal()
}

class TopNavigationBarModal: BaseNavigationBar {
    
    var delegate: TopNavigationBarModalDelegate?
    
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var rightButton: UIButton?
    
    func showCancelButton() {
        
        self.cancelButton?.isHidden = false
        self.backButton?.isHidden = true
    }
    
    override func showBackButton() {
        
        self.cancelButton?.isHidden = true
        self.backButton?.isHidden = false
    }
        
    // MARK: IBActions
    
    @IBAction func backPressed(sender: UIButton) {
        
        self.delegate?.didPressedBackModal()
    }
    
    @IBAction func cancelPressed(sender: UIButton) {
        
        self.delegate?.didPressedCancelModal()
    }
    
    @IBAction func rightPressed(sender: UIButton) {
        
        self.delegate?.didPressedRightModal()
    }
    
    override func commonInit() {
        
        super.commonInit()
        
        self.cancelButton?.setTitle(localizedString(key: ConstLangKeys.cancel), for: UIControlState.normal)
        self.rightButton?.setTitle(localizedString(key: ConstLangKeys.delete), for: UIControlState.normal)
    }
}
