//
//  Array+Grouping.swift
//  MyHappyGrowth
//
//  Created by Gytenis Mikulenas on 27/12/16.
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

/* Groups and sorts array
    Usage example:

class Item {
    
    var section: String
    var title: String?
    
    init(section: String, title: String) {
        
        self.section = section
        self.title = title
    }
    
    var description: String {
        
        return "\(title!)"
    }
}

let item1 = Item(section: "lunch", title: "5")
let item2 = Item(section: "dinner", title: "4")
let item3 = Item(section: "lunch", title: "3")
let item4 = Item(section: "dinner", title: "2")
let item5 = Item(section: "dinner", title: "1")

let array = [item1, item2, item3, item4, item5]

let result = array.group(groupBlock: {return $0.section}, sortBlock: {
    
    let t1 = $0.title ?? "0" // Distant past
    let t2 = $1.title ?? "0" // Distant past
    //return t1.localizedCaseInsensitiveCompare(t2) == ComparisonResult.orderedAscending
    return t1.compare(t2) == ComparisonResult.orderedAscending
})

 // The function will return Dictionary<String, Array< Item >>
 
*/

/* Another example with sorting by two String properties:
 
 self.data = list.group(groupBlock: {return $0.dateString}, sortBlock:
 {
    let t1 = $0.dateString + " " + $0.timeString
    let t2 = $1.dateString + " " + $1.timeString
 
    return t1.compare(t2) == ComparisonResult.orderedAscending
 }
 )
*/

public extension Array {
 
    func group<U : Hashable>(groupBlock: (Iterator.Element) -> U, sortBlock: (Element, Element) -> Bool) -> Array<SectionEntity> {
    
        var result: Array<SectionEntity> = Array<SectionEntity>()
        
        // Sort
        let sortedArray = self.sorted(by: sortBlock)
        
        // Group
        let groupedDict = sortedArray._group(groupBlock)
        
        let key = groupedDict.keys.first!
        
        if key is Date {
            
            // Wrap into sorted SectionEntity list
            var allKeys: Array<Date> = Array<Date>()
            for (key, _) in groupedDict {
            
                allKeys.append(key as! Date)
            }
            
            let sortedAllKeys = allKeys.sorted()
            
            for key in sortedAllKeys {
                
                let section = SectionEntity()
                section.title = key.stringFromDate()
                section.rows = groupedDict[key as! U]
                
                result.append(section)
            }
            
        } else if key is String {
            
            // Wrap into sorted SectionEntity list
            var allKeys: Array<String> = Array<String>()
            for (key, _) in groupedDict {
                
                allKeys.append(key as! String)
            }
            
            let sortedAllKeys = allKeys.sorted()
            
            var result: Array<SectionEntity> = Array<SectionEntity>()
            
            for key in sortedAllKeys {
                
                let section = SectionEntity()
                section.title = key
                section.rows = groupedDict[key as! U]
                
                result.append(section)
            }
        }
        
        // Return
        return result
    }
    
    /*func allKeys<T>(dict: Dictionary <String, T>)->Array<String> {
        
        return Array(dict.keys)
    }*/
}

public extension Sequence {
    
    // Internal
    func _group<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = key(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
}

public class SectionEntity: CustomStringConvertible {
    
    var title: String!
    var rows: Array<Any>!
    var context: Any?
    
    public var description: String {
        
        return "title: \(title), context: \(context), rows: \(rows)"
    }
}
