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

    // The code deals with the following issue: navigation bar leaves some small blank margin space on the left and right sides of custom titleView. The workaround is protect and make width always be full width
    override var frame: CGRect {
        
        get {
            
            return super.frame
        }
        set {
            
            var rect: CGRect = newValue
            var newWidth: CGFloat = newValue.size.width
            
            // This statement will always return size in portrait
            let screenSize: CGSize = UIScreen.main.bounds.size
            
            // Remove left margin space
            rect.origin.x = 0
            
            // If running in landscape mode
            if (newWidth > screenSize.width) {
                
                // Adjusting to full width
                newWidth = screenSize.height
                
            // portrait mode
            } else {
                
                // Adjusting to full width
                newWidth = screenSize.width
            }
            
            // Set adjusted full width
            rect.size.width = newWidth
        
            // Modify
            super.frame = rect
        }
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
        
        // Currently supporting single rotation (landscape for iPad, portrait for iPhone).
        // Todo: Check this link for rotation issues if need to support multiple orientations: http://stackoverflow.com/questions/4688137/ios-navigation-bars-titleview-doesnt-resize-correctly-when-phone-rotates
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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
