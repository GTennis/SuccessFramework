//
//  MessageBarManager.swift
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
//import TWMessageBarManager
import SwiftMessageBar
import SCLAlertView

let kMessageBarManagerDefaultDuration: Double = 3.0

class MessageBarManager: MessageBarManagerProtocol {
    
    // MARK: MessageBarManagerProtocol
    
    init() {
        
        // ...
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType) {
        
        let convertedMessageType: SwiftMessageBar.MessageType = self._convertedMessageType(type: type)
        self._showMessage(title: title, description: description, type: convertedMessageType, duration: kMessageBarManagerDefaultDuration, callback: nil)
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType, duration: Double) {
        
        let convertedMessageType: SwiftMessageBar.MessageType = self._convertedMessageType(type: type)
        self._showMessage(title: title, description: description, type: convertedMessageType, duration: duration, callback: nil)
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType, callback: SimpleCallback?) {
        
        let convertedMessageType: SwiftMessageBar.MessageType = self._convertedMessageType(type: type)
        self._showMessage(title: title, description: description, type: convertedMessageType, duration: kMessageBarManagerDefaultDuration, callback: callback)
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType, duration: Double, callback: SimpleCallback?) {
        
        let convertedMessageType: SwiftMessageBar.MessageType = self._convertedMessageType(type: type)
        self._showMessage(title: title, description: description, type: convertedMessageType, duration: duration, callback: callback)
    }
    
    func dismissAll(animated:Bool) {
        
        if let id = self._uuid {
            self._messageBarManager.cancelWithId(id)
            self._uuid = nil
        }
    }
    
    func showAlertOkWithTitle(title: String?, description: String?, okTitle: String, okCallback: SimpleCallback?) {
        
        //******* Fancy Custom Alert view *******//
        
        // Styles
        // SCLAlertViewStyle {
        // case success, error, notice, warning, info, edit, wait }
        
        // Upon displaying, change/close view
        
        // Only works when viewWillAppear is called
        
        /*SCLAlertView().showTitle(
         title, // Title of view
         subTitle: description, // String of view
         duration: kMessageBarManagerDefaultDuration, // Duration to show before closing automatically, default: 0.0
         completeText: okTitle, // Optional button value, default: ""
         style: SCLAlertViewStyle.success, // Styles - see below.
         colorStyle: 0xA429FF,
         colorTextButton: 0xFFFFFF
         )
         
         let alertView = SCLAlertView()
         alertView.addButton("First Button") {
         
         okCallback(true, nil, nil, nil)
         }
         alertView.addButton("Second Button") {
         
         okCallback(true, nil, nil, nil)
         }
         
         alertView.showSuccess("Success", subTitle: "This alert view has buttons")*/
        
        //******* Default *******//
        
        let alertController: UIAlertController = UIAlertController(title: title, message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: UIAlertActionStyle.default) { (action) in
            
            okCallback?()
        }
        
        alertController.addAction(okAction)
        alertController.show()
    }
    
    func showAlertOkWithTitle(title: String?, description: String?, okTitle: String, okCallback: SimpleCallback?, cancelTitle: String, cancelCallback: SimpleCallback?) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: description, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: UIAlertActionStyle.default) { (action) in
            
            okCallback?()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default) { (action) in
            
            cancelCallback?()
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.show()
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal lazy var _messageBarManager: SwiftMessageBar = {
        
        let result = SwiftMessageBar.SharedMessageBar
        
        // Customize
        //let messageBarConfig = MessageBarConfig(errorColor: <#T##UIColor#>, successColor: <#T##UIColor#>, infoColor: <#T##UIColor#>, titleColor: <#T##UIColor#>, messageColor: <#T##UIColor#>, statusBarHidden: <#T##Bool#>, successIcon: <#T##UIImage?#>, infoIcon: <#T##UIImage?#>, errorIcon: <#T##UIImage?#>)
        //SwiftMessageBar.setSharedConfig(messageBarConfig)
        
        return result
    }()
    
    internal var _uuid: UUID?
    
    // Converts and maps public enum to private enum
    internal func _convertedMessageType(type: MessageBarMessageType) -> SwiftMessageBar.MessageType {
        
        var convertedType: SwiftMessageBar.MessageType = SwiftMessageBar.MessageType.info
        
        switch (type) {
            
        case MessageBarMessageType.error:
            
            convertedType = SwiftMessageBar.MessageType.error
            break;
            
        case MessageBarMessageType.success:
            
            convertedType = SwiftMessageBar.MessageType.success;
            break;
            
        case MessageBarMessageType.info:
            
            convertedType = SwiftMessageBar.MessageType.info
            break;
        }
        
        return convertedType;
    }
    
    func _showMessage(title: String?, description: String?, type: SwiftMessageBar.MessageType, duration: Double?, callback: SimpleCallback?) {
        
        let theDuration = (duration == nil) ? kMessageBarManagerDefaultDuration : duration!
        
        // dismiss flag defines if a message should be dismissed automatically after duration OR should it stay forever until user taps on it
        self._uuid = _messageBarManager.showMessageWithTitle(title, message: description, type: type, duration: theDuration, dismiss: true, callback: callback)
    }
}

/*class MessageBarManager: MessageBarManagerProtocol, TWMessageBarStyleSheet {

    // MARK: MessageBarManagerProtocol
    
    init() {
        
        // ...
    }
    
    // Add needed methods and wrap inside this class methods. Encapsulate and expose wrapped ones only.
    // https://github.com/terryworona/TWMessageBarManager
    func showMessage(title: String?, description: String?, type: MessageBarMessageType) {
        
        let convertedMessageType: TWMessageBarMessageType = self._convertedMessageType(type: type)
        self._showTWMessage(title: title, desription: description, type: convertedMessageType, duration: Float(kMessageBarManagerDefaultDuration))
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType, duration: Float) {
        
        let convertedMessageType: TWMessageBarMessageType = self._convertedMessageType(type: type)
        self._showTWMessage(title: title, desription: description, type: convertedMessageType, duration: duration)
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType, callback:  SimpleCallback?) {
        
        let convertedMessageType: TWMessageBarMessageType = self._convertedMessageType(type: type)
        self._messageBarManager.showMessage(withTitle: title, description: description, type: convertedMessageType, callback: callback)
    }
    
    func showMessage(title: String?, description: String?, type: MessageBarMessageType, duration: Float, callback: SimpleCallback?) {
        
        let convertedMessageType: TWMessageBarMessageType = self._convertedMessageType(type: type)
        self._messageBarManager.showMessage(withTitle: title, description: description, type: convertedMessageType, duration: CGFloat(duration), callback: callback)
    }
    
    func hideAll(animated:Bool) {
        
        _messageBarManager.hideAll(animated: animated)
    }
    
    // MARK: TWMessageBarStyleSheet
    
    func backgroundColor(for type: TWMessageBarMessageType) -> UIColor {
        
        if (type == TWMessageBarMessageType.success) {
            
            return kColorGreen
            
        } else if (type == TWMessageBarMessageType.error) {
            
            return kColorRed
        }
        
        return kColorGray
    }
    
    func strokeColor(for type: TWMessageBarMessageType) -> UIColor {
        
        if (type == TWMessageBarMessageType.success) {
            
            return kColorGreen
            
        } else if (type == TWMessageBarMessageType.error) {
            
            return kColorRed
        }
        
        return kColorGray
    }
    
    // Custom icons
    func iconImage(for type: TWMessageBarMessageType) -> UIImage {
        
        if (type == TWMessageBarMessageType.success) {
            
            return UIImage(named:"icon-success")!
            
        } else if (type == TWMessageBarMessageType.error) {
            
            return UIImage(named:"icon-error")!
        }
        
        return UIImage(named:"icon-info")!
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal lazy var _messageBarManager: TWMessageBarManager = {
    
        let result = TWMessageBarManager.sharedInstance()
        result.styleSheet = self
    }()
    
    // Converts and maps public enum to private enum
    internal func _convertedMessageType(type: MessageBarMessageType) -> TWMessageBarMessageType {
        
        var convertedType: TWMessageBarMessageType = TWMessageBarMessageType.info
        
        switch (type) {
            
        case MessageBarMessageType.error:
            
            convertedType = TWMessageBarMessageType.error
            break;
            
        case MessageBarMessageType.success:
            
            convertedType = TWMessageBarMessageType.success;
            break;
            
        case MessageBarMessageType.info:
            
            convertedType = TWMessageBarMessageType.info
            break;
        }
        
        return convertedType;
    }
    
    func _showTWMessage(title: String?, desription: String?, type: TWMessageBarMessageType, duration: Float) {
        
        _messageBarManager.showMessage(withTitle: title, description: desription, type: type, duration: CGFloat(duration))
    }
}*/
