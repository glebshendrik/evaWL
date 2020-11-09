//
//  AppDelegate.swift
//  Tmp
//
//  Created by Gleb Shendrik on 06.07.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appStateListener = AppStateListener.shared
    
    var appRouter = AppRouter()
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        StaticCurrenciesLoader.shared.fetchCurrencies()
        
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if Prefs.shared.apiKey.isEmpty {
            self.window?.rootViewController = appRouter.route(from: .Auth)?.root()
        } else {
            self.window?.rootViewController = appRouter.route(from: .Main)?.root()
        }
        
        //  self.window?.rootViewController = appRouter.route(from: .Main)?.root()

        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Prefs.shared.isBiometricSuccess = false
        Prefs.shared.dateEnterBackground = Date().addingTimeInterval(120)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if Prefs.shared.dateEnterBackground ?? Date() <= Date() {
            appStateListener.applicationDidBecomeActive(application)
        }
    }
    
}

