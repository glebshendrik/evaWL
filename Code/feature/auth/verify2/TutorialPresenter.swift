//
//  TutorialPresenter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 21.08.2020.
//

import Foundation

class TutorialPresenter: BasePresenter<TutorSecureViewController, TutorialRouter> {
    
    func on2FASetup() {
        router?.open2FASetup()
    }
    
    func onNotRightNow() {
       router?.openMainScreen()
    }
    
    func onDone() {
        router?.openMainScreen()
    }
    
    func openKYC() {
        router?.openKYC()
    }
    
}
