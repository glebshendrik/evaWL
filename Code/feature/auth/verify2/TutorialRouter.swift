//
//  TutorialRouter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 21.08.2020.
//

import Foundation

class TutorialRouter: BaseControllerRouter {
    
    weak var controller: TutorSecureViewController?
    
    override func root() -> BaseViewController {
        let view = TutorSecureViewController.instantiateFromAppStoryboard(.Auth)
        let navController = BaseNavigaionController(rootViewController: view)
        self.navigationController = navController
        self.controller = view
        view.presenter = TutorialPresenter(view: view, router: self)
        return view
    }
 
    func goToSetup2FA(presenter: TwoFAuthPresenter) {
        let view = Setup2FAViewController.instantiateFromAppStoryboard(.TwoFAuth)
        view.presenter = presenter
        presenter.setup2FAPresenterViewCallback = view
        
        controller?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToSetupPinStart(presenter: TwoFAuthPresenter, authPresenter: AuthPresenter? = nil) {
//        guard let view = AppRouter().route(from: .Pincode)?.root() else { return }
//        (view as? PincodeViewController)?.pincodeMode = .CREATE
//
//        controller?.navigationController?.pushViewController(view, animated: true)
        
        guard let router = AppRouter().route(from: .Pincode) else { return }
        guard let view = router.root() as? PincodeViewController else { return }
        (router as? PincodeRouter)?.authPresenter = authPresenter
        view.pincodeMode = .CREATE
//        super.push(to: view as BaseViewController, animated: true)
        controller?.navigationController?.pushViewController(view, animated: true)
    }
    
    func openMainScreen() {
        AppRouter().openMainScreen()
    }
    
    func openKYC() {
        AppRouter().openKyc()
    }
    
    func open2FASetup(presenter: AuthPresenter? = nil) {
        guard let view = AppRouter().route(from: .TwoFAuth)?.root() else { return }
        controller?.navigationController?.pushViewController(view, animated: true)
//        super.push(to: view as! BaseViewController, animated: true)
    }
    
    func openPincode() {
        guard let router = AppRouter().route(from: .Pincode) else { return }
        guard let view = router.root() as? PincodeViewController else { return }
        view.pincodeMode = .NOTRIGHTNOW
        view.isPincodeAskedOnEnter = true
        view.modalPresentationStyle = .fullScreen
        controller?.navigationController?.present(view, animated: false, completion: {
            
        })
    }
}
