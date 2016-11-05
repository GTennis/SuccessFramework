//
//  ReachabilityManager.swift
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
import Alamofire

class ReachabilityManager: ReachabilityManagerProtocol {

    deinit {
        
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self)
        
        _manager?.stopListening()
    }
    
    // MARK: ReachabilityManagerProtocol
    
    init() {
        
        let center: NotificationCenter = NotificationCenter.default
        
        // Listen for app state changes
        center.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { (notification) in
            
             if (self.isInternetOn() && self.isAppActive()) {
             
                self.notifyObserversWithApplicationDidBecomeActive()
             }
        }
        center.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { [weak self] (notification) in
            
            self?.notifyObserversWithApplicationDidBecomeInactive()
        }
        
        
        _manager?.listener = { [weak self] status in
            
            //DDLogDebug(log: "Network Status Changed: \(status)")
            
            if (!(self?.isInternetOn())!) {
                
                DDLogDebug(log: "ReachabilityManager: Internet become off")
                self?.notifyObserversWithInternetDidBecomeOff()
                
            } else {
                
                DDLogDebug(log:"ReachabilityManager: Internet become on")
                if (self?.isAppActive())! {
                    
                    self?.notifyObserversWithInternetDidBecomeOn()
                }
            }
        }
        _manager?.startListening()
    }
    
    func isInternetOn() -> Bool {
     
        let unknown = (_manager?.networkReachabilityStatus == NetworkReachabilityManager.NetworkReachabilityStatus.unknown)
        let notReachable = (_manager?.networkReachabilityStatus == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable)
        
        return (unknown || notReachable) ? false : true
    }
    
    func isAppActive() -> Bool {
        
        let application: UIApplication = UIApplication.shared
        return (application.applicationState == UIApplicationState.active) ? true : false
    }
    
    func addServiceObserver(observer: ReachabilityManagerObserver, notificationType: ReachabilityManagerNotificationType, callback: @escaping Callback, context: Any?) {
        
        _observers.add(observer: observer as AnyObject, notificationName: notificationType.rawValue, callback: callback, context: context)
    }
    
    func removeServiceObserver(observer: ReachabilityManagerObserver, notificationType: ReachabilityManagerNotificationType) {
        
        _observers.remove(observer: observer as AnyObject, notificationName: notificationType.rawValue)
    }
    
    func removeServiceObserver(observer: ReachabilityManagerObserver) {
        
        _observers.remove(observer: observer as AnyObject)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    // http://mikebuss.com/2014/06/22/lazy-initialization-swift/
    internal lazy var _observers: ObserverListProtocol = SFObserverList.init(observedSubject: self)
    
    internal let _manager = NetworkReachabilityManager(host: "www.apple.com")
    
    internal func notifyObserversWithApplicationDidBecomeActive() {
        
        _observers.notifyObservers(notificationName: ReachabilityManagerNotificationType.applicationDidBecomeActive.rawValue)
    }
    
    internal func notifyObserversWithApplicationDidBecomeInactive() {
        
        _observers.notifyObservers(notificationName: ReachabilityManagerNotificationType.applicationDidBecomeInactive.rawValue)
    }
    
    internal func notifyObserversWithInternetDidBecomeOn() {
        
        _observers.notifyObservers(notificationName: ReachabilityManagerNotificationType.internetDidBecomeOn.rawValue)
    }
    
    internal func notifyObserversWithInternetDidBecomeOff() {
        
        _observers.notifyObservers(notificationName: ReachabilityManagerNotificationType.internetDidBecomeOff.rawValue)
    }
}
