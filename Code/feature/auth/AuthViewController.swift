//
//  AuthViewController.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 07.07.2020.
//

import UIKit

protocol AuthView: ViewProtocol {
    
}

class AuthViewController: BaseViewController {
    
    var presenter: AuthPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginViaFacebook(_ sender: Any) {
        presenter.loginViaFacebook()
    }
    
    @IBAction func onLoginViaGoogle(_ sender: Any) {
        presenter.loginViaGoogle()
    }
    
    @IBAction func onLoginViaMobile(_ sender: Any) {
        presenter.loginViaMobile()
    }
    
    @IBAction func onLoginViaMail(_ sender: Any) {
        presenter.loginViaMail()
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        presenter.signIn()
    }
}

extension AuthViewController: AuthView {
    
}
