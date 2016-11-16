//
//  CacheManagerMock.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 16/11/16.
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

import Foundation
import XCTest
@testable import _BusinessAppSwift_

class CacheManagerMock: CacheManagerProtocol {
    
    var updateDate: Date?
    
    required init() {
        
        
    }
    
    // Removes cache from memory and deletes cache file
    func clearCache(callback: @escaping SimpleCallback) {
        
        
    }
    
    // Override cache with new data
    func updateCache(newData: Array<ImageEntityProtocol>, callback: @escaping Callback) {
        
        callback(true, nil, nil, nil)
    }
    
    // Retrieve cached data
    func imageList(callback: @escaping (_ success: Bool, _ result: Array<ImageEntityProtocol>?, _ error: ErrorEntity?)->Void) {
        
        
    }
    
    func image(imageTitle: String, callback: @escaping (_ success: Bool, _ result: ImageEntityProtocol?, _ error: ErrorEntity?)->Void) {
        
        
    }
    
    func containsImage(imageTitle: String, callback: @escaping (_ success: Bool, _ error: ErrorEntity?)->Void) {
        
        
    }
}
