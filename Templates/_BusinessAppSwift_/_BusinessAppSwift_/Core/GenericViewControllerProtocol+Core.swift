//
//  GenericViewControllerProtocol+Core.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 26/10/2016.
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

extension GenericViewControllerProtocol {
    
    // TODO: Not ported: but actually could be added manually on every ipad vc, not a big problem. This way outlets are explicitly declared in each vc, and not hidden somewhere
    // @property (nonatomic, strong) IBOutlet UIView *modalContainerView; <-- for ipad containerView centered as iphoneView
    
    func className()->String {
        
        let className = "\(type(of: self))"
        
        return className
    }
    
    // MARK: Modal screen handling
    
    func isModal() -> Bool {
        
        if self.presentingViewController != nil {
            
            return true
            
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            
            return true
            
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            
            return true
        }
        
        return false
    }
    
    func presentModal(viewController:UIViewController, animated: Bool) {
        
        var navController: UINavigationController
        
        if (viewController is UINavigationController) {
            
            navController = viewController as! UINavigationController
            
        } else {
            
            navController = UINavigationController.init(rootViewController: viewController)
        }
        
        if (isIpad && (genericViewController?.shouldModalNavigationBarAlwaysStickToModalContainerViewTopForIpad)!) {
            
            navController.navigationBar.isHidden = true;
        }
        
        navController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        if (self.isModal()) {
            
            self.present(navController, animated: animated, completion: {
                //...
            })
            
        } else {
            
            // For TabBar application
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(navController, animated: animated, completion: {
                //...
            })
        }
    }
    
    func dismissModalViewController(animated: Bool) {
        
        self.presentingViewController?.dismiss(animated: animated, completion: {
            //...
        })
    }
    
    // MARK: Progress indicators
    
    func showScreenActivityIndicator() {
        
        self.genericViewController?.viewLoader?.showScreenActivityIndicator(containerView: self.view)
    }
    
    func hideScreenActivityIndicator() {
        
        self.genericViewController?.viewLoader?.hideScreenActivityIndicator(containerView: self.view)
    }
    
    // MARK: Xib loading
    
    func loadViewFromXib(classType: AnyClass) -> UIView? {
        
        let view: UIView? = self.genericViewController?.viewLoader?.loadViewFromXib(classType: classType)
        
        return view
    }
    
    // MARK: Navigation handling
    
    func showNavigationBar() {
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func hideNavigationBar() {
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func hasNavigationBar() -> Bool {
        
        let isHidden = self.navigationController?.isNavigationBarHidden
        
        return !isHidden!
    }
    
    // MARK: Screen title
    mutating func setTitle(title: String) {
        
        self.title = title
        
        self.navigationItem.title = title;
        
        // Setting title for top main or modal navigation bar
        let navigationBar: BaseNavigationBar = self.navigationItem.titleView as! BaseNavigationBar
        navigationBar.titleLabel?.text = title;
    }
}
