//
//  MenuModel.swift
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

let kMenuModelMenuItemMapKey = "MenuItemHome"
let kMenuModelMenuItemSettingsKey = "MenuItemSettings"
let kMenuModelMenuItemTermsConditionsKey = "MenuItemTermsConditions"
let kMenuModelMenuItemPrivacyPolicyKey = "MenuItemPrivacyPolicy"
let kMenuModelMenuItemLoginKey = "MenuItemLogin"
let kMenuModelMenuItemLogoutKey = "MenuItemLogout"
let kMenuModelMenuItemLogoutConfirmationMessageKey = "MenuItemLogoutConfirmationMessage"
let kMenuModelMenuItemTableViewExampleKey = "MenuItemTableViewExample"
let kMenuModelMenuItemTableViewWithSearchKey = "MenuItemTableViewWithSearch"
let kMenuModelMenuItemMapWithSearchKey = "MenuItemMapWithSearch"

class MenuModel: BaseModel, UserManagerObserver {
    
    var menuItemList: Array<MenuEntityProtocol>!
    var viewControllerFactory: ViewControllerFactoryProtocol!
    var isUserLoggedIn: Bool {
        
        get {
            
            return self.userManager.isUserLoggedIn()
        }
    }
    
    deinit {
        
        self.userManager.removeServiceObserver(observer: self)
    }
    
    override func commonInit() {
     
        super.commonInit()
        
        self.userManager.addServiceObserver(observer: self, notificationType: UserManagerNotificationType.didLogin, callback: { [weak self] (success, result, context, error) in
            
            self?.menuItemList = self?.menuItemsForLoggedInUserState()
            
            // Notify view controler
            // Adding protection because was crashing upon opening app with 401
            if let callback = self?._loadModelCallback {
                
                callback(true, self?.menuItemList, nil, nil);
            }
            
        }, context: nil)
        
        self.userManager.addServiceObserver(observer: self, notificationType: UserManagerNotificationType.didSignUp, callback: { [weak self] (success, result, context, error) in
            
            self?.menuItemList = self?.menuItemsForLoggedInUserState()
            
            // Notify view controler
            // Adding protection because was crashing upon opening app with 401
            if let callback = self?._loadModelCallback {
                
                callback(true, self?.menuItemList, nil, nil);
            }
            
        }, context: nil)
    }
    
    func logoutUser() {
        
        self.userManager.logout { [weak self] (success, result, context, error) in
            
            self?.menuItemList = self?.menuItemsForNotLoggedInUserState()
            
            // Notify view controler
            // Adding protection because was crashing upon opening app with 401
            if let callback = self?._loadModelCallback {
                
                callback(true, self?.menuItemList, nil, nil);
            }
        }
    }
    
    override func willStartModelLoading(callback: @escaping Callback) {
        
        // Save for login/signup/logout callbacks later
        self._loadModelCallback = callback
        
        var menuItemList: Array<MenuEntityProtocol>?
        
        if (self.userManager.isUserLoggedIn()) {
            
            menuItemList = self.menuItemsForLoggedInUserState()
            
        } else {
            
            menuItemList = self.menuItemsForNotLoggedInUserState()
        }
        
        // Done
        callback(true, menuItemList, nil, nil)
    }
    
    override func didFinishModelLoading(data: Any?, error: ErrorEntity?) {
        
        // Store menu items
        self.menuItemList = data as! Array<MenuEntityProtocol>!
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _loadModelCallback: Callback?

    internal func menuItemsForNotLoggedInUserState() -> Array<MenuEntityProtocol> {
        
        // Create menu items
        var itemList: Array<MenuEntityProtocol> = Array()
        
        // Create menu items
        
        // Settings
        var item: MenuEntityProtocol = MenuEntity(title: localizedString(key: kMenuModelMenuItemSettingsKey), viewController: self.viewControllerFactory.settingsViewController(context: nil), isModal: false) as MenuEntityProtocol
        itemList.append(item)
        
        // User login
        item = MenuEntity(title: localizedString(key: kMenuModelMenuItemLoginKey), viewController: self.viewControllerFactory.userContainerViewController(context: nil), isModal: true) as MenuEntityProtocol
        itemList.append(item)
        
        // TermsConditions
        item = MenuEntity(title: localizedString(key: kMenuModelMenuItemTermsConditionsKey), viewController: self.viewControllerFactory.termsConditionsViewController(context: nil), isModal: false) as MenuEntityProtocol
        itemList.append(item)
        
        // Privacy policy
        item = MenuEntity(title: localizedString(key: kMenuModelMenuItemPrivacyPolicyKey), viewController: self.viewControllerFactory.privacyPolicyViewController(context: nil), isModal: false) as MenuEntityProtocol
        itemList.append(item)
        
        // TableViewExample
        /*item = [[MenuItemObject alloc] init];
        item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewExampleKey);
        item.viewController = (BaseViewController *) [viewControllerFactory tableViewExampleViewControllerWithContext:nil];
        [itemList addObject:item];
        
        // TableView with search
        item = [[MenuItemObject alloc] init];
        item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewWithSearchKey);
        item.viewController = (BaseViewController *) [viewControllerFactory tableWithSearchViewControllerWithContext:nil];
        [itemList addObject:item];
        
        // Map
        item = [[MenuItemObject alloc] init];
        item.menuTitle = GMLocalizedString(kMenuModelMenuItemMapWithSearchKey);
        item.viewController = (BaseViewController *) [viewControllerFactory mapsViewControllerWithContext:nil];
        [itemList addObject:item];*/
        
        // Return
        return itemList
    }
    
    func menuItemsForLoggedInUserState() -> Array<MenuEntityProtocol> {
        
        // Create menu items
        var itemList: Array<MenuEntityProtocol> = Array()
        
        // Create menu items
        
        // Settings
        var item: MenuEntityProtocol = MenuEntity(title: localizedString(key: kMenuModelMenuItemSettingsKey), viewController: self.viewControllerFactory.settingsViewController(context: nil), isModal: false) as MenuEntityProtocol
        itemList.append(item)
        
        // TermsConditions
        item = MenuEntity(title: localizedString(key: kMenuModelMenuItemTermsConditionsKey), viewController: self.viewControllerFactory.termsConditionsViewController(context: nil), isModal: false) as MenuEntityProtocol
        itemList.append(item)
        
        // Privacy policy
        item = MenuEntity(title: localizedString(key: kMenuModelMenuItemPrivacyPolicyKey), viewController: self.viewControllerFactory.privacyPolicyViewController(context: nil), isModal: false) as MenuEntityProtocol
        itemList.append(item)
        
        // TableViewExample
        /*item = [[MenuItemObject alloc] init];
         item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewExampleKey);
         item.viewController = (BaseViewController *) [viewControllerFactory tableViewExampleViewControllerWithContext:nil];
         [itemList addObject:item];
         
         // TableView with search
         item = [[MenuItemObject alloc] init];
         item.menuTitle = GMLocalizedString(kMenuModelMenuItemTableViewWithSearchKey);
         item.viewController = (BaseViewController *) [viewControllerFactory tableWithSearchViewControllerWithContext:nil];
         [itemList addObject:item];
         
         // Map
         item = [[MenuItemObject alloc] init];
         item.menuTitle = GMLocalizedString(kMenuModelMenuItemMapWithSearchKey);
         item.viewController = (BaseViewController *) [viewControllerFactory mapsViewControllerWithContext:nil];
         [itemList addObject:item];*/
        
        // Return
        return itemList
    }
}
