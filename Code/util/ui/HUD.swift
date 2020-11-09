//
//  HUD.swift
//  Tmp
//
//  Created by Gleb Shendrik on 06.07.2020.
//

import Foundation
import SVProgressHUD

class HUD {
    
    static let shared = HUD()
    
    private init() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setRingThickness(10)
        SVProgressHUD.setHapticsEnabled(true)
    }
    
    func show() {
        SVProgressHUD.show()
    }
    
    func showError(_ error: String) {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            SVProgressHUD.showError(withStatus: error)
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        HUD.shared.dismiss()
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
        }))
        topController.present(alert, animated: true, completion: nil)
        
    }
    
    func showSuccess(_ msg: String? = nil) {
        SVProgressHUD.showSuccess(withStatus: msg)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    func dismiss() {
        SVProgressHUD.dismiss()
    }
}

