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

class LaunchViewController: UIViewController, GenericViewControllerProtocol, UITableViewDelegate {

    var genericViewController: GenericViewController?
    var model: LaunchModel?
    @IBOutlet weak var modalContainerView4Ipad: UIView?
    
    deinit {
        
        // ...
    }
    
    /*required init() {
        
        super.init(nibName: nil, bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.genericViewController?.viewDidLoad()
        
        self.prepareUI()
        self.loadModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.genericViewController?.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.genericViewController?.viewWillDisappear(true)
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        self.genericViewController?.didReceiveMemoryWarning()
    }
    
    // MARK: GenericViewControllerProtocol
    
    func prepareUI() {
        
        // TODO:
        // Use and set the same launch image as screen background image
        //NSString *launchImageName = [self launchImageNameForOrientation:self.interfaceOrientation];
        //_backgroundImageView.image = [UIImage imageNamed:launchImageName];
    }
    
    func renderUI() {
        
        // ...
    }
    
    func loadModel() {
        
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
