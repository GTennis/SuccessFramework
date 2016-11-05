//
//  LaunchViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 06/09/16.
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

class LaunchViewController: BaseViewController {

    var model: LaunchModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.prepareUI()
        self.loadModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: GenericViewControllerProtocol
    
    override func prepareUI() {
        
        super.prepareUI()
    }
    
    override func renderUI() {
        
        super.renderUI()
    }
    
    override func loadModel() {
        
        self.renderUI()
    }
    
    // MARK: 
    // MARK: Internal
    // MARK:
    //internal
    
    // Used from: http://stackoverflow.com/a/27797958/597292
    // TODO:
    /*func launchImageName(orientation: UIInterfaceOrientation) -> String {
        
        CGSize viewSize = self.view.bounds.size;
        NSString *viewOrientation = @"Portrait";
        
        // Adjust for landscape mode
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            
            // Remove later when iOS 7 is not needed.
            if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
                
                viewSize = CGSizeMake(viewSize.height, viewSize.width);
            }
            
            viewOrientation = @"Landscape";
        }
        
        // Extract loaded launch images
        NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        
        // Loop through loaded launch images
        for (NSDictionary *dict in imagesDict) {
            
            CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
            
            // Return if launch image is found in loaded plist
            if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            
            return dict[@"UILaunchImageName"];
        }
        
        return nil;
    }*/
}
