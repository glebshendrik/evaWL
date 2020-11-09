//
//  TwoFAuthPresenter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 14.08.2020.
//

import Foundation

class TwoFAuthPresenter: BasePresenter<TwoFAuthViewController, TwoFAuthRouter> {
    
    private lazy var interactor: TwoFAuthInteractor = {
        return TwoFAuthInteractor(callBack: self)
    }()
    
    weak var setup2FAPresenterViewCallback: Setup2FAPresenterViewCallback?
    weak var createTotpPresenterViewCallback: CreateTotpPresenterViewCallback?
    weak var checkInboxPresenterViewCallback: CheckInboxPresenterViewCallback?
    
    private var presenter: AuthPresenter?
    
    func openSetup2FA(_ totpData: TotpResponse) {
        router?.goToSetup2FA(presenter: self, totpData: totpData)
    }
    
    func openSecureAccount(presenter: AuthPresenter? = nil) {
        //        router!.goToSetup2FA()
        self.presenter = presenter
        interactor.getApiKey()
    }
    
    func getApiKey() {
        interactor.getApiKey()
    }
    
    func createTotp() {
        interactor.createTotp()
    }
    
    func activateTotp(code: String) {
        interactor.activateTotp(code: code)
    }
    
    func goToCheckInbox() {
        router?.goToCheckInbox(presenter: self)
    }
    
    func onResendEmail() {
        interactor.resendEmail()
    }
    
}

extension TwoFAuthPresenter: TwoFAuthInteractorCallback {
    func onResendEmailSuccess() {
        checkInboxPresenterViewCallback?.onResendEmailSuccess()
    }
    
    func onAuthAccountFailure(error: APIError) {
        
    }
    
    func onTotpCreated(result: Result<TotpResponse, APIError>) {
        switch result {
        case .success(let data):
            createTotpPresenterViewCallback?.onTotpCreatedSuccess(response: data)
        case .failure(let error):
            createTotpPresenterViewCallback?.onTotpCreatedFailure(error)
        }
        
    }
    
    func onGetApiKey() {
        router?.goToSetupPinStart(presenter: self, authPresenter: presenter)
    }
    
    func onTotpActivated(result: Result<String, APIError>) {
        switch result {
        case .success(_):
            setup2FAPresenterViewCallback?.onActivate2FASuccess()
        case .failure(let error):
            print(error)
            setup2FAPresenterViewCallback?.onActivate2FAFailure(error)
        }
    }
    
    
    
}

