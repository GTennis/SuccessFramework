//
//  StartViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 05/11/16.
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

protocol StartViewControllerDelegate: AnyObject {
    
    func didPressedLogin()
    func didPressedSkip()
}

class StartViewController: BaseViewController {
    
    var model: StartModel?
    weak var delegate: StartViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //self.viewLoader?.hideNavigationBar(viewController: self)
        
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
        
        model?.loadData(callback: { [weak self] (success, result, context, error) in
            
            self?.renderUI()
            })
    }
        
    // MARK: IBActions
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        self.delegate?.didPressedLogin()
    }
    
    @IBAction func skipPressed(_ sender: AnyObject) {
        
        self.delegate?.didPressedSkip()
    }
}
