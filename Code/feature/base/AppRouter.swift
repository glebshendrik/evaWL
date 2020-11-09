//
//  AppRouter.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 06.07.2020.
//

import Foundation
import UIKit

enum ScreenFlow: String {
    case Main, Auth, ResetPassword, Pincode, Wallets, AddWallets, WalletDashboard, Send, SendToAddress, SendDetail, Receive, History, Limit, EmailConfirm, About, LimitDetail, LimitChange, ChangePass, Settings, Account, Security, Sessions, Preferences, Exchange, Kyc, TwoFAuth, Tutorial, QR, ContactSupport
}

class AppRouter {
    
    private let appRootNavigationController = BaseNavigaionController()
    
    func route(from flow: ScreenFlow) -> ControllerRouterProtocol? {
        switch flow {
        case .Main:
            return MainRouter(navigationController: self.appRootNavigationController)
        case .Auth:
            return AuthRouter(navigationController: self.appRootNavigationController)
        case .ResetPassword:
            return ResetPasswordRouter(navigationController: self.appRootNavigationController)
        case .Pincode:
            return PincodeRouter(navigationController: self.appRootNavigationController)
        case .Wallets:
            return WalletsRouter(navigationController: self.appRootNavigationController)
        case .AddWallets:
            return AddWalletsRouter(navigationController: self.appRootNavigationController)
        case .WalletDashboard:
            return WalletDashboardRouter(navigationController: self.appRootNavigationController)
        case .Send:
            return SendRouter(navigationController: self.appRootNavigationController)
        case .SendDetail:
            return SendDetailRouter(navigationController: self.appRootNavigationController)
        case .SendToAddress:
            return SendToAddressRouter(navigationController: self.appRootNavigationController)
        case .Receive:
            return ReceiveRouter(navigationController: self.appRootNavigationController)
        case .Settings:
            return SettingsRouter(navigationController: self.appRootNavigationController)
        case .Account:
            return AccountRouter(navigationController: self.appRootNavigationController)
        case .Security:
            return SecurityRouter(navigationController: self.appRootNavigationController)
        case .ChangePass:
            return ChangePassRouter(navigationController: self.appRootNavigationController)
        case .Sessions:
            return SessionsRouter(navigationController: self.appRootNavigationController)
        case .Preferences:
            return PreferencesRouter(navigationController: self.appRootNavigationController)
        case .Limit:
            return LimitRouter(navigationController: self.appRootNavigationController)
        case .LimitDetail:
            return LimitDetailRouter(navigationController: self.appRootNavigationController)
        case .LimitChange:
            return LimitChangeRouter(navigationController: self.appRootNavigationController)
        case .About:
            return AboutRouter(navigationController: self.appRootNavigationController)
        case .EmailConfirm:
            return EmailConfirmRouter(navigationController: self.appRootNavigationController)
        case .Exchange:
            return ExchangeRouter(navigationController: self.appRootNavigationController)
        case .Kyc:
            return KycRouter(navigationController: self.appRootNavigationController)
        case .TwoFAuth:
            return TwoFAuthRouter(navigationController: self.appRootNavigationController)
        case .Tutorial:
            return TutorialRouter(navigationController: self.appRootNavigationController)
        case .QR:
            return QRRouter(navigationController: self.appRootNavigationController)
        case .ContactSupport:
            return ContactSupportRouter(navigationController: self.appRootNavigationController)
        default:
            return nil
        }
    }
    
    func openMainScreen() {
        getAppDelegate().window?.rootViewController = self.route(from: .Main)?.root()
    }
    
    func openKyc() {
        let root = self.route(from: .Main)?.root()
        getAppDelegate().window?.rootViewController = root
        
//        let settings = AppRouter().route(from: .Settings)?.root()
//        (root as? UINavigationController)?.pushViewController(settings!, animated: true)
//
//        let account = AppRouter().route(from: .Account)?.root()
        let kyc = KycPersonalViewController.instantiateFromAppStoryboard(.Kyc)
        (root as? UINavigationController)?.pushViewController(kyc, animated: true)
    }
    
    func logout() {
        getAppDelegate().window?.rootViewController = (self.route(from: .Auth) as? AuthRouter)?.rootAfterLogout()
    }
}
