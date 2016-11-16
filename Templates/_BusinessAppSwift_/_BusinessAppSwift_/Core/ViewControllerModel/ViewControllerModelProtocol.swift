//
//  ViewControllerModelProtocol.swift
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

protocol ViewControllerModelProtocol {
    
    var userManager: UserManagerProtocol! {get set}
    var settingsManager: SettingsManagerProtocol! {get set}
    var networkOperationFactory: NetworkOperationFactoryProtocol! {get set}
    var reachabilityManager: ReachabilityManagerProtocol! {get set}
    var analyticsManager: AnalyticsManagerProtocol! {get set}
    var context: Any? {get set}
    
    var isLoaded: Bool {get}
    var delegate: ViewControllerModelDelegate? {get set}
    
    func commonInit()
    func loadData(callback: @escaping Callback)
    
    func willStartModelLoading(callback: @escaping Callback)
    func didFinishModelLoading(data: Any?, error: ErrorEntity?)
}