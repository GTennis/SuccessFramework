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

class HomeViewController: UIViewController, GenericViewControllerProtocol, UICollectionViewDataSource, UICollectionViewDelegate, HomeListItemViewDelegate {

    var context: Any?
    var viewLoader: ViewLoaderProtocol?
    var crashManager: CrashManagerProtocol?
    var analyticsManager: AnalyticsManagerProtocol?
    var messageBarManager: MessageBarManagerProtocol?
    var viewControllerFactory: ViewControllerFactoryProtocol?
    var reachabilityManager: ReachabilityManagerProtocol?
    var localizationManager: LocalizationManagerProtocol?
    var userManager: UserManagerProtocol?
    @IBOutlet weak var modalContainerView4Ipad: UIView?
    
    var model: HomeModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    deinit {
        
        self.removeFromAllFromObserving()
    }
    
    /*required init() {
     
     super.init(nibName: nil, bundle: nil);
     }
     
     required init(coder aDecoder: NSCoder) {
     
     super.init(coder: aDecoder)!
     }*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.commonViewDidLoad()
        
        self.prepareUI()
        self.loadModel()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.commonViewWillAppear(animated)
        
        // Log user behaviour
        self.analyticsManager?.log(screenName: kAnalyticsManagerScreenHome)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.commonViewWillDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        self.commonDidReceiveMemoryWarning()
    }
    
    // MARK: GenericViewControllerProtocol
    
    func prepareUI() {
        
        // ...
        //self.collectionView.register(HomeListItemView.self, forCellWithReuseIdentifier: HomeListItemView.ReuseIdentifier)
        
        // Set title
        self.title = localizedString(key: kHomeViewControllerTitleKey)
    }
    
    func renderUI() {
        
        // Reload
        self.collectionView.reloadData()
    }
    
    func loadModel() {
        
        self.renderUI()
        
        
        self.showScreenActivityIndicator()
        
        
        self.model?.loadData(callback: {[weak self] (success, result, context, error) in
           
            self?.hideScreenActivityIndicator()
            
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
        
        if let images = self.model?.images {
        
            return images.list.count
            
        } else {
            
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeListItemView.ReuseIdentifier,
            for: indexPath
            ) as! HomeListItemView
        cell.delegate = self
        
        let image = self.model?.images?.list[(indexPath as NSIndexPath).row]
        cell.render(object: image!)
        
        return cell
    }
    
    /*- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        return self.collectionViewCellSize;
    }*/
    
    /*- (CGSize)collectionViewCellSize {
    
        // Override in child classes
        return CGSizeZero;
    }*/
    
    // MARK: HomeListItemViewDelegate
    
    func didPressedWithImage(image: ImageEntityProtocol) {
        
        /*UIViewController *viewController = (UIViewController *)[self.viewControllerFactory photoDetailsViewControllerWithContext:image];
        [self.navigationController pushViewController:viewController animated:YES];*/
    }    
}
