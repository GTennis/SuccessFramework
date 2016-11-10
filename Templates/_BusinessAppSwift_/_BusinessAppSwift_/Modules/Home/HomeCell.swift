//
//  HomeCell.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 12/11/16.
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

protocol HomeCellDelegate: AnyObject {
    
    func didPressedWithImage(image: ImageEntityProtocol)
}

class HomeCell: UICollectionViewCell, GenericCellProtocol {
    
    //class var ReuseIdentifier: String { return "org.alamofire.identifier.\(type(of: self))" }
    class var reuseIdentifier: String {
        
        get {
            
            return "HomeCell"
        }
    }
    
    weak var delegate:HomeCellDelegate?
    
    @IBOutlet weak var titleLabel: NormalLabel!
    @IBOutlet weak var authorLabel: NormalLabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.af_cancelImageRequest()
        imageView.layer.removeAllAnimations()
        imageView.image = nil
    }
    
    func render<T>(withEntity: T) {
    
        // Store object
        _image = withEntity as! ImageEntityProtocol
        
        // Render UI
        self.titleLabel.text = _image.title
        //self.authorLabel.text = object.author
        
        if let imageUrl = _image.urlString {
            
            downloadImage(imageView: self.imageView, activityIndicator: self.activityIndicatorView, urlString: imageUrl)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func cellPressed(_ sender: AnyObject) {
        
        self.delegate?.didPressedWithImage(image: self._image)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    internal var _image:ImageEntityProtocol!
}
