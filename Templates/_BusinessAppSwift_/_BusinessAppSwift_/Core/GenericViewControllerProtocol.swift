//
//  GenericViewControllerProtocol.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 21/10/2016.
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

protocol Injectable {
    
    associatedtype T
    func inject(_: T)
}

protocol GenericViewControllerProtocol {
    
    // MARK: UIViewController
    var view: UIView! {get}
    var title: String? {get set}
    var presentingViewController: UIViewController? {get}
    var navigationController: UINavigationController? {get}
    var navigationItem: UINavigationItem {get}
    var tabBarController: UITabBarController? {get}
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Swift.Void)?)
    
    // MARK
    
    var genericViewController: GenericViewController? {get set}
    // Did get it working. Compiler expects this property implemented with exact type
    //var _model: BaseModelProtocol? {get set}
    
    // Ipad 
    weak var modalContainerView4Ipad: UIView? {get set}
    
    func className()->String
    func isModal() -> Bool
    
    // MARK: Common functionality
    
    //func commonInit()
    func prepareUI()
    func renderUI()
    func loadModel()
    
    // MARK: Progress indicators
    
    func showScreenActivityIndicator()
    func hideScreenActivityIndicator()
    
    // MARK: Xib loading
    
    func loadViewFromXib(classType: AnyClass) -> UIView?
    
    // MARK: Navigation handling
    
    func showNavigationBar()
    func hideNavigationBar()
    func hasNavigationBar() -> Bool
}
