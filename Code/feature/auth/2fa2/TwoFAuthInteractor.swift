//
//  TwoFAuthInteractor.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 14.08.2020.
//

import Foundation

protocol TwoFAuthInteractorCallback: InteractorCallBack {
    func onTotpCreated(result: Result<TotpResponse, APIError>)
    func onTotpActivated(result: Result<String, APIError>)
    func onGetApiKey()
    func onResendEmailSuccess()
    func onAuthAccountFailure(error: APIError)
}

class TwoFAuthInteractor: InteractorProtocol {
    var callBack: TwoFAuthInteractorCallback?
    
    init(callBack: TwoFAuthInteractorCallback?) {
        self.callBack = callBack
    }
    
    
    func createTotp() {
        NetManager.shared.createTotp(complition: { (result: Result<TotpResponse, APIError>) in
            switch result {
            case .success(let data):
                if data.otpID == nil || data.otpLink == nil || data.backupPassword == nil {
                    self.callBack?.onTotpCreated(result: .failure(.custom(text: "Something went wrong")))
                    return
                }
                let otpID = data.otpID
                let otpLink = data.otpLink
                
//                guard let otpID = data.otpID, let otpLink = data.otpLink, let backupPassword = data.backupPassword else {
//                    self.callBack?.onTotpCreated(result: .failure(.custom(text: "Something went wrong")))
//                    return
//                }
                Prefs.shared.otpId = data.otpID
                Prefs.shared.otpLink = data.otpLink
                Prefs.shared.backupPassword = data.backupPassword
                
                let otpArr = otpLink.components(separatedBy: ":")
                let emailArr = otpArr[2].components(separatedBy: "?")
                let email = emailArr[0]
                let keyArr = emailArr.last!.components(separatedBy: "&").last!.components(separatedBy: "=")
                let key = keyArr.last!
                Prefs.shared.otpLinkKey = key
                Prefs.shared.emailWithKey = email
                print("😳 email - \(email), key \(key)")
                self.callBack?.onTotpCreated(result: .success(data))
            case .failure(let error):
                print(error)
                self.callBack?.onTotpCreated(result: .failure(error))
            }
        })
    }
    
    func activateTotp(code: String) {
        NetManager.shared.activateTotp(code: code) { (result: Result<AuthAccountResponse, APIError>) in
            switch result {
            case .success(let data):
                if let sessionToken = data.session, let accessToken = data.access_token {
                    Prefs.shared.sessionToken = sessionToken
                    Prefs.shared.accessToken = accessToken
                    self.callBack?.onTotpActivated(result: .success(""))
                } else {
                    self.callBack?.onTotpActivated(result: .failure(.custom(text: "OTP code is not valid")))
                }
            case .failure(let error):
                print(error)
                self.callBack?.onTotpActivated(result: .failure(error))
            }
        }
    }
    
    func getApiKey() {
        HUD.shared.show()

            NetManager.shared.getApiKey() { (result: Result<GetApiKeyResponse, APIError>) in

                switch result {
                case .success(let data):
                    print(data)
                
                    if let privateKey = data.private_key, let publicKey = data.public_key {
                        let str = "\(publicKey):\(privateKey)"
                        Prefs.shared.apiKey = str.toBase64()
                        HUD.shared.dismiss()

                        self.callBack?.onGetApiKey()
                    } else {
                        HUD.shared.showError("Email not confirmed. Try again")
////                        self.createWalletCallback?.onAuthAccountFailure(error: .responseUnsuccessful)
                    }
                case .failure(let error):
                    if error.localizedDescription == "No network" {
                        HUD.shared.showError("No network")
                    } else {
                        HUD.shared.showError("Email not confirmed. Try again")
                    }
                }
            }
        }
    
    func resendEmail() {
        HUD.shared.show()
        NetManager.shared.resendEmail(email: Prefs.shared.email, password: Prefs.shared.password) { (result: Result<Int, APIError>) in
            switch result {
            case .success:
                HUD.shared.dismiss()
                self.callBack?.onResendEmailSuccess()
                
            case .failure(let error):
                HUD.shared.showError(error.localizedDescription)
                self.callBack?.onAuthAccountFailure(error: error)
            }
        }
    }
    
}
