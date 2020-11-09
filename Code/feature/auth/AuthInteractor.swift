//
//  AuthInteractor.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 07.07.2020.
//

import Foundation

protocol AuthInteractorCallback: InteractorCallBack {
    func onFacebookLoggedIn(result: Result<String, NSError>)
    func onGoogleLoggedIn(result: Result<String, NSError>)
    func onMobileLoggedIn(result: Result<String, NSError>)
    func onMailLoggedInSuccess(fromReg: Bool)
    func onMailLoggedInFailure(error: APIError, fromReg: Bool)
    func onGetApiKeySuccess(result: Result<String, APIError>)
    func onGetApiKeyFailure(error: APIError)
}

protocol AuthViaMobileCallback: class {
    func onMobileFieldValidated(result: Result<String, MobileFieldValidationError>)
    func onCodeWasSent(result: Result<String, MobileFieldValidationError>)
}

protocol AuthViaMailCallback: class {
    func onAuthViaMailFieldsValidated(result: Result<String, MailFieldValidationError>)
}

protocol CreateWalletCallback: class {
    func onRegisterWalletSuccess()
    func onRegisterWalletFailure(error: APIError)
    func onAuthAccountSuccess()
    func onAuthAccountFailure(error: APIError)
    func onCreateWalletFieldsValidated(result: Result<String, CreateWalletFieldValidationError>)
    func onAuthAccountWithOTPSuccess()
    func onResendEmailSuccess()
}

class AuthInteractor: InteractorProtocol {
    var callBack: AuthInteractorCallback?
    var authViaMobileCallback: AuthViaMobileCallback?
    var authViaMailCallback : AuthViaMailCallback?
    var createWalletCallback: CreateWalletCallback?
    
    
    init(callBack: AuthInteractorCallback?, authViaMobileCallback: AuthViaMobileCallback?, authViaMailCallback : AuthViaMailCallback?, createWalletCallback: CreateWalletCallback?) {
        self.callBack = callBack
        self.authViaMobileCallback = authViaMobileCallback
        self.authViaMailCallback = authViaMailCallback
        self.createWalletCallback = createWalletCallback
    }
    
    func loginViaFacebook() {
        
    }
    
    func loginViaGoogle() {
        
    }
    
    func loginViaMobile() {
        
    }
    
    func loginViaMail(email: String, password: String, fromReg: Bool, visible: Bool) {
        if visible { HUD.shared.show() }
        NetManager.shared.authAccount(email: email, password: password) { (result: Result<AuthAccountResponse, APIError>) in
            switch result {
            case .success(let data):
                HUD.shared.dismiss()
                if let sessionToken = data.session, let accessToken = data.access_token {
                    Prefs.shared.sessionToken = sessionToken
                    Prefs.shared.accessToken = accessToken
                    self.callBack?.onMailLoggedInSuccess(fromReg: fromReg)
                } else {
                    if (data.text?.contains("Authentication") ?? false) && !fromReg {
                        self.callBack?.onMailLoggedInSuccess(fromReg: fromReg)
                    } else {
                        if visible {
                            self.callBack?.onMailLoggedInFailure(error: .custom(text: "Unauthorized"), fromReg: fromReg)
                        }
                    }
                }
            case .failure(let error):
                HUD.shared.dismiss()
                if visible { self.callBack?.onMailLoggedInFailure(error: error, fromReg: fromReg) }
            }
        }
    }
    
    func registerAccount(_ email: String, _ password: String) {
        HUD.shared.show()
        NetManager.shared.registerAccount(email: email, password: password) { (result: Result<Any, APIError>) in
            switch result {
            case .success(_):
                HUD.shared.dismiss()
                self.createWalletCallback?.onRegisterWalletSuccess()
            case .failure(let error):
                HUD.shared.showError(error.localizedDescription)
                self.createWalletCallback?.onRegisterWalletFailure(error: error)
            }
        }
    }
    
    func authAccount(_ email: String, _ password: String) {
        HUD.shared.show()
        NetManager.shared.authAccount(email: email, password: password) { (result: Result<AuthAccountResponse, APIError>) in
            switch result {
            case .success(let data):
                HUD.shared.dismiss()

                if let sessionToken = data.session, let accessToken = data.access_token {
                    
                    Prefs.shared.sessionToken = sessionToken
                    Prefs.shared.accessToken = accessToken
                    self.createWalletCallback?.onAuthAccountSuccess()
                    
                } else {
                    self.createWalletCallback?.onAuthAccountFailure(error: .responseUnsuccessful)
                }
            case .failure(let error):
                HUD.shared.showError(error.localizedDescription)
                self.createWalletCallback?.onAuthAccountFailure(error: error)
            }
        }
    }
    
    func resendEmail() {
        HUD.shared.show()
        NetManager.shared.resendEmail(email: Prefs.shared.email, password: Prefs.shared.password) { (result: Result<Int, APIError>) in
            switch result {
            case .success(let data):
                HUD.shared.dismiss()
                self.createWalletCallback?.onResendEmailSuccess()
                
            case .failure(let error):
                HUD.shared.showError(error.localizedDescription)
                self.createWalletCallback?.onAuthAccountFailure(error: error)
            }
        }
    }
    
    
    func authWithOtp(_ email: String, _ password: String, _ code: String) {
        NetManager.shared.authAccount(email: email, password: password, otpCode: code) { (result: Result<AuthAccountResponse, APIError>) in
            switch result {
            case .success(let data):
                if let sessionToken = data.session, let accessToken = data.access_token {
                    Prefs.shared.sessionToken = sessionToken
                    Prefs.shared.accessToken = accessToken
                    Prefs.shared.email = email
                    self.createWalletCallback?.onAuthAccountWithOTPSuccess()
                } else {
                    self.createWalletCallback?.onAuthAccountFailure(error: .custom(text: "OTP code is not valid"))
                }
            case .failure(let error):
                if error.localizedDescription == "No network" {
                    self.createWalletCallback?.onAuthAccountFailure(error: error)
                } else {
                    self.createWalletCallback?.onAuthAccountFailure(error: .custom(text: "Something went wrong"))
                }
                
            }
        }
    }
    
    func getApiKey() {
        NetManager.shared.getApiKey() { (result: Result<GetApiKeyResponse, APIError>) in
            switch result {
            case .success(let data):
                HUD.shared.dismiss()
                if let privateKey = data.private_key, let publicKey = data.public_key {
                    let str = "\(publicKey):\(privateKey)"
                    Prefs.shared.apiKey = str.toBase64()
                    
                    self.createWalletCallback?.onAuthAccountSuccess()
                    StaticCurrenciesLoader.shared.fetchCurrencies()
//                    Prefs.shared.sessionToken = sessionToken
//                    Prefs.shared.accessToken = accessToken
                } else {
                    self.createWalletCallback?.onAuthAccountFailure(error: .responseUnsuccessful)
                }
            case .failure(let error):
                HUD.shared.dismiss()

                self.createWalletCallback?.onAuthAccountFailure(error: .requestFailed)
            }
        }
    }
    
    func createWallet(_ isReceiveEmail: Bool, _ name: String) {
        
    }
    
    func validatePhoneNumberField(number: String) {
        if number.count < 7 || !number.isAllDigits() {
            authViaMobileCallback?.onMobileFieldValidated(result: .failure(MobileFieldValidationError.incorrentNumberFormat))
        } else {
            authViaMobileCallback?.onMobileFieldValidated(result: .success(""))
        }
    }
    
    func validateLoginViaMailFields(email: String, password: String) {
        var email = email
        email = email.trim()
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isMailValid = emailPredicate.evaluate(with: email)
        
//        let passwordRegex = "^[0-9a-zA-Z!@#$%^&*]{8,32}"
        let passwordRegex = "^.{6,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordPredicate.evaluate(with: password)
        
        if !isMailValid && !isPasswordValid {
            authViaMailCallback?.onAuthViaMailFieldsValidated(result: .failure(.incorrectMailAndPasswordFormat))
        } else if !isMailValid {
            authViaMailCallback?.onAuthViaMailFieldsValidated(result: .failure(.incorrentMailFormat))
        } else if !isPasswordValid {
            authViaMailCallback?.onAuthViaMailFieldsValidated(result: .failure(.incorrectPasswordFormat))
        } else {
            authViaMailCallback?.onAuthViaMailFieldsValidated(result: .success(""))
        }
    }
    
    func validateCreateWalletFields(email: String, password: String, repeatPassword: String) {
        var email = email
        email = email.trim()
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isMailValid = emailPredicate.evaluate(with: email)
        
//        let passwordRegex = "^[0-9a-zA-Z!@#$%^&*]{8,32}"
//        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[.//d]{6,}$"
//        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
//        let isPasswordValid = passwordPredicate.evaluate(with: password)
        
        let isPasswordValid = password.count >= 6 && checkSignUpPassword(password)
        let isRepeatPasswordValid = ((password == repeatPassword) && isPasswordValid)
        
        if !isMailValid && !isPasswordValid && !isRepeatPasswordValid {
            createWalletCallback?.onCreateWalletFieldsValidated(result: .failure(.incorrectMailAndPasswordsFormat))
        } else if !isMailValid {
            createWalletCallback?.onCreateWalletFieldsValidated(result: .failure(.incorrentMailFormat))
        } else if !isPasswordValid {
            createWalletCallback?.onCreateWalletFieldsValidated(result: .failure(.incorrectPasswordFormat))
        } else if !isRepeatPasswordValid {
            createWalletCallback?.onCreateWalletFieldsValidated(result: .failure(.passwordsDontMatch))
        } else {
            createWalletCallback?.onCreateWalletFieldsValidated(result: .success(""))
        }
    }
    
    private func checkSignUpPassword(_ password: String) -> Bool {

        let capitalLetterRegEx  = ".*[A-Z]+.*" //BIG LETTEER
        var texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        var capitalresult = texttest.evaluate(with: password)
        
        let numberRegEx  = ".*[0-9]+.*" //NUMS
        var texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        var numberresult = texttest1.evaluate(with: password)


        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*" //SYMBOLS
        var texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)

//var specialresult = texttest2.evaluate(with: password)
        
        let noncapitalLetterRegEx  = ".*[a-z]+.*" //SMALL LETTEER
        var texttest3 = NSPredicate(format:"SELF MATCHES %@", noncapitalLetterRegEx)
        var noncapitalresult = texttest3.evaluate(with: password)

        return capitalresult && numberresult && noncapitalresult

    }
    
    func receiveCodeToMobile(number: String) {
        authViaMobileCallback?.onCodeWasSent(result: .success(number))
    }
}
