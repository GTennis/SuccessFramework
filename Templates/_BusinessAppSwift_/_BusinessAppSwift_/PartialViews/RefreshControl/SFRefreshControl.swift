//
//  SFRefreshControl.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 06/11/16.
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

class SFRefreshControl: NSObject {
    
    var view: UIRefreshControl
    
    required init(callback: @escaping SimpleCallback) {
        
        _callback = callback
        view = UIRefreshControl()
        
        super.init()
        
        view.addTarget(self, action: #selector(SFRefreshControl.didRefresh), for: UIControlEvents.valueChanged)
    }
    
    required init(target: UIViewController, callbackSelector: Selector) {
        
        _selector = callbackSelector
        view = UIRefreshControl()
        
        super.init()
        
        view.addTarget(self, action: #selector(SFRefreshControl.didRefresh), for: UIControlEvents.valueChanged)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _callback: SimpleCallback?
    internal var _selector: Selector?
    internal weak var _target: UIViewController?
    
    internal func didRefresh() {
        
        if let callback = _callback {
            
            callback()
            
        } else if let target = _target, let selector = _selector {
            
            target.perform(selector)
        }
    }
}
