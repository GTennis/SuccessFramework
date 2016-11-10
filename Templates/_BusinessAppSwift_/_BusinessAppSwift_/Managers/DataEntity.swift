//
//  DataEntity.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 10/11/16.
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

let kDataEntityIdKey: String = "entityId"
let kDataEntityTitleKey: String = "title"

class DataEntity: NSObject {

    var urlString: NSString?
    var title: NSString?
    
    static func serializableEntities(images: ImageListEntity) -> NSArray? {
        
        var entities: NSArray?
        
        if let list = images.list {

            if list.count > 0 {
                
                entities = NSArray()
            }
            
            var entity: DataEntity?
            
            for item in list {
                
                entity = DataEntity()
                entity?.urlString = item.urlString as NSString?
                entity?.title = item.title as NSString?
                
                entities?.adding(entity)
            }
        }
        
        return entities
    }
    
    static func entities(images: [DataEntity]?) -> ImageListEntityProtocol? {
        
        var entities: ImageListEntityProtocol?
        
        if let images = images {
            
            if images.count > 0 {
                
                entities = ImageListEntity()
                entities!.list = Array()
                
                var entity: ImageEntityProtocol?
                
                for item in images {
                    
                    entity = ImageEntity()
                    entity!.urlString = item.urlString as String?
                    entity!.title = item.title as String?
                    
                    entities!.list?.append(entity!)
                }
            }
        }
        
        return entities
    }
}
