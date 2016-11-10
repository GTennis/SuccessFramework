//
//  CacheManager.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 08/11/16.
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

let kDataCacheFilename = "dataCache"
let kDataCacheImageDirectory = "CachedImages"

class CacheManager: CacheManagerProtocol {
    
    var updateDate: Date? {
        
        get {
         
            return _updateDate
        }
    }
        
    
    required init() {
        
        self.synchronizeCache(callback: { [weak self] in
            
            // Check and load if there's a cache file already
            self?._cache = self?.loadExistingCache()
            
            if (self?._cache == nil) {
                
                self?._cache = self?.loadDefaultCache()
            }
        })
    }
    
    func clearCache(callback: @escaping SimpleCallback) {
        
        synchronized(obj: _cache as AnyObject) { [weak self] in
        
            self?.deleteCacheFile()
            
            self?._updateDate = nil
            self?._cache = nil
            
            callback()
        }
    }
    
    func updateCache(newData: Array<ImageEntityProtocol>, callback: @escaping Callback) {
        
        synchronized(obj: _cache as AnyObject) { [weak self] in
            
            let cachePath: String? = self?.cachePath(withFile: kDataCacheFilename)
            var isSuccessfulSave = false
            var error: ErrorEntity?
            
            if let cachePath = cachePath {
                
                isSuccessfulSave = NSKeyedArchiver.archiveRootObject(newData, toFile: cachePath)
                error = ErrorEntity(code: 0, message: "Unable to update cache")
                
            } else {
                
                error = ErrorEntity(code: 0, message: "Unable to update cache: cache path not found")
                DDLogError(log: (error?.message)!)
            }
            
            callback(isSuccessfulSave, newData, nil, error)
        }
    }
    
    func imageList(callback: @escaping (_ success: Bool, _ result: Array<ImageEntityProtocol>?, _ error: ErrorEntity?)->Void) {
        
        self.synchronizeCache(callback: { [weak self] in
            
            callback(true, self?._cache, nil)
        })
    }
    
    func image(imageTitle: String, callback: @escaping (_ success: Bool, _ result: ImageEntityProtocol?, _ error: ErrorEntity?)->Void) {
        
        self.synchronizeCache(callback: { [weak self] in
            
            var result:ImageEntityProtocol?
            
            if let cache = self?._cache {
                
                result = cache.filter{ $0.title!.isEqual(imageTitle) }.first
            }
            
            callback(true, result, nil)
        })
    }
    
    func containsImage(imageTitle: String, callback: @escaping (_ success: Bool, _ error: ErrorEntity?)->Void) {
        
        self.synchronizeCache(callback: { [weak self] in
            
            if let cache = self?._cache {
                
                var result: Bool = false
                
                if cache.contains(where: { $0.title!.isEqual(imageTitle) }) {
                    
                    result = true
                }
                
                callback(result, nil)
            }
        })
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _updateDate: Date?
    internal var _cache: Array<ImageEntityProtocol>?
    
    internal func synchronizeCache(callback:() -> ()) {
        
        if _cache == nil {
        
            // Access to dataCache is synchronized in order to avoid resource race and read errors
            objc_sync_enter(_cache)
            
            // Check and load if there's a cache file already
            _cache = self.loadExistingCache()
            
            // If cache was not
            if (_cache == nil) {
                
                _cache = self.loadDefaultCache()
            }
            
            objc_sync_exit(_cache)
            
            callback()
        }
    }
    
    internal func loadExistingCache()->Array<ImageEntityProtocol>? {
        
        var result: Array<ImageEntityProtocol>?
        
        let cachePath: String = self.cachePath(withFile: kDataCacheFilename)!
        let fileMgr = FileManager.default
        
        if fileMgr.fileExists(atPath: cachePath) {
            
            let list: Array<DataEntity>? =
                NSKeyedUnarchiver.unarchiveObject(withFile: cachePath)
                    as? Array<DataEntity>
            
            if let list = list {
                
                result = DataEntity.entities(images: list) as! Array<ImageEntityProtocol>?
            }
        }
        
        return result
    }
    
    internal func loadDefaultCache()->Array<ImageEntity>? {
        
        let filePath = Bundle.main.path(forResource: "imageList", ofType: "json")
        
        do {
            
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
            let dict = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
            
            return ImageListEntity.init(dict: dict as! Dictionary<String, Any>).list as! Array<ImageEntity>?
            
        } catch (let error) {
            
            DDLogError(log: "Cannot read file: " + error.localizedDescription)
            return nil
        }
    }
    
    internal func deleteCacheFile() {
        
        let cachePath: String? = self.cachePath(withFile: kDataCacheFilename)
        let fileMgr = FileManager.default
        
        if let cachePath = cachePath {
            
            do {
            	try fileMgr.removeItem(atPath: cachePath)
            }
            catch (let error) {
            
                DDLogError(log: "Unable to delete cache file: " + error.localizedDescription)
            }
            
        } else {
            
            DDLogError(log: "Unable to delete cache file: cache file was not found")
        }
    }

    
    internal func cachePath(withFile: String)->String? {
        
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let cachePath = dir?.appendingPathComponent(withFile)
        
        return cachePath?.absoluteString
    }
}
