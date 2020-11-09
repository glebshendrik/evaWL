//
//  TwoFAuthViewController.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 14.08.2020.
//

import UIKit

protocol TwoFAuthView: ViewProtocol {
    
}

protocol CreateTotpPresenterViewCallback: class {
    func onTotpCreatedSuccess(response: TotpResponse)
    func onTotpCreatedFailure(_ error: APIError)
}

class TwoFAuthViewController: BaseViewController {

    var presenter: TwoFAuthPresenter!
    
    @IBOutlet weak var infoNavbar: UINavigationBar! {
        didSet {
            self.infoNavbar.setBackgroundImage(UIImage(), for: .default)
            self.infoNavbar.shadowImage = UIImage()
            self.infoNavbar.isTranslucent = true
            self.infoNavbar.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapBeginSetup(_ sender: Any) {
        HUD.shared.show()
        presenter?.createTotp()
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension TwoFAuthViewController: CreateTotpPresenterViewCallback {
    func onTotpCreatedSuccess(response: TotpResponse) {
        presenter.openSetup2FA(response)
        HUD.shared.dismiss()
    }
    
    func onTotpCreatedFailure(_ error: APIError) {
        self.showError("Something went wrong")
    }
    
    
}
 

extension TwoFAuthViewController: TwoFAuthView {
    
}
