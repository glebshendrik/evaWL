//
//  QRPresenter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 18.09.2020.
//

import UIKit

class QRPresenter: BasePresenter<QRViewController, QRRouter>, QRPresenterProtocol {

    func didClickFlashButton() {

    }

    func didClickCloseButton() {
        router?.dismiss()
    }

    func didReadQRCode() {
        router?.dismiss()
    }
}
