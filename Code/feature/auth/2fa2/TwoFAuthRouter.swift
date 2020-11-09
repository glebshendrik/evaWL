//
//  TwoFAuthRouter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 14.08.2020.
//

import Foundation
import UIKit

class TwoFAuthRouter: BaseControllerRouter {
    
    weak var controller: TwoFAuthViewController?
    
    override func root() -> BaseViewController {
        let view = TwoFAuthViewController.instantiateFromAppStoryboard(.TwoFAuth)
        let navController = BaseNavigaionController(rootViewController: view)
        self.navigationController = navController
        self.controller = view
        view.presenter = TwoFAuthPresenter(view: view, router: self)
        view.presenter.createTotpPresenterViewCallback = view
        return view
    }
 
    func goToSetup2FA(presenter: TwoFAuthPresenter, totpData: TotpResponse) {
        let view = Setup2FAViewController.instantiateFromAppStoryboard(.TwoFAuth)
        view.presenter = presenter
        view.presenter.setup2FAPresenterViewCallback = view
        view.totpData = totpData
        controller?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToSetupPinStart(presenter: TwoFAuthPresenter, authPresenter: AuthPresenter? = nil) {
        guard let router = AppRouter().route(from: .Pincode) else { return }
        guard let view = router.root() as? PincodeViewController else { return }
        (router as? PincodeRouter)?.authPresenter = authPresenter
        view.pincodeMode = .CREATE
        if !(controller?.navigationController?.topViewController is PincodeViewController) {
            controller?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func goToCheckInbox(presenter: TwoFAuthPresenter) {
        let view = CheckInboxViewController.instantiateFromAppStoryboard(.TwoFAuth)
        view.presenterSetup2FA = presenter
        view.presenterSetup2FA?.checkInboxPresenterViewCallback = view
        view.step = 2
        controller?.navigationController?.pushViewController(view, animated: true)
//        super.push(to: view, animated: true)
    }
    
    func goToUpdate2FASession(controller: UIViewController?) {
        let view = Update2FASessionViewController.instantiateFromAppStoryboard(.TwoFAuth)
        if controller?.navigationController?.topViewController != view {
            controller?.navigationController?.present(view, animated: true, completion: nil)
        }
    }
}
