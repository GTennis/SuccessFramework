//
//  HomeViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 24/10/2016.
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

let kHomeViewControllerTitleKey = "HomeTitle"
let kHomeViewControllerDataLoadingProgressLabelKey = "HomeProgressLabel"

class HomeViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, HomeCellDelegate {

    var model: HomeModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        self.collectionView.scrollsToTop = true
        
        self.prepareUI()
        self.loadModel()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Log user behaviour
        self.analyticsManager?.log(screenName: kAnalyticsScreen.home)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: GenericViewControllerProtocol
    
    
    override func prepareUI() {
        
        super.prepareUI()
        
        // ...
        //self.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseIdentifier)
        
        // Set title
        self.viewLoader?.setTitle(viewController: self, title: localizedString(key: kHomeViewControllerTitleKey))
    }
    
    override func renderUI() {
        
        super.renderUI()
        
        // Reload
        self.collectionView.reloadData()
    }
    
    override func loadModel() {
        
        self.renderUI()
        
        
        self.viewLoader?.showScreenActivityIndicator(containerView: self.view)
        
        self.model?.loadData(callback: {[weak self] (success, result, context, error) in
           
            self?.viewLoader?.hideScreenActivityIndicator(containerView: (self?.view)!)
            
            if (success) {
                
                // Render UI
                self?.renderUI()
                
            } else {
                
                // Show refresh button when error happens
                // ...
            }
        })
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let list = self.model?.images?.list {
        
            return list.count
            
        } else {
            
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCell.reuseIdentifier,
            for: indexPath
            ) as! HomeCell
        cell.delegate = self
        
        let image = self.model?.images?.list?[(indexPath as NSIndexPath).row]
        cell.render(withEntity: image!)
        
        return cell
    }
    
    /*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        return self.collectionViewCellSize;
    }*/
    
    /*- (CGSize)collectionViewCellSize {
    
        // Override in child classes
        return CGSizeZero;
    }*/
    
    // MARK: HomeCellDelegate
    
    func didPressedWithImage(image: ImageEntityProtocol) {
        
        /*UIViewController *viewController = (UIViewController *)[self.viewControllerFactory photoDetailsViewControllerWithContext:image];
        [self.navigationController pushViewController:viewController animated:YES];*/
    }    
}
