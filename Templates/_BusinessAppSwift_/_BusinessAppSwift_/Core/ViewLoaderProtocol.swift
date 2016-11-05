//
//  ViewLoaderProtocol.swift
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

protocol ViewLoaderProtocol {
    
    // MARK: Xib loading
    func loadView(xibName:String, classType: AnyClass) -> UIView?
    func loadViewFromXib(classType: AnyClass) -> UIView?
    
    // MARK: Progress indicators
    func showScreenActivityIndicator(containerView: UIView)
    func hideScreenActivityIndicator(containerView: UIView)
    
    // MARK: Refresh control
    func addRefreshControl(containerView: UIView, callback: @escaping SimpleCallback)
    
    // MARK: Internet connection status labels
    func showNoInternetConnectionLabel(containerView: UIView)
    func hideNoInternetConnectionLabel(containerView: UIView)
    
    // MARK: Empty list label
    func addEmptyListLabel(containerView: UIView, message: String, refreshCallback: SimpleCallback?)
    func removeEmptyListLabel(containerView: UIView)
    
    // MARK: For functional testing
    func prepareAccesibility(viewController: UIViewController)
    
    // MARK: navigation bars
    func addDefaultNavigationBar(viewController: GenericViewControllerProtocol)->TopNavigationBar?
    func addDefaultModalNavigationBar(viewController: GenericViewControllerProtocol)->TopNavigationBarModal?
    func showNavigationBar(viewController: UIViewController)
    func hideNavigationBar(viewController: UIViewController)
    func hasNavigationBar(viewController: UIViewController) -> Bool
}
