//
//  AuthPresenter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 07.07.2020.
//

import Foundation

enum MobileFieldValidationError: Error {
    case incorrentNumberFormat
}

enum MailFieldValidationError: Error {
    case incorrentMailFormat
    case incorrectPasswordFormat
    case incorrectMailAndPasswordFormat
}

enum CreateWalletFieldValidationError: Error {
    case incorrentMailFormat
    case incorrectPasswordFormat
    case passwordsDontMatch
    case incorrectMailAndPasswordsFormat
}

class AuthPresenter: BasePresenter<AuthViewController, AuthRouter> {
    
    private lazy var interactor: AuthInteractor = {
        return AuthInteractor(callBack: self, authViaMobileCallback: self, authViaMailCallback: self, createWalletCallback: self)
    }()
    
    weak var authViaMobilePresenterViewCallback: AuthViaMobilePresenterViewCallback?
    weak var authViaMailPresenterViewCallback: AuthViaMailPresenterViewCallback?
    weak var createWalletPresenterViewCallback: CreateWalletPresenterViewCallback?
    weak var checkInboxPresenterViewCallback: CheckInboxPresenterViewCallback?
    
    func loginViaFacebook() {
        self.interactor.loginViaFacebook()
    }
    
    func loginViaGoogle() {
        self.interactor.loginViaGoogle()
    }
    
    func loginViaMobile() {
        router?.openLoginViaMobileController(presenter: self)
    }
    
    func loginViaMail() {
        // router?.openMainScreen()
        router?.openSignUpController(presenter: self)
    }
    
    func signIn() {
        router?.openLoginViaMailController(presenter: self)
    }
    
    func onResendEmail() {
        interactor.resendEmail()
    }
    
    func onLoginViaMailDoneButton(email: String, password: String, visible: Bool) {
        Prefs.shared.email = email
        Prefs.shared.password = password
        
        interactor.loginViaMail(email: email, password: password, fromReg: false, visible: visible)
    }
    
    
    func onRegistrationViaMailDoneButton(email: String, password: String, visible: Bool) {
        Prefs.shared.email = email
        Prefs.shared.password = password
        
        interactor.loginViaMail(email: email, password: password, fromReg: true, visible: visible)
        
    }
    
    func authWithOtp(_ email: String, _ password: String, _ code: String) {
        interactor.authWithOtp(email, password, code)
        //        router?.openMainScreen()
    }
    
    
    
    
    func validatePhoneNumberField(number: String) {
        interactor.validatePhoneNumberField(number: number)
    }
    
    func receiveCodeToMobile(number: String) {
        interactor.receiveCodeToMobile(number: number)
    }
    
    
    func validateLoginViaMailFields(email: String, password: String) {
        interactor.validateLoginViaMailFields(email: email, password: password)
    }
    
    func validateCreateWalletFields(email: String, password: String, repeatPassword: String) {
        interactor.validateCreateWalletFields(email: email, password: password, repeatPassword: repeatPassword)
    }
    
    func onCreateWalletDoneButton(email: String, password: String) {
        router?.openCreatePincodeController(presenter: self, .CREATE)
    }
    
    func onCreateWalletConfirmationDoneButton(isReceiveEmail: Bool, name: String) {
        //interactor.createWallet(isReceiveEmail, name)
        
        router?.openMainScreen()
    }
    
    func onForgotPassword() {
        router?.onForgotPassword()
    }
    
    func openPincodeController(mode: PincodeMode) {
        router?.openCreatePincodeController(presenter: self, mode)
    }
    
    func onCheckYourInboxDoneButton(email: String, password: String) {
        interactor.authAccount(email, password)
    }
    
    func onSignUp(email: String, password: String) {
        Prefs.shared.email = email
        Prefs.shared.password = password
        
        interactor.registerAccount(email, password)
    }
    
    func onCheckInbox(email: String, password: String, type: TypeAuth) {
        router?.openCheckInbox(presenter: self, email: email, password: password, type: type)
    }
    
    func onTutorSecure() {
        router?.openTutorialSecure(presenter: self)
    }
    
    func on2FASetup() {
        router?.open2FASetup()
    }
    
    func onNotRightNow() {
        router?.openMainScreen()
    }
    
}

extension AuthPresenter: AuthInteractorCallback {
    func onFacebookLoggedIn(result: Result<String, NSError>) {
        //
    }
    
    func onGoogleLoggedIn(result: Result<String, NSError>) {
        //
    }
    
    func onMobileLoggedIn(result: Result<String, NSError>) {
        //
    }
    
    func onMailLoggedInSuccess(fromReg: Bool) {
        KycManager.shared.clearCache()
        fromReg ? onTutorSecure() : router?.openEnterOtpCodeLoginController(presenter: self, email: Prefs.shared.email, password: Prefs.shared.password)
    }
    
    func onMailLoggedInFailure(error: APIError, fromReg: Bool) {
        if fromReg {
            if error.localizedDescription == "No network" {
                HUD.shared.showError("No network")
            } else {
                HUD.shared.showError("Email not confirmed. Try again")
            }
        } else {
            if error.localizedDescription == "No network" {
                HUD.shared.showError("No network")
            } else if error.localizedDescription == "Unauthorized" {
                HUD.shared.showError("Wrong username or password")
            } else {
                HUD.shared.showError("Something went wrong")
            }
        }
    }
    
    func onGetApiKeySuccess(result: Result<String, APIError>) {
        router?.openMainScreen()
    }
    
    func onGetApiKeyFailure(error: APIError) {
        
    }
    
}

extension AuthPresenter: AuthViaMobileCallback {
    func onCodeWasSent(result: Result<String, MobileFieldValidationError>) {
        switch result {
        case .success(let number):
            router?.openEnterCodeController(presenter: self, number)
        case .failure(let error):
            return
        }
    }
    
    func onMobileFieldValidated(result: Result<String, MobileFieldValidationError>) {
        switch result {
        case .success(let _):
            authViaMobilePresenterViewCallback?.onMobileFieldValidatedSuccess()
        case .failure(let error):
            authViaMobilePresenterViewCallback?.onMobileFieldValidatedError()
        }
    }
}


extension AuthPresenter: AuthViaMailCallback {
    func onAuthViaMailFieldsValidated(result: Result<String, MailFieldValidationError>) {
        switch result {
        case .success(_):
            authViaMailPresenterViewCallback?.onAuthViaMailFieldsValidatedSuccess()
        case .failure(let error):
            authViaMailPresenterViewCallback?.onAuthViaMailFieldsValidatedFailure(error: error)
        }
    }
}

extension AuthPresenter: CreateWalletCallback {
    func onResendEmailSuccess() {
        checkInboxPresenterViewCallback?.onResendEmailSuccess()
    }
    
    func onAuthAccountWithOTPSuccess() {
        
        interactor.getApiKey()
        //  self.onNotRightNow()
    }
    
    func onAuthAccountSuccess() {
        
        self.openPincodeController(mode: .ENTER)
        HUD.shared.dismiss()
    }
    
    func onAuthAccountFailure(error: APIError) {
        HUD.shared.showError(error.localizedDescription)
    }
    
    func onRegisterWalletSuccess() {
        createWalletPresenterViewCallback?.onRegisterWalletSuccess()
    }
    
    func onRegisterWalletFailure(error: APIError) {
        print(error)
        createWalletPresenterViewCallback?.onRegisterWalletFailure()
    }
    
    
    func onCreateWalletFieldsValidated(result: Result<String, CreateWalletFieldValidationError>) {
        switch result {
        case .success(_):
            createWalletPresenterViewCallback?.onCreateWalletFieldsValidatedSuccess()
        case .failure(let error):
            createWalletPresenterViewCallback?.onCreateWalletFieldsValidatedError(error: error)
        }
    }
}

