//
//  AuthRouter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 07.07.2020.
//

import UIKit

class AuthRouter: BaseControllerRouter {
    
    override func root() -> BaseNavigaionController {
        let view = AuthViewController.instantiateFromAppStoryboard(.Auth)
        view.presenter = AuthPresenter(view: view, router: self)
        self.navigationController.setViewControllers([view], animated: false)
        return self.navigationController
    }
    
    func rootAfterLogout() -> BaseNavigaionController {
        let baseView = AuthViewController.instantiateFromAppStoryboard(.Auth)
        let view = LoginOrCreateWrapController.instantiateFromAppStoryboard(.Auth)
        view.presenter = AuthPresenter(view: baseView, router: self)
        view.tappedSignIn = true
        view.openedAfterLogout = true
        self.navigationController.setViewControllers([view], animated: false)
        return self.navigationController
    }
    
    func openTutor() {
        guard let view = AppRouter().route(from: .Tutorial)?.root() else { return }
        super.push(to: view as! BaseViewController, animated: true)
    }
    
    
    func openLoginViaMobileController(presenter: AuthPresenter) {
        let view = LoginViaMobileController.instantiateFromAppStoryboard(.Auth)
        view.presenter = presenter
        presenter.authViaMobilePresenterViewCallback = view
        self.push(to: view, animated: true)
    }
    
    func openLoginViaMailController(presenter: AuthPresenter) {
        let view = LoginOrCreateWrapController.instantiateFromAppStoryboard(.Auth)
        view.presenter = presenter
        view.tappedSignIn = true
        super.push(to: view, animated: true)
    }
    
    func openSignUpController(presenter: AuthPresenter) {
        let view = LoginOrCreateWrapController.instantiateFromAppStoryboard(.Auth)
        view.presenter = presenter
        view.tappedSignIn = false
        super.push(to: view, animated: true)
    }
    
    func openEnterOtpCodeLoginController(presenter: AuthPresenter, email: String, password: String) {
        let view = EnterOtpCodeLoginController.instantiateFromAppStoryboard(.Auth)
        view.presenter = presenter
        view.email = email
        view.password = password
        super.push(to: view, animated: true)
    }
    
    func openEnterCodeController(presenter: AuthPresenter, _ phoneNumber: String) {
        let view = EnterCodeController.instantiateFromAppStoryboard(.Auth)
        view.presenter = presenter
        view.phoneNumber = phoneNumber
        super.push(to: view, animated: true)
    }
    
    func onForgotPassword() {
        guard let view = AppRouter().route(from: .ResetPassword)?.root() else { return }
        super.push(to: view as! BaseViewController, animated: true)
    }
    
    func openCreatePincodeController(presenter: AuthPresenter, _ mode: PincodeMode) {
        guard let router = AppRouter().route(from: .Pincode) else { return }
        guard let view = router.root() as? PincodeViewController else { return }
        (router as? PincodeRouter)?.authPresenter = presenter
        view.pincodeMode = mode
        super.push(to: view as BaseViewController, animated: true)
    }
    
    func openCheckInbox(presenter: AuthPresenter, email: String, password: String, type: TypeAuth) {
        let view = CheckInboxViewController.instantiateFromAppStoryboard(.Auth)
        view.presenter = presenter
        view.email = email
        view.password = password
        view.type = type
        presenter.checkInboxPresenterViewCallback = view
        super.push(to: view, animated: true)
    }
    
    func openTutorialSecure(presenter: AuthPresenter) {
        guard let view = AppRouter().route(from: .Tutorial)?.root() else { return }
        if !(super.navigationController.topViewController
            is TutorSecureViewController) {
            super.push(to: view as! BaseViewController, animated: true)
        }
    }
    
    func open2FASetup(presenter: AuthPresenter? = nil) {
        guard let view = AppRouter().route(from: .TwoFAuth)?.root() else { return }
        super.push(to: view as! BaseViewController, animated: true)
    }
    
    func openMainScreen() {
        AppRouter().openMainScreen()
    }
}
