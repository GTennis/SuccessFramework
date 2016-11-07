//
//  BaseNavigationBar.swift
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

#if DEBUG
    import FLEX
#endif

class BaseNavigationBar: UIView {
    
    @IBOutlet weak var titleLabel: NormalLabel?
    @IBOutlet weak var backButton: UIButton?
    
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
    
    func showBackButton() {
        
        self.backButton?.isHidden = false
    }
    
    func hideBackButton() {
        
        self.backButton?.isHidden = true
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal func commonInit() {
        
        #if DEBUG
            
            let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(BaseNavigationBar.debugConsoleTapDetected(gestureRecognizer:)))
            gestureRecognizer.numberOfTapsRequired = 4
            self.addGestureRecognizer(gestureRecognizer)
            
        #endif
    }
    
    internal func debugConsoleTapDetected(gestureRecognizer: UITapGestureRecognizer) {
        
        (FLEXManager.shared().isHidden) ? FLEXManager.shared().showExplorer() : FLEXManager.shared().hideExplorer()
    }
}
