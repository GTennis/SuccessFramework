//
//  AnalyticsManager.swift
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

let kGoogleAnalyticsDevelopmentTrackerId = "DevTrackingId"
let kGoogleAnalyticsProductionTrackerId = "ProdTrackingId"
let kGoogleAnalyticsDataSendingInterval = 120.0 // 0.0

class AnalyticsManager: AnalyticsManagerProtocol {

    init() {

        // ...
    }
    
    // MARK: AnalyticsManagerProtocol
    
    // About sessions: 
    // https://developers.google.com/analytics/devguides/collection/ios/v3/sessions
    func startSession() {
        
        DDLogVerbose(log: "GA: starting session...")
        
        let builder = GAIDictionaryBuilder.createScreenView()
        self._defaultTracker.set(kGAISessionControl, value: "start")
        self._defaultTracker.set(kGAIScreenName, value: "NewAppSession")
        self._defaultTracker.send(builder!.build() as [NSObject : AnyObject])
    }
    
    func endSession() {
        
        DDLogVerbose(log: "GA: ending session...")
        
        self._defaultTracker.set(kGAISessionControl, value: "end")
    }
    
    func log(screenName: String) {
        
        self._defaultTracker.set(kGAIScreenName, value: screenName)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        self._defaultTracker.send(builder!.build() as [NSObject : AnyObject])
    }
    
    func logEvent(category: String, action: String, title: String, value: Double?) {
        
        DDLogVerbose(log: "GA action log: " + category + action + title + ((value == nil) ? "" : stringify(object: value!)))
        
        if let unwrappedValue = value {
            
            self._defaultTracker.send(GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: title, value: NSNumber(value:unwrappedValue)).build() as [NSObject : AnyObject])
            
        } else {
            
            self._defaultTracker.send(GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: title, value: nil).build() as [NSObject : AnyObject])
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK
    
    internal lazy var _defaultTracker = { () -> GAITracker in 
        
        // [START tracker_swift]
        
        var trackingId: String?
        
        #if DEBUG
            
            trackingId = kGoogleAnalyticsDevelopmentTrackerId
            
        #else
            
            trackingId = kGoogleAnalyticsProductionTrackerId
            
        #endif
        
        GAI.sharedInstance().tracker(withTrackingId: trackingId!)
        GAI.sharedInstance().dispatchInterval = kGoogleAnalyticsDataSendingInterval
        
        // Optional: configure GAI options.
        //let gai = GAI.sharedInstance()
        //gai!.trackUncaughtExceptions = true  // report uncaught exceptions
        //gai!.logger.logLevel = GAILogLevel.verbose  // remove before app release
        // [END tracker_swift]
        
        return GAI.sharedInstance().defaultTracker!
    }()
}
