//
//  MenuViewController.swift
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

class MenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    var model: MenuModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.tableView.tableFooterView = UIView()
        
        self.initUI()
        self.prepareUI()
        self.loadModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.viewLoader?.hideNavigationBar(viewController: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: GenericViewControllerProtocol
    
    func initUI() {
        
        // Fix menu screen size: make it full screen for all devices
        var rect: CGRect = self.view.frame
        rect.size = UIScreen.main.bounds.size
        self.view.frame = rect
        
        #if DEBUG
        
            let versionNo = Bundle.plistValue(key: "CFBundleShortVersionString") as! String
            let buildNo: String = Bundle.plistValue(key: kCFBundleVersionKey as String) as! String
        
            let versionLabel: UILabel = UILabel()
            versionLabel.text = "\(versionNo) [\(buildNo)]"
            versionLabel.textColor = UIColor.lightGray
            versionLabel.font = versionLabel.font.withSize(12)
            self.view.addSubview(versionLabel)
            versionLabel.viewAddLeadingSpace(16, containerView: self.view)
            versionLabel.viewAddTrailingSpace(0, containerView: self.view)
            versionLabel.viewAddBottomSpace(-54, containerView: self.view)
            versionLabel.viewAddHeight(40)

        #endif
    }
    
    override func prepareUI() {
        
        super.prepareUI()
    }
    
    override func renderUI() {
        
        super.renderUI()
        
        self.tableView.reloadData()
    }
    
    override func loadModel() {
        
        model?.loadData(callback: { [weak self] (success, result, context, error) in
            
            self?.renderUI()
            
            if let model = self?.model {
                
                if (model.isUserLoggedIn) {
                    
                    self?.showLogoutButton()
                    
                } else {
                    
                    self?.hideLogoutButton()
                }
            }
        })
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let menuItemList = self.model?.menuItemList {
            
            return menuItemList.count
            
        } else {
            
            return 0
        }
    }
    
    // For hiding separators between empty cell below table view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view: UIView = UIView()
        return view
    }

    // For hiding separators between empty cell below table view
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        // This will create a "invisible" footer
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier")
        if let cell = cell {
            
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.darkGray
            let bgView: UIView = UIView(frame: cell.frame)
            bgView.backgroundColor = UIColor.lightGray
            cell.selectedBackgroundView = bgView
            cell.textLabel?.fontType = kFontNormalType
            cell.textLabel?.text = self.titleForMenu(IndexPath: indexPath)
        }
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuItem = self.model?.menuItemList[indexPath.row]
        
        if (menuItem!.isPresentedModally) {
            
            self.presentModal(viewController: menuItem!.viewController, animated: true)
            
        } else {
            
            self.navigationController?.pushViewController(menuItem!.viewController, animated: true)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func logoutPressed(_ sender: AnyObject) {
        
        self.messageBarManager?.showAlertOkWithTitle(title: nil, description: localizedString(key: kMenuModelMenuItemLogoutConfirmationMessageKey), okTitle: localizedString(key: ConstLangKeys.ok), okCallback: { [weak self] in
            
                self?.logoutAndGoBackToAppStart(error: nil)
            
            }, cancelTitle: localizedString(key: ConstLangKeys.cancel), cancelCallback: nil)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    func titleForMenu(IndexPath: IndexPath) -> String {
        
        let menuItem = self.model!.menuItemList[IndexPath.row]
        
        return menuItem.menuTitle
    }
    
    func showLogoutButton() {
        
        var rect: CGRect = self.view.bounds
        rect.size.height = 40.0
        
        let logoutButton: NormalButton = NormalButton(frame: rect)
        logoutButton.setTitle(localizedString(key: kMenuModelMenuItemLogoutKey), for: UIControlState.normal)
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: UIControlEvents.touchUpInside)
        
        self.tableView.tableFooterView = logoutButton
    }

    func hideLogoutButton() {
        
        self.tableView.tableFooterView = nil
    }

}
