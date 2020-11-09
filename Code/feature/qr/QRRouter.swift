//
//  QRRouter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 18.09.2020.
//

import UIKit

class QRRouter: BaseControllerRouter, QRWireframeProtocol {
    
    weak var controller: QRViewController?
    
    override func root() -> BaseViewController {
        let view = QRViewController.instantiateFromAppStoryboard(.QR)
        self.controller = view
        view.presenter = QRPresenter(view: view, router: self)
        return view
    }

    func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }
}
