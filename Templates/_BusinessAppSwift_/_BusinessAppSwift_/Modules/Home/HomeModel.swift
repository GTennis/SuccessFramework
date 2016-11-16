//
//  HomeModel.swift
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

class HomeModel: BaseModel {

    var images: ImageListEntity?
    var cacheManager: CacheManagerProtocol?
    
    override func willStartModelLoading(callback: @escaping Callback) {
        
        let operation: NetworkOperationProtocol = self.networkOperationFactory.imageListNetworkOperation(context: nil);
        operation.perform(callback: callback)
        
        /*self.cacheManager = CacheManager()
        self.cacheManager?.imageList(callback: { (success, result, error) in

            let imageListEntity = ImageListEntity()
            imageListEntity.list = result
            callback(true, imageListEntity, nil, nil)
        })*/
    }
    
    override func didFinishModelLoading(data: Any?, error: ErrorEntity?) {
        
        self.images = data as? ImageListEntity
        
        // Example of sorting
        
        self.images?.list?.sort {
            
            // $0.timeString?.localizedCaseInsensitiveCompare($1.timeString!) == ComparisonResult.orderedAscending
            
            let t1 = $0.title ?? "0" // Distant past
            let t2 = $1.title ?? "0" // Distant past
            //return t1.localizedCaseInsensitiveCompare(t2) == ComparisonResult.orderedAscending
            return t1.compare(t2) == ComparisonResult.orderedAscending
        }
    }
}
