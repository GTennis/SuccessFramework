//
//  SFSearchBar.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 03/11/16.
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

let kOKSearchBarCustomSearchIconTraillingOffset = -15.0
let kOKSearchBarCustomSearchIconBottomOffset = -10.0

class SFSearchBar: UISearchBar, UISearchBarDelegate {
    
    var isCancelShown: Bool
    
    required init?(coder aDecoder: NSCoder) {
        
        self.isCancelShown = true
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func setDelegate(delegate: UISearchBarDelegate) {
        
        super.delegate = self
        
        _externalDelegate = delegate
    }
    
    override var text: String? {
        
        get {
            
            return super.text
        }
        set {
            
            super.text = newValue
            self.setIsShownCustomSearchIcon(isShown: false)
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    var _customSearchIconImageView: UIImageView?
    weak var _externalDelegate: AnyObject?
    
    func setIsShownCustomSearchIcon(isShown: Bool) {
        
        if isShown {
            
            UIView.animate(withDuration: 0.2, delay:0.2, options: UIViewAnimationOptions.curveEaseIn, animations: { [weak self] in
                
                self?._customSearchIconImageView?.alpha = 1.0
                
                }, completion: nil)
            
        } else {
            
            self._customSearchIconImageView?.alpha = 0
        }
    }
    
    internal func commonInit() {
        
        // Adjust search style
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        
        // Customize cancel color
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = kColorGreen
        let searchBarIconImage: UIImage = UIImage(named: "iconSearchBar")!
        _customSearchIconImageView = UIImageView.init(image: searchBarIconImage)
        
        // Change search bar icon. Using a workaround:
        
        // 1. Hide search icon
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).leftViewMode = UITextFieldViewMode.never
        
        // For changing cursor color
        //[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:kColorBlueLight];
        
        // 2. Add search image as subView
        self.addSubview(_customSearchIconImageView!)
        
        // 3. Add needed constraints
        _ = _customSearchIconImageView?.viewAddBottomSpace(CGFloat(kOKSearchBarCustomSearchIconBottomOffset), containerView: self)
        _ = _customSearchIconImageView?.viewAddTrailingSpace(CGFloat(kOKSearchBarCustomSearchIconTraillingOffset), containerView: self)
        
        // Change search bar icon
        //[_searchBar setImage:customSearcBarIconImage forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        UITextField.appearance(whenContainedInInstancesOf: [SFSearchBar.self]).textColor = kColorGreen
        UITextField.appearance(whenContainedInInstancesOf: [SFSearchBar.self]).backgroundColor = kColorGrayLight2
    }
    
    // MARK: Forwarding events
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        var result: Bool = true
        result = (_externalDelegate?.searchBarShouldBeginEditing(searchBar))!
        
        return result
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.setIsShownCustomSearchIcon(isShown: false)
        
        if (self.isCancelShown) {
            
            self.setShowsCancelButton(true, animated: true)
        }
        
        _externalDelegate?.searchBarTextDidBeginEditing(searchBar)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        var result = true
        result = (_externalDelegate?.searchBarShouldEndEditing(searchBar))!
        
        return result
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        // Search bar shows clear button even after resign first responder if there's a text
        // Therefore we won't show search icon on top
        if let text = searchBar.text {
            
            if text.characters.count == 0 {
                
                self.setIsShownCustomSearchIcon(isShown: true)
            }
        }
        
        self.setShowsCancelButton(false, animated: true)
        
        _externalDelegate?.searchBarTextDidEndEditing(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        _externalDelegate?.searchBarSearchButtonClicked(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.text = ""
        self.setShowsCancelButton(false, animated: true)
        
        _externalDelegate?.searchBarCancelButtonClicked(searchBar)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
        _externalDelegate?.searchBarResultsListButtonClicked(searchBar)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        _externalDelegate?.searchBarBookmarkButtonClicked(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        _externalDelegate?.searchBar(searchBar, textDidChange: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var result: Bool = true
        
        result = (_externalDelegate?.searchBar(searchBar, shouldChangeTextIn: range, replacementText: text))!
        
        return result
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        _externalDelegate?.searchBar(searchBar, selectedScopeButtonIndexDidChange: selectedScope)
    }
}
