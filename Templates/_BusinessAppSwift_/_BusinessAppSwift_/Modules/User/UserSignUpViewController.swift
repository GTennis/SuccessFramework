//
//  UserSignUpViewController.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 30/10/16.
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

let kUserSignUpViewControllerTitle = "SignUpTitle"

let kUserSignUpViewControllerEmailKey = "Email"
let kUserSignUpViewControllerPasswordKey = "Password"
let kUserSignUpViewControllerSalutationKey = "Salutation"
let kUserSignUpViewControllerFirstNameKey = "First name"
let kUserSignUpViewControllerLastNameKey = "Last name"
let kUserSignUpViewControllerAddressKey = "Address"
let kUserSignUpViewControllerAddressOptionalKey = "Address optional"
let kUserSignUpViewControllerZipCodeKey = "Zip"
let kUserSignUpViewControllerCountryCodeKey = "Country"
let kUserSignUpViewControllerStateKey = "State"
let kUserSignUpViewControllerCityKey = "City"
let kUserSignUpViewControllerPhoneKey = "Phone"

let kUserSignUpViewControllerIncorrectDataKey = "WrongDataWasProvided"

protocol UserSignUpViewControllerDelegate: AnyObject {

    func didFinishSignUp()
}

class UserSignUpViewController: BaseTableViewController, CountryPickerViewControllerDelegate {

    var model: SignUpModel?
    weak var delegate: UserSignUpViewControllerDelegate?
    
    @IBOutlet weak var salutationTextField: NormalTextField!
    @IBOutlet weak var firstNameTextField: NormalTextField!
    @IBOutlet weak var lastNameTextField: NormalTextField!
    @IBOutlet weak var addressTextField: NormalTextField!
    @IBOutlet weak var addressOptionalTextField: NormalTextField!
    @IBOutlet weak var countryCodeTextField: NormalTextField!
    @IBOutlet weak var stateCodeTextField: NormalTextField!
    @IBOutlet weak var cityTextField: NormalTextField!
    @IBOutlet weak var zipCodeTextField: NormalTextField!
    @IBOutlet weak var phoneTextField: NormalTextField!
    @IBOutlet weak var emailTextField: NormalTextField!
    @IBOutlet weak var passwordTextField: NormalTextField!
    @IBOutlet weak var privacyAndTermsTextView: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewLoader?.hideNavigationBar(viewController: self)
        
        self.prepareUI()
        self.loadModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Log user behaviour
        self.analyticsManager?.log(screenName: kAnalyticsManagerScreenUserSignUp)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    func clearTextFields() {
        
        self.model?.clearData()
        
        self.salutationTextField.text = nil;
        self.firstNameTextField.text = nil;
        self.lastNameTextField.text = nil;
        self.addressTextField.text = nil;
        self.addressOptionalTextField.text = nil;
        self.zipCodeTextField.text = nil;
        self.countryCodeTextField.text = nil;
        self.stateCodeTextField.text = nil;
        self.cityTextField.text = nil;
        self.phoneTextField.text = nil;
        self.emailTextField.text = nil;
        self.passwordTextField.text = nil;
        
        self.salutationTextField.becomeFirstResponder()
    }
    
    // MARK: IBActions
    
    @IBAction func countryPressed(_ sender: AnyObject) {
        
        let vcDelegate = self
        let vc = self.viewControllerFactory?.countryPickerViewController(context: vcDelegate)
        
        self.presentModal(viewController: vc!, animated: true)
    }
    
    @IBAction func signUpPressed(_ sender: AnyObject) {
        
        self.updateModel()
        let validationError: ErrorEntity? = self.model?.validateData()
        
        if let validationError = validationError {
    
            DDLogDebug(log: "SignUpPressedWithWrongData")
            
            // Mark required but empty fields in red
            self.applyStyleForMissingRequiredFields()
    
            self.messageBarManager?.showMessage(title: nil, description: validationError.message, type: MessageBarMessageType.error)
            
        } else {
    
            // Reset previous warnings from fields
            self.resetStyleForMissingRequiredFields()
    
            self.viewLoader?.showScreenActivityIndicator(containerView: self.view)
    
            self.model?.signUp(callback: {[weak self] (success, result, context, error) in
                
                self?.viewLoader?.hideScreenActivityIndicator(containerView: (self?.view)!)
                
                if (success) {
                    
                    DDLogDebug(log: "UserSignUpSuccess")
                    
                    self?.clearTextFields()
                    
                    self?.delegate?.didFinishSignUp()
                    
                } else {
                    
                    DDLogDebug(log: "UserSignUpFail: \(error?.message)")
                }
            })
        }
    }

    
    // MARK: GenericViewControllerProtocol
    
    override func prepareUI() {
        
        super.prepareUI()
        
        self.title = localizedString(key: kUserSignUpViewControllerTitle)
        
        self.setupTextFields()
        self.setupTappablePrivacyAndTermsTextView()
    }
    
    override func renderUI() {
        
        super.renderUI()
    }
    
    override func loadModel() {
        
        self.renderUI()
    }
    
    // MARK: KeyboardControlDelegate
    
    override func didPressGo() {
        
        self.signUpPressed(self.actionButton)
    }
    
    // MARK: CountryPickerViewControllerDelegate
    
    func didSelectCountry(countryCode: String) {
        
        self.countryCodeTextField.text = countryCode
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal func updateModel() {
        
        let user: UserEntity = UserEntity()
        
        user.salutation = self.salutationTextField.text
        user.firstName = self.firstNameTextField.text
        user.lastName = self.lastNameTextField.text
        user.address = self.addressTextField.text
        user.addressOptional = self.addressOptionalTextField.text
        user.zipCode = self.zipCodeTextField.text
        user.countryCode = self.countryCodeTextField.text
        user.stateCode = self.stateCodeTextField.text
        user.city = self.cityTextField.text
        user.phone = self.phoneTextField.text
        user.email = self.emailTextField.text
        user.password = self.passwordTextField.text
        
        self.model?.updateWithData(data: user)
    }
    
    // Add toolbar with previous and next buttons for navigating between input fields
    internal func setupTextFields() {

        // Add placeholders
        self.salutationTextField.placeholder = localizedString(key: kUserSignUpViewControllerSalutationKey)
        self.firstNameTextField.placeholder = localizedString(key: kUserSignUpViewControllerFirstNameKey)
        self.lastNameTextField.placeholder = localizedString(key: kUserSignUpViewControllerLastNameKey)
        self.addressTextField.placeholder = localizedString(key: kUserSignUpViewControllerAddressKey)
        self.addressOptionalTextField.placeholder = localizedString(key: kUserSignUpViewControllerAddressOptionalKey)
        self.zipCodeTextField.placeholder = localizedString(key: kUserSignUpViewControllerZipCodeKey)
        self.countryCodeTextField.placeholder = localizedString(key: kUserSignUpViewControllerCountryCodeKey)
        self.stateCodeTextField.placeholder = localizedString(key: kUserSignUpViewControllerStateKey)
        self.cityTextField.placeholder = localizedString(key: kUserSignUpViewControllerCityKey)
        self.phoneTextField.placeholder = localizedString(key: kUserSignUpViewControllerPhoneKey)
        self.emailTextField.placeholder = localizedString(key: kUserSignUpViewControllerEmailKey)
        self.passwordTextField.placeholder = localizedString(key: kUserSignUpViewControllerPasswordKey)
        
        // Set required fields
        self.salutationTextField.isRequired = true
        self.firstNameTextField.isRequired = true
        self.lastNameTextField.isRequired = true
        self.addressTextField.isRequired = true
        self.addressOptionalTextField.isRequired = true
        self.zipCodeTextField.isRequired = true
        self.countryCodeTextField.isRequired = true
        self.stateCodeTextField.isRequired = true
        self.cityTextField.isRequired = true
        self.emailTextField.isRequired = true
        self.passwordTextField.isRequired = true
        
        // Apply style
        self.salutationTextField.position = TextFieldPosition.isFirst
        self.firstNameTextField.position = TextFieldPosition.isMiddle
        self.lastNameTextField.position = TextFieldPosition.isMiddle
        self.addressTextField.position = TextFieldPosition.isMiddle
        self.addressOptionalTextField.position = TextFieldPosition.isMiddle
        self.zipCodeTextField.position = TextFieldPosition.isMiddle
        self.countryCodeTextField.position = TextFieldPosition.isMiddle
        self.stateCodeTextField.position = TextFieldPosition.isMiddle
        self.cityTextField.position = TextFieldPosition.isMiddle
        self.phoneTextField.position = TextFieldPosition.isMiddle
        self.emailTextField.position = TextFieldPosition.isMiddle
        self.passwordTextField.position = TextFieldPosition.isLast
        
        // Setup keyboard controls
        let textFields: Array<UITextInput> = [self.salutationTextField, self.firstNameTextField, self.lastNameTextField, self.addressTextField, self.addressOptionalTextField, self.countryCodeTextField, self.stateCodeTextField, self.cityTextField, self.zipCodeTextField, self.phoneTextField, self.emailTextField, self.passwordTextField];
        self.keyboardControls = self.newKeyboardControls(fields: textFields, actionTitle: localizedString(key: kDoneKey))
    }
    
    internal func setupTappablePrivacyAndTermsTextView() {
     
        // Add rich style elements to privacy and terms and conditions
        
        let privacyString: String = "privacy"
        let termsString: String =  "terms and conditions"
        let privacyAndTermsString: String = "This is an example of \(privacyString) and \(termsString)."
        
        self.privacyAndTermsTextView.text = privacyAndTermsString
        
        self.privacyAndTermsTextView.applyColor(withSubstring: privacyString, color: kColorBlue)
        self.privacyAndTermsTextView.applyColor(withSubstring: termsString, color: kColorBlue)
        
        //[_privacyAndTermsTextView applyBoldStyleWithSubstring:privacyString];
        //[_privacyAndTermsTextView applyBoldStyleWithSubstring:termsString];
        
        //[self.privacyAndTermsTextView applyUnderlineStyleWithSubstring:privacyString];
        //[self.privacyAndTermsTextView applyUnderlineStyleWithSubstring:termsString];
        
        self.privacyAndTermsTextView.addTapGesture(withSubstring: privacyString) { (success, result, error) in
            
            DDLogDebug(log: "Privacy clicked")
        }

        self.privacyAndTermsTextView.addTapGesture(withSubstring: termsString) { (success, result, error) in
            
            DDLogDebug(log: "Terms clicked")
        }
    }
}
