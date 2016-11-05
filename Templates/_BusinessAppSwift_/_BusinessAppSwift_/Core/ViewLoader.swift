//
//  ViewLoader.swift
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

import Foundation
import MBProgressHUD

// Activity indicator tag
let kScreenActivityIndicatorTag = 20131217
let kViewManagerEmptyListLabelTag = 20160201
let kViewManagerRefreshControlTag = 20161106

class ViewLoader : ViewLoaderProtocol {
    
    // MARK: ViewManagerProtocol
    
    // MARK: Xib loading
    func loadView(xibName:String, classType: AnyClass) -> UIView? {
        
        var loadedView: UIView? = nil
        let viewsFromXib: Array <UIView>? = Bundle.main.loadNibNamed(xibName, owner: nil, options: nil) as! Array<UIView>?
        
        if let viewsFromXib = viewsFromXib {
            
            let view: UIView? = viewsFromXib.first
            
            if let view = view {
                
                if (view.isKind(of: classType)) {
                    
                    loadedView = view;
                }
            }
        }
        
        return loadedView;
    }
    
    func loadViewFromXib(classType: AnyClass) -> UIView? {
        
        var xibName: String = classNameFromClassType(classType: classType)
        
        if (isIpad) {
            
            xibName = xibName + "_ipad"
            
        } else {
            
            xibName = xibName + "_iphone"
        }
        
        let view: UIView? = self.loadView(xibName: xibName, classType: classType)
        
        return view;
    }
    
    // MARK: Progress indicators
    func showScreenActivityIndicator(containerView: UIView) {
        
        // Disable user interface
        containerView.isUserInteractionEnabled = false
        
        var activityView: MBProgressHUD? = containerView.viewWithTag(kScreenActivityIndicatorTag) as? MBProgressHUD
        
        if (activityView == nil) {
            
            // Check another init method if this will not work
            activityView = MBProgressHUD.init(view: containerView)
            activityView?.tag = kScreenActivityIndicatorTag
            activityView?.bezelView.backgroundColor = UIColor.black
            activityView?.center = containerView.center
        }
        
        containerView.addSubview(activityView!)
        containerView.bringSubview(toFront: activityView!)
        activityView?.show(animated: true)
    }
    
    func hideScreenActivityIndicator(containerView: UIView) {
        
        let activityView: MBProgressHUD? = containerView.viewWithTag(kScreenActivityIndicatorTag) as! MBProgressHUD?
        
        if let activityView = activityView {
            
            activityView.hide(animated: true)
            activityView.removeFromSuperview()
        }
        
        containerView.isUserInteractionEnabled = true
    }
    
    // MARK: Refresh control
    
    func addRefreshControl(containerView: UIView, callback: @escaping SimpleCallback) {
        
        let refreshControl: UIRefreshControl? = containerView.viewWithTag(kViewManagerRefreshControlTag) as! UIRefreshControl?
        
        if refreshControl == nil {
            
            let ctrl = SFRefreshControl.init(callback: callback)
            containerView.addSubview(ctrl.view)
        }
    }
    
    // MARK: Internet connection status labels
    func showNoInternetConnectionLabel(containerView: UIView) {
        
        let button: ConnectionStatusButton? = containerView.viewWithTag(kConnectionStatusLabelTag) as! ConnectionStatusButton?
        
        if (button == nil) {
            
            let button: ConnectionStatusButton = ConnectionStatusButton()
            containerView.addSubview(button)
            
            let margin: CGFloat = containerView.bounds.size.width * 0.1
            
            button.viewAddLeadingSpace(margin, containerView: containerView)
            button.viewAddTrailingSpace(-margin, containerView: containerView)
            button.viewAddTopSpace(margin, containerView: containerView)
        }
    }
    
    func hideNoInternetConnectionLabel(containerView: UIView) {
        
        let label: ConnectionStatusButton? = containerView.viewWithTag(kConnectionStatusLabelTag) as! ConnectionStatusButton?
        label?.removeFromSuperview()
    }
    
    // MARK: Empty list label
    func addEmptyListLabel(containerView: UIView, message: String, refreshCallback: SimpleCallback?) {
        
        self.removeEmptyListLabel(containerView: containerView)
        
        let emptyListLabelButton: UIButton = UIButton()
        emptyListLabelButton.setTitleColor(kColorWhite, for: UIControlState.normal)
        
        emptyListLabelButton.tag = kViewManagerEmptyListLabelTag
        emptyListLabelButton.titleLabel?.textAlignment = NSTextAlignment.center
        emptyListLabelButton.titleLabel?.numberOfLines = 0
        emptyListLabelButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        emptyListLabelButton.setTitle(message, for: UIControlState.normal)
        
        // Add label
        containerView.addSubview(emptyListLabelButton)
        
        // Add constraints
        let containerViewTopMargin: CGFloat = 20.0
        let screenSize: CGSize = UIScreen.main.bounds.size
        
        emptyListLabelButton.viewAddLeadingSpace(0, containerView: containerView)
        emptyListLabelButton.viewAddTrailingSpace(0, containerView: containerView)
        emptyListLabelButton.viewAddWidth(screenSize.width)
        emptyListLabelButton.viewAddTopSpace(containerViewTopMargin, containerView: containerView)
        
        _refreshEmptyListCallback = refreshCallback
        if _refreshEmptyListCallback != nil {
            
            emptyListLabelButton.addTarget(self, action: #selector(ViewLoader.refreshEmptyList), for: UIControlEvents.touchUpInside)
        }
        
        //return emptyListLabelButton;
    }
    
    func removeEmptyListLabel(containerView: UIView) {
        
        let view: UIView? = containerView.viewWithTag(kViewManagerEmptyListLabelTag)
        view?.removeFromSuperview()
    }
    
    // MARK: For functional testing
    func prepareAccesibility(viewController: UIViewController) {
        
        // Add identifiers for functional tests
        viewController.view.isAccessibilityElement = true
        var screenName: String = className(object: viewController)
        screenName = screenName.replacingOccurrences(of: "_iphone", with: "")
        screenName = screenName.replacingOccurrences(of: "_ipad", with: "")
        
        viewController.view.accessibilityLabel = screenName
        viewController.view.accessibilityIdentifier = screenName
    }
    
    // MARK: Navigation
    
    func addDefaultNavigationBar(viewController: GenericViewControllerProtocol)->TopNavigationBar? {
        
        let vc = viewController as! UIViewController
        
        // No need to add navCtrl for screens without nagivation (for example menuVC)
        
        if (vc.navigationController == nil) {
            
            return nil
        }
        
        // Creating and adding custom navigation bar
        let navigationBar: TopNavigationBar? = self.loadViewFromXib(classType: TopNavigationBar.self) as! TopNavigationBar?
        
        if navigationBar == nil {
            
            return nil
        }
        
        // Add navigation bar style
        // Could be applied blogaly in AppDelegate didFinish launch
        // UINavigationBar.appearance().isTranslucent = true
        vc.navigationController?.navigationBar.isTranslucent = true
        
        vc.navigationItem.titleView = navigationBar!
        
        // Hides default 1px gray bottom separator line
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        
        // This is a work around to get rid of ellipsis when navigating back
        // Taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        
        // Hide back button if it's root view controller
        if let navCtrl = vc.navigationController {
            
            if ((navCtrl.viewControllers.count) > 1) {
                
                navigationBar!.showBackButton()
                
            } else {
                
                navigationBar!.hideBackButton()
            }
        } else {
            
            navigationBar!.hideBackButton()
        }
        
        return navigationBar
    }
    
    func addDefaultModalNavigationBar(viewController: GenericViewControllerProtocol)->TopNavigationBarModal? {
        
        let vc = viewController as! UIViewController
        
        // Creating and adding custom navigation bar
        let navigationBar: TopNavigationBarModal? = self.loadViewFromXib(classType: TopNavigationBarModal.self) as! TopNavigationBarModal?
        
        if navigationBar == nil {
            
            return nil
        }
        
        // Add navigation bar style
        vc.navigationController?.navigationBar.isTranslucent = false
        
        if (isIpad) {
            
            // ...
            
        } else {
            
            // This will add navigation bar onto navigation controller's bar
            vc.navigationItem.titleView = navigationBar;
            // this is a work around to get rid of ellipsis when navigating back
            // taken from http://stackoverflow.com/questions/19151309/strange-ellipsis-appearing-in-uinavigationbar
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        }
        
        if let navCtrl = vc.navigationController {
            
            if ((navCtrl.viewControllers.count) > 1) {
                
                navigationBar!.showBackButton()
                
            } else {
                
                navigationBar!.hideBackButton()
            }
        } else {
            
            navigationBar!.hideBackButton()
        }
        
        return navigationBar
    }
    
    func showNavigationBar(viewController: UIViewController) {
        
        viewController.navigationController?.navigationBar.isTranslucent = false
        viewController.navigationController?.isNavigationBarHidden = false
    }
    
    func hideNavigationBar(viewController: UIViewController) {
        
        viewController.navigationController?.navigationBar.isTranslucent = true
        viewController.navigationController?.isNavigationBarHidden = true
    }
    
    func hasNavigationBar(viewController: UIViewController) -> Bool {
        
        let isHidden = viewController.navigationController?.isNavigationBarHidden
        
        return !isHidden!
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _refreshEmptyListCallback: SimpleCallback?
    
    @objc func refreshEmptyList(){
        
        if let refreshCallback = _refreshEmptyListCallback {
            
            refreshCallback()
        }
    }
}
