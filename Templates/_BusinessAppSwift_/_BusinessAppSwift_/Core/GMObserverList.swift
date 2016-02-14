//
//  GMObserverList.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 18/10/2016.
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

class GMObserverList: ObserverListProtocol {

    // MARK: ObserverListProtocol
    
    required init(observedSubject: AnyObject) {
        
        _observedSubject = observedSubject
    }
    
    // Observer handling
    func observers() -> Array <AnyObject>? {
        
        //let weakObserverList: Array <WeakObserver> = Array(_observers?.values)
        var result: Array<AnyObject>? = nil
        
        for weakObserver in (_observers?.values)! {
            
            if (result == nil) {
                
                result = Array()
            }
            
            result?.append(weakObserver)
        }
        
        return result
    }
    
    func add(observer: AnyObject, notificationName:String, callback: @escaping Callback, context: Any?) {
    
        var contains: Bool = false
        let key = self.key(observer: observer, notificationName: notificationName)
        
        if (_observers == nil) {
            
            // Create instance of non-retaining array for observers (in order to prevent retain cycles):
            
            //_observers = CFBridgingRelease(CFArrayCreateMutable(NULL, 0, NULL)); // Fixing leak in ARC
            _observers = Dictionary()
            
            contains = false;
            
        } else {
            
            if (_observers?[key]) != nil {
                
                contains = true
            }
        }
        
        // Add if not added yet:
        if (!contains) {
            
            // Store observer callback
            let wrappedObserver: WeakObserver = self.wrappedWeakObserver(observer: observer, notificationName: notificationName, callback: callback, context: context)
                
            _observers?[key] = wrappedObserver
        }
    }
    
    func remove(observer: AnyObject, notificationName: String) {
        
        let key = self.key(observer: observer, notificationName: notificationName)
        
        _ = _observers?.removeValue(forKey: key)
    }
    
    func remove(observer: AnyObject) {        
        
        let observerClassName: String = className(object: observer)
        
        for key in (_observers?.keys)! {
            
            if key.contains(observerClassName) {
                
                _ = _observers?.removeValue(forKey: key)
            }
        }
    }
    
    func contains(observer: AnyObject, notificationName: String)->Bool {
        
        let key = self.key(observer: observer, notificationName: notificationName)
        
        var result: Bool = false
        
        if (_observers?[key]) != nil {
            
            result = true
        }
        
        return result
    }
    
    // Broadcasting to observers
    
    func notifyObservers(notificationName: String) {
    
        if (_observers == nil) {
        
            return;
        }
        
        if (self.isNotEmpty()) {
            
            DDLogDebug(log: "GMObserverList: Will notify observers: " + notificationName)
        }
        
        var weakObserver: WeakObserver
        
        for key in (_observers?.keys)! {
            
            if key.contains(notificationName) {
                
                weakObserver = (_observers?[key])!
                
                if let callback = weakObserver.callback {
                
                    callback(true, nil, nil, nil)
                }
            }
        }
    }
    
    func notifyObservers(notificationName: String, context: Any?) {
        
        if (_observers == nil) {
            
            return;
        }
        
        if (self.isNotEmpty()) {
            
            DDLogDebug(log: "GMObserverList: Will notify observers: " + notificationName)
        }
        
        var weakObserver: WeakObserver
        
        for key in (_observers?.keys)! {
            
            if key.contains(notificationName) {
                
                weakObserver = (_observers?[key])!
                
                if let callback = weakObserver.callback {
                    
                    callback(true, nil, context, nil)
                }
            }
        }
    }
    
    func notifyObservers(notificationName: String, context: Any?, error: ErrorEntity?) {
        
        if (_observers == nil) {
            
            return;
        }
        
        if (self.isNotEmpty()) {
            
            DDLogDebug(log: "GMObserverList: Will notify observers: " + notificationName)
        }
        
        var weakObserver: WeakObserver
        
        for key in (_observers?.keys)! {
            
            if key.contains(notificationName) {
                
                weakObserver = (_observers?[key])!
                
                if let callback = weakObserver.callback {
                    
                    callback(true, nil, context, error)
                }
            }
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal weak var _observedSubject: AnyObject!
    //var _observers: NSHashTable <AnyObject>?
    fileprivate var _observers: Dictionary <String, WeakObserver>?
    //var _observerCallbacks: Dictionary <String, Callback>
    
    internal func isNotEmpty() -> Bool {
        
        var result: Bool = false;
        
        if let observers = _observers {
            
            let keys: Array <String> = allKeys(dict: observers)
        
            if (keys.count > 0) {
                
               result = true
            }
        }
        
        return result
    }
    
    internal func key(observer:AnyObject, notificationName: String)->String {
    
        let observerClassName: String = className(object: observer)
        let key = observerClassName + notificationName
        
        return key;
    }
    
    fileprivate func wrappedWeakObserver(observer: AnyObject, notificationName:String, callback: @escaping Callback, context: Any?) -> WeakObserver {
        
        let wrappedObserver = WeakObserver.init(observer: observer, context: context, callback: callback)
        
        return wrappedObserver
    }
}

internal class WeakObserver {
    
    weak var observer : AnyObject?
    var context : Any?
    var callback: Callback?
    
    init (observer: AnyObject?, context: Any?, callback: Callback?) {
        
        self.observer = observer
        self.context = context
        self.callback = callback
    }
}
