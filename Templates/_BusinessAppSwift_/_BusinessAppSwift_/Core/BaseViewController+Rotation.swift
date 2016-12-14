//
//  BaseViewController+Rotation.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 14/12/16.
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

extension BaseViewController {
    
    override var shouldAutorotate: Bool {
        
        return true
    }
    
    // This method is needed when we support several orientations but screen looks best for one particular rotation. This is good when need to present screen in specific exceptional orientation. However, in our partical case we don't have and it causes screens to flip upside when app launched in not prefered orientation.
    /*func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
     
     if (isIpad) {
     
     return UIInterfaceOrientation.landscapeLeft
     
     } else if (isIphone) {
     
     return UIInterfaceOrientation.portrait
     }
     }*/
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if (isIpad) {
            
            return [UIInterfaceOrientationMask.landscapeRight, UIInterfaceOrientationMask.landscapeLeft]
            
        } else if (isIphone) {
            
            return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.portraitUpsideDown]
            
        } else {
            
            return UIInterfaceOrientationMask.portrait
        }
    }
}
