//
//  ConstFunctions.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 25/10/2016.
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

// Handy functions
func className(object: AnyObject)->String {
    
    return String(describing: type(of: object))
}

func classNameFromClassType(classType: AnyClass)->String {
    
    return String(describing: classType)
}

func allKeys<T>(dict: Dictionary <String, T>)->Array<String> {
    
    return Array(dict.keys)
}

func allValues<T>(dict: Dictionary <String, T>)->Array<T> {
    
    return Array(dict.values)
}

func isEmpty<T>(dict: Dictionary <String, T>)->Bool {
    
    // Dictionaries Use the Boolean isEmpty property as a shortcut for checking whether the count property is equal to 0:
    return dict.isEmpty
}

func stringify<T>(object: T) -> String {
    
    var result: String = ""
    
    if (object is Date) {
 
        result = String.init(describing:(object as! Date))
        
    } else if (object is Bool) {
        
        result = String(object as! Bool)
        
    } else if (object is Int) {
        
        result = String(object as! Int)
        
    } else if (object is Error) {
        
        result = String(describing: object as! Error)
        
    } else {
        
        result = String(describing: object)
    }
    
    return result
}

// Other handful tips

// Singleton
//static var sharedInstance: LogManagerProtocol = LogManager()

// Turning off (or on) unwanted system logs in Xcode console
// http://stackoverflow.com/a/39461256/597292

// String utils
// http://useyourloaf.com/blog/swift-string-cheat-sheet/

/*
let digits = "0123456789"
let tail = String(digits.characters.dropFirst())  // "123456789"
let less = String(digits.characters.dropFirst(3)) // "3456789"
let head = String(digits.characters.dropLast(3))  // "0123456"

let prefix = String(digits.characters.prefix(2))  // "01"
let suffix = String(digits.characters.suffix(2))  // "89"

let index4 = digits.index(digits.startIndex, offsetBy: 4)
let thru4 = String(digits.characters.prefix(through: index4))  // "01234"
let upTo4 = String(digits.characters.prefix(upTo: index4))     // "0123"
let from4 = String(digits.characters.suffix(from: index4))     // "456789"
*/

// Simple Error handling

/*do {
  
   try keychain.set("01234567-89ab-cdef-0123-456789abcdef", key: "kishikawakatsumi")
}
catch let error {
 
   print(error)
 
}*/

/*enum ErrorType : Error {
 
 case GenericError(description:String)
 }*/

// Example usage
/*
 do {
 
 try self.keychainManager.setAuthentificationToken(token: nil)
 
 callback(true, nil, nil, nil)
 
 } catch ErrorType.GenericError(let description) {
 
 callback(false, nil, nil, nil)
 
 //throw ErrorType.GenericError(description: description)
 
 } catch {
 
 //throw ErrorType.GenericError(description: "Unable to clear keychain")
 
 callback(false, nil, nil, nil)
 
 //throw ErrorType.GenericError(description: description)
 }*/

// Supress unused value warning
// _ = _observers?.removeValue(forKey: key)
