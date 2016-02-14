//
//  SendEmailCommand.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 23/10/16.
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
import MessageUI

let kSendEmailCommandNotConfiguredAlertTextKey = "SendEmailCommandNotConfiguredAlertTextKey"

class SendEmailCommand: NSObject, CommandProtocol, MFMailComposeViewControllerDelegate {

    // Use if message is created later than object itself
    var message: String?
    
    required init(viewController: UIViewController, subject: String, message: String, recipients: Array<String>, attachments: Array<UIImage>) {
        
        _viewContoller = viewController
        _subject = subject
        self.message = message
        _recipients = recipients
        _attachments = attachments
    }
    
    // MARK: CommandProtocol
    
    func canExecute(error: inout ErrorEntity) -> Bool {
        
        if (MFMailComposeViewController.canSendMail()) {
            
            return true
            
        } else {
        
            error = ErrorEntity.init(code: 0, message: localizedString(key: kSendEmailCommandNotConfiguredAlertTextKey))
            
            return false            
        }
    }
    
    func executeWithCallback(callback: Callback?) {
        
        var error: ErrorEntity = ErrorEntity.init(code: nil, message: nil)
        
        _callback = callback
        
        if (self.canExecute(error: &error)) {
            
            _mailComposerViewController = MFMailComposeViewController.init()
            
            // Add subject if passed
            if ((_subject?.characters.count)! > 0) {
                
                _mailComposerViewController?.setSubject(_subject!)
            }
            
            // Add message if passed
            if ((self.message?.characters.count)! > 0) {
                
                _mailComposerViewController?.setMessageBody(self.message!, isHTML: false)
            }
            
            // Add images
            self.addToMailComposer(mailComposer: _mailComposerViewController!, attachments: _attachments!)
            
            // Add recipients if passed
            if ((_recipients?.count)! > 0) {
                
                _mailComposerViewController?.setToRecipients(_recipients)
            }
            
            // Assign delegate
            _mailComposerViewController?.mailComposeDelegate = self
            
            // Show send email
            _viewContoller?.present(_mailComposerViewController!, animated: true, completion: {
                // ...
            })
        }
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        _mailComposerViewController?.dismiss(animated: true, completion: nil)
        
        if ((_callback) != nil) {
            
            if let error = error {
            
                let errorEntity: ErrorEntity = ErrorEntity.init(code: error._code, message:error.localizedDescription)
                
                _callback!((result == MFMailComposeResult.sent) ? true : false, nil, nil, errorEntity);
                
            } else {
                
                _callback!((result == MFMailComposeResult.sent) ? true : false, nil, nil, nil);
            }
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _viewContoller: UIViewController?
    internal var _mailComposerViewController: MFMailComposeViewController?
    
    internal var _subject: String?
    internal var _recipients: Array <String>?
    internal var _attachments: Array <UIImage>?
    internal var _callback: Callback?
    
    internal func addToMailComposer(mailComposer: MFMailComposeViewController, attachments: Array<UIImage>) {
    
        var i: Int = 1
    
        for attachment in attachments {
            
            //if (attachment is UIImage) {
                
                let jpegData: Data = UIImageJPEGRepresentation(attachment, 1.0)!
                var fileName: String = "image" + stringify(object: i)
                fileName = fileName + ".jpeg"
                
                mailComposer.addAttachmentData(jpegData, mimeType:"image/jpeg", fileName:fileName)
            //}
        }
    
        i = i + 1
    }
}
