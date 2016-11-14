//
//  ViewControllerFactory.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 06/09/16.
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

class ViewControllerFactory: ViewControllerFactoryProtocol {

    // MARK: ViewControllerFactoryProtocol
    
    required init(managerFactory: ManagerFactoryProtocol) {
        
        _managerFactory = managerFactory
    }
    
    // MARK: Intro
    
    func launchViewController(context: Any?)->LaunchViewController {
        
        let vc = viewControllerFromXib(classType: LaunchViewController.self, context: context) as! LaunchViewController
        vc.model = self.model(classType: LaunchModel.self as AnyClass, context: context) as? LaunchModel
        
        return vc
    }
    
    func walkthroughViewController(context: Any?)->WalkthroughViewController {
        
        let vc = viewControllerFromXib(classType: WalkthroughViewController.self, context: context) as! WalkthroughViewController
        vc.model = self.model(classType: WalkthroughModel.self as AnyClass, context: context) as? WalkthroughModel
        
        return vc
    }
    
    // MARK: Content
    
    func homeViewController(context: Any?)->HomeViewController {
        
        let vc = viewControllerFromSb(classType: HomeViewController.self, context: context) as! HomeViewController
        vc.model = self.model(classType: HomeModel.self as AnyClass, context: context) as? HomeModel
        
        return vc
    }
    
    func photoDetailsViewController(context: Any?)->PhotoDetailsViewController {
        
        let vc = viewControllerFromSb(classType: PhotoDetailsViewController.self, context: context) as! PhotoDetailsViewController
        vc.model = self.model(classType: PhotoDetailsModel.self as AnyClass, context: context) as? PhotoDetailsModel
        
        return vc
    }
    
    // MARK: User
    
    func startViewController(context: Any?)->StartViewController {
        
        let vc = viewControllerFromSb(classType: StartViewController.self, context: context) as! StartViewController
        vc.model = self.model(classType: StartModel.self as AnyClass, context: context) as? StartModel
        
        return vc
    }
    
    func userContainerViewController(context: Any?)->UserContainerViewController {
        
        let vc = viewControllerFromSb(classType: UserContainerViewController.self, context: context) as! UserContainerViewController
        vc.model = self.model(classType: UserContainerModel.self as AnyClass, context: context) as? UserContainerModel
        
        vc.startVC = self.startViewController(context: nil)
        vc.startVC?.delegate = vc
        vc.loginVc = self.userLoginViewController(context: nil)
        vc.loginVc?.delegate = vc
        
        return vc
    }
    
    func userLoginViewController(context: Any?)->UserLoginViewController {
        
        let vc = viewControllerFromSb(classType: UserLoginViewController.self, context: context) as! UserLoginViewController
        vc.model = self.model(classType: UserLoginModel.self as AnyClass, context: context) as? UserLoginModel
        
        return vc
    }

    func userSignUpViewController(context: Any?)->UserSignUpViewController {
        
        let vc = viewControllerFromSb(classType: UserSignUpViewController.self, context: context) as! UserSignUpViewController
        vc.model = self.model(classType: SignUpModel.self as AnyClass, context: context) as? SignUpModel
        
        return vc
    }
    
    func userResetPasswordViewController(context: Any?)->UserResetPasswordViewController {
        
        let vc = viewControllerFromSb(classType: UserResetPasswordViewController.self, context: context) as! UserResetPasswordViewController
        vc.model = self.model(classType: UserResetPasswordModel.self as AnyClass, context: context) as? UserResetPasswordModel
        
        return vc
    }
    
    func userProfileViewController(context: Any?)->UserProfileViewController {
        
        let vc = viewControllerFromSb(classType: UserProfileViewController.self, context: context) as! UserProfileViewController
        vc.model = self.model(classType: UserProfileModel.self as AnyClass, context: context) as? UserProfileModel
        
        return vc
    }
    
    // Legal
    func termsConditionsViewController(context: Any?)->TermsConditionsViewController {
        
        let vc = viewControllerFromSb(classType: TermsConditionsViewController.self, context: context) as! TermsConditionsViewController
        vc.model = self.model(classType: TermsConditionsModel.self as AnyClass, context: context) as? TermsConditionsModel
        
        return vc
    }
    
    func privacyPolicyViewController(context: Any?)->PrivacyPolicyViewController {
        
        let vc = viewControllerFromSb(classType: PrivacyPolicyViewController.self, context: context) as! PrivacyPolicyViewController
        vc.model = self.model(classType: PrivacyPolicyModel.self as AnyClass, context: context) as? PrivacyPolicyModel
        
        return vc
    }
    
    // MARK: Maps
    
    func mapsViewController(context: Any?)->MapsViewController {
        
        let vc = viewControllerFromSb(classType: MapsViewController.self, context: context) as! MapsViewController
        vc.model = self.model(classType: MapsModel.self as AnyClass, context: context) as? MapsModel
        
        return vc
    }
    
    // MARK: Menu
    
    func menuViewController(context: Any?)->MenuViewController {
        
        let vc = viewControllerFromSb(classType: MenuViewController.self, context: context) as! MenuViewController
        vc.model = self.model(classType: MenuModel.self as AnyClass, context: context) as? MenuModel
        
        return vc
    }
    
    // MARK: Reusable
    
    func countryPickerViewController(context: Any?)->CountryPickerViewController {
        
        let vc = viewControllerFromSb(classType: CountryPickerViewController.self, context: context) as! CountryPickerViewController
        vc.model = self.model(classType: CountryPickerModel.self as AnyClass, context: context) as? CountryPickerModel
        
        return vc
    }
    
    func contactViewController(context: Any?)->ContactViewController {
        
        let vc = viewControllerFromSb(classType: ContactViewController.self, context: context) as! ContactViewController
        vc.model = self.model(classType: ContactModel.self as AnyClass, context: context) as? ContactModel
        
        return vc
    }
    
    func settingsViewController(context: Any?)->SettingsViewController {
        
        let vc = viewControllerFromSb(classType: SettingsViewController.self, context: context) as! SettingsViewController
        vc.model = self.model(classType: SettingsModel.self as AnyClass, context: context) as? SettingsModel
        
        return vc
    }
    
    // MARK: Demo
    
    func tableViewExampleViewController(context: Any?)->TableViewExampleViewController {
        
        let vc = viewControllerFromSb(classType: TableViewExampleViewController.self, context: context) as! TableViewExampleViewController
        vc.model = self.model(classType: TableViewExampleModel.self as AnyClass, context: context) as? TableViewExampleModel
        
        return vc
    }
    
    func tableWithSearchViewController(context: Any?)->TableWithSearchViewController {
        
        let vc = viewControllerFromSb(classType: TableWithSearchViewController.self, context: context) as! TableWithSearchViewController
        vc.model = self.model(classType: TableWithSearchModel.self as AnyClass, context: context) as? TableWithSearchModel
        
        return vc
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _managerFactory: ManagerFactoryProtocol
    
    // Returns true if viewController had property and it was injected with the value
    // The approach used from: https://thatthinginswift.com/dependency-injection-storyboards-swift/
    // Using Mirror for reflection and KVO for injecting
    internal func needsDependency(viewController: UIViewController, propertyName: String)->Bool {
        
        var result: Bool = false
        
        let vcMirror = Mirror(reflecting: viewController)
        let superVcMirror: Mirror? = vcMirror.superclassMirror
        let superSuperVcMirror: Mirror? = superVcMirror?.superclassMirror
        
        result = self.containsProperty(mirror: vcMirror, propertyName: propertyName)
        result = result || self.containsProperty(mirror: superVcMirror, propertyName: propertyName)
        result = result || self.containsProperty(mirror: superSuperVcMirror, propertyName: propertyName)
        
        return result
    }
    
    internal func containsProperty(mirror: Mirror?, propertyName: String) -> Bool {
        
        var result: Bool = false
        
        if let mirror = mirror {
            
            let vcProperties = mirror.children.filter { ($0.label ?? "").isEqual(propertyName) }
            
            if vcProperties.first != nil {
                
                result = true
            }
        }
        
        return result
    }
    
    internal func name(viewControllerClassType: AnyClass)->String {
        
        var viewControllerClassName: String = NSStringFromClass(viewControllerClassType)
        
        // Autopick depending on platform
        if isIpad {
            
            viewControllerClassName = viewControllerClassName + "_ipad"
            
        } else if isIphone {
            
            viewControllerClassName = viewControllerClassName + "_iphone"
        }
        
        return viewControllerClassName
    }
    
    internal func viewControllerFromSb(classType: AnyClass, context: Any?)->UIViewController {
     
        var viewControllerClassName: String = self.name(viewControllerClassType: classType)
        viewControllerClassName = viewControllerClassName.components(separatedBy: ".").last!
        
        let storyboard = UIStoryboard(name: viewControllerClassName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerClassName)
        
        injectDependencies(viewController: vc, context: context)
                
        return vc
    }
    
    internal func viewControllerFromXib(classType: AnyClass, context: Any?)->UIViewController {
        
        let viewControllerClassName: String = self.name(viewControllerClassType: classType)
        
        //let deviceClass: AnyClass? = NSClassFromString(viewControllerClassName);
        let deviceClass = NSClassFromString(viewControllerClassName) as! UIViewController.Type

        let vc: UIViewController = deviceClass.init()
        
        injectDependencies(viewController: vc, context: context)
        
        return vc
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var vc = segue.destination as! GenericViewControllerProtocol;
        self.injectDependencies(viewController: &vc);
        
        //if (segue.identifier == "Load View") {
        // pass data to next view
        //}
    }*/
    
    func injectDependencies(viewController: UIViewController, context: Any?) {
        
        if self.needsDependency(viewController: viewController, propertyName: "context") {
        
            (viewController as! GenericViewControllerProtocol).context = context
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "viewLoader") {
            
            (viewController as! GenericViewControllerProtocol).viewLoader = self.viewLoader()
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "crashManager") {
            
            (viewController as! GenericViewControllerProtocol).crashManager = self._managerFactory.crashManager
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "analyticsManager") {
            
            (viewController as! GenericViewControllerProtocol).analyticsManager = self._managerFactory.analyticsManager
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "messageBarManager") {
            
            (viewController as! GenericViewControllerProtocol).messageBarManager = self._managerFactory.messageBarManager
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "viewControllerFactory") {
            
            (viewController as! GenericViewControllerProtocol).viewControllerFactory = self
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "localizationManager") {
            
            (viewController as! GenericViewControllerProtocol).localizationManager = self._managerFactory.localizationManager
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "userManager") {
            
            (viewController as! GenericViewControllerProtocol).userManager = self._managerFactory.userManager
        }
        
        if self.needsDependency(viewController: viewController, propertyName: "reachabilityManager") {
            
            (viewController as! GenericViewControllerProtocol).reachabilityManager = self._managerFactory.reachabilityManager
            self.addNetworkStatusObserving(viewController: viewController as! GenericViewControllerProtocol)
        }
    }
    
    func addNetworkStatusObserving(viewController: GenericViewControllerProtocol) {
        
        weak var weakGenericViewController = viewController
        weak var weakViewController = (viewController as! UIViewController)
        
        // TODO: not calling after second on/off switch
        self._managerFactory.reachabilityManager.addServiceObserver(observer: weakViewController as! ReachabilityManagerObserver, notificationType: ReachabilityManagerNotificationType.internetDidBecomeOn, callback: { /*[weak self]*/ (success, result, context, error) in
            
            let lastVc = weakViewController?.navigationController?.viewControllers.last
            
            // Check for error and only handle once, inside last screen
            if (lastVc == weakViewController) {
                
                weakGenericViewController?.viewLoader?.hideNoInternetConnectionLabel(containerView: (weakViewController?.view)!)
            }
        }, context: nil)
        
        self._managerFactory.reachabilityManager.addServiceObserver(observer: weakViewController as! ReachabilityManagerObserver
            , notificationType: ReachabilityManagerNotificationType.internetDidBecomeOff, callback: { /*[weak self]*/ (success, result, context, error) in
                
                weakGenericViewController?.viewLoader?.showNoInternetConnectionLabel(containerView: (weakViewController?.view)!)
                
            }, context: nil)
        
        // Subscribe and handle network errors
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: NetworkRequestError.notification, object: self, queue: nil) { [weak self] (notification) in
            
            if let info = notification.userInfo as? Dictionary<String,Error> {
                
                let error: ErrorEntity? = info[NetworkRequestError.notificationUserInfoErrorKey] as? ErrorEntity
                
                if let error = error {
                    
                    // Check for error and only handle once, inside last screen
                    if (weakViewController?.navigationController?.viewControllers.last == weakViewController) {
                        
                        if (error.code == NetworkRequestError.unauthorized.code) {
                            
                            // Go to start
                            weakGenericViewController?.logoutAndGoBackToAppStart(error: error)
                            
                        } else {
                            
                            self?._managerFactory.messageBarManager.showMessage(title: " ", description: error.message, type: MessageBarMessageType.error)
                        }
                    }
                }
            }
        }
    }
    
    internal func model(classType: AnyClass, context: Any?) -> BaseModel {
        
        let className: String = NSStringFromClass(classType)
        let deviceClass = NSClassFromString(className) as! BaseModel.Type
        
        let model: BaseModel = deviceClass.init()
        model.userManager = _managerFactory.userManager
        model.settingsManager = _managerFactory.settingsManager
        model.networkOperationFactory = _managerFactory.networkOperationFactory
        model.reachabilityManager = _managerFactory.reachabilityManager
        model.analyticsManager = _managerFactory.analyticsManager
        model.context = context
        
        model.commonInit()
        
        return model
    }
    
    internal func viewLoader()->ViewLoader {
        
        let loader: ViewLoader = ViewLoader()
        return loader
    }
}
