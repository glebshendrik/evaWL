//
//  AppStateListner.swift
//  Tmp
//
//  Created by Gleb Shendrik on 06.07.2020.
//

import Foundation
import UIKit
import RxSwift

class AppStateListener: NSObject {
    
    static let shared = AppStateListener()
    
    private var disposableBag = DisposeBag()
    private var state = PublishSubject<UIApplication.State>()

    func subscribe(_ on: @escaping (Event<UIApplication.State>) -> Void) {
        self.state.subscribe(on).disposed(by: self.disposableBag)
    }
    
    func unsubscribe() {
        self.state.dispose()
    }
}

extension AppStateListener: UIApplicationDelegate  {
    func applicationDidEnterBackground(_ application: UIApplication) {
        state.onNext(application.applicationState)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        state.onNext(application.applicationState)
    }
}
