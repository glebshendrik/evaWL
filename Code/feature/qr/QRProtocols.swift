//
//  QRProtocols.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 18.09.2020.
//

import Foundation

// MARK: Wireframe - route UI
protocol QRWireframeProtocol: class {

    /// Seque to Enter Address screen
    func dismiss()
}

// MARK: Presenter - provide route UI to router
protocol QRPresenterProtocol: class {

    /// Route to Enter Address VC
    func didReadQRCode()
    func didClickCloseButton()
}

// MARK: View - scan QR-code blockchain-address
protocol QRViewProtocol: class {

  var presenter: QRPresenterProtocol? { get set }
}
