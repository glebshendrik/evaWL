//
//  Prefs.swift
//  Tmp
//
//  Created by Gleb Shendrik on 06.07.2020.
//

import Foundation

class Prefs {
    static var shared = Prefs()
    
    enum KEYS: String {
        case NOTIFICATIONS_KEY = "NOTIFICATIONS_KEY"
        case UUID = "UUID"
        case TOKEN = "TOKEN"
        case USERLANG = "USERLANG"
        case PASSCODE = "PASSCODE"
        case PASSCODEENABLED = "PASSCODEENABLED"
        case TOUCHIDENABLED = "TOUCHIDENABLED"
        case ISHIDDENSECTIONSHOWN = "ISHIDDENSECTIONSHOWN"
        case ISDONTSHOWREMOVEWALLET = "ISDONTSHOWREMOVEWALLET"
        case SESSIONTOKEN = "SESSIONTOKEN"
        case ACCESSTOKEN = "ACCESSTOKEN" // BEARER
        case KYCSTATUS = "KYCSTATUS"
        case EMAIL = "EMAIL"
        case PASSWORD = "PASSWORD"
        case OTPID = "OTPID"
        case OTPLINK = "OTPLINK"
        case BACKUPPASSWORD = "BACKUPPASSWORD"
        case EMAILWITHKEY = "EMAILWITHKEY"
        case OTPLINKKEY = "OTPLINKKEY"
        case OTPLINKFULL = "OTPLINKFULL"
        case APIKEY = "APIKEY"
        case LASTTRANSFERID = "LASTTRANSFERID"
        case USERNAME = "USERNAME"
        case PHONE = "PHONE"
        case KYCDECLINE_REASON = "KYCDECLINE_REASON"
        case KYCNOTYETREASON = "KYCNOTYETREASON"
        case IS_PHONE_CONFIRMED = "IS_PHONE_CONFIRMED"
        case IS_BIOMETRIC_ON = "IS_BIOMETRIC_ON"
        case IS_BIOMETRIC_SUCCESS = "IS_BIOMETRIC_SUCCESS"
        case TIME_TO_ASK_PIN = "TIME_TO_ASK_PIN"
        case DATE_ENTER_BACKGROUND = "DATE_ENTER_BACKGROUND"
        case AVATAR_SETTINGS = "AVATAR_SETTINGS"
        case OPEN_AFTER_LOGIN = "OPEN_AFTER_LOGIN"
        case NOT_RIGHT_NOW = "NOT_RIGHT_NOW"
        case KR = "KR"
        case LAST_SELECTED_DOC_TYPE = "LAST_SELECTED_DOC_TYPE"
        case IS_FIAT_ALLOWED = "IS_FIAT_ALLOWED"
        case CURRENCIES = "CURRENCIES"
    }
    
    func clear() {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
        KycManager.shared.currentRequest = KycRequest()
    }
    
    var TOKEN: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.TOKEN.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.TOKEN.rawValue) }
    }
    
    var UUID: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.UUID.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.UUID.rawValue) }
    }
    
    var isNotificationsAllowed: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.NOTIFICATIONS_KEY.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.NOTIFICATIONS_KEY.rawValue) }
    }
    
    var USERLANG: AppLocalization {
        get {
            return AppLocalization.fromString(UserDefaults.standard.string(forKey: Prefs.KEYS.USERLANG.rawValue))
        }
        set (newValue) { UserDefaults.standard.set(newValue.describing(), forKey: Prefs.KEYS.USERLANG.rawValue) }
    }
    
    var passCode: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.PASSCODE.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.PASSCODE.rawValue) }
    }
    
    var isPasscodeEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.PASSCODEENABLED.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.PASSCODEENABLED.rawValue) }
    }
    
    var isTouchIDEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.TOUCHIDENABLED.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.TOUCHIDENABLED.rawValue) }
    }
    
    var isPhoneConfirmed: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.IS_PHONE_CONFIRMED.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.IS_PHONE_CONFIRMED.rawValue) }
    }
 
    var isHiddenSectionShown: Any? {
        get { return UserDefaults.standard.object(forKey: Prefs.KEYS.ISHIDDENSECTIONSHOWN.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.ISHIDDENSECTIONSHOWN.rawValue) }
    }
    
    var isDontShowRemoveWallet: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.ISDONTSHOWREMOVEWALLET.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.ISDONTSHOWREMOVEWALLET.rawValue) }
    }
    
    var sessionToken: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.SESSIONTOKEN.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.SESSIONTOKEN.rawValue) }
    }
    
    var accessToken: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.ACCESSTOKEN.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.ACCESSTOKEN.rawValue) }
    }
    
    var kycStatus: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.KYCSTATUS.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.KYCSTATUS.rawValue) }
    }
    
    var email: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.EMAIL.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.EMAIL.rawValue) }
    }
    
    var kycDeclineReason: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.KYCDECLINE_REASON.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.KYCDECLINE_REASON.rawValue) }
    }
    
    var kycNotYetReason: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.KYCNOTYETREASON.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.KYCNOTYETREASON.rawValue) }
    }
    
    var phone: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.PHONE.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.PHONE.rawValue) }
    }
    
    var username: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.USERNAME.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.USERNAME.rawValue) }
    }
    
    var password: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.PASSWORD.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.PASSWORD.rawValue) }
    }
    
    var otpId: Int {
        get { return UserDefaults.standard.integer(forKey: Prefs.KEYS.OTPID.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.OTPID.rawValue) }
    }
    
    var otpLink: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.OTPLINK.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.OTPLINK.rawValue) }
    }
    
    var backupPassword: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.BACKUPPASSWORD.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.BACKUPPASSWORD.rawValue) }
    }
    
    var emailWithKey: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.EMAILWITHKEY.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.EMAILWITHKEY.rawValue) }
    }
    
    var otpLinkKey: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.OTPLINKKEY.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.OTPLINKKEY.rawValue) }
    }
    
    var otpLinkFull: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.OTPLINKFULL.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.OTPLINKFULL.rawValue) }
    }
    
    var apiKey: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.APIKEY.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.APIKEY.rawValue) }
    }
    
    var lastTransferId: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.LASTTRANSFERID.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.LASTTRANSFERID.rawValue) }
    }
    
    var isBiometricOn: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.IS_BIOMETRIC_ON.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.IS_BIOMETRIC_ON.rawValue) }
    }

    var isBiometricSuccess: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.IS_BIOMETRIC_SUCCESS.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.IS_BIOMETRIC_SUCCESS.rawValue) }
    }
    
    var timeToAskPin: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.TIME_TO_ASK_PIN.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.TIME_TO_ASK_PIN.rawValue) }
    }
    
    var avatarSettings: URL? {
        get { return UserDefaults.standard.url(forKey: Prefs.KEYS.AVATAR_SETTINGS.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.AVATAR_SETTINGS.rawValue) }
    }
    
    var dateEnterBackground: Date? {
        get { return UserDefaults.standard.object(forKey: Prefs.KEYS.DATE_ENTER_BACKGROUND.rawValue) as? Date}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.DATE_ENTER_BACKGROUND.rawValue) }
    }
    
    var openAfterLogin: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.OPEN_AFTER_LOGIN.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.OPEN_AFTER_LOGIN.rawValue) }
    }
    
    var notRightNow: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.NOT_RIGHT_NOW.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.NOT_RIGHT_NOW.rawValue) }
    }
    
    var kycRequest: Data? {
        get { return UserDefaults.standard.data(forKey: Prefs.KEYS.KR.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.KR.rawValue) }
    }
    
    var docType: String {
        get { return UserDefaults.standard.string(forKey: Prefs.KEYS.LAST_SELECTED_DOC_TYPE.rawValue) ?? "" }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.LAST_SELECTED_DOC_TYPE.rawValue) }
    }
    
    var isFiatAllowed: Bool {
        get { return UserDefaults.standard.bool(forKey: Prefs.KEYS.IS_FIAT_ALLOWED.rawValue)}
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.IS_FIAT_ALLOWED.rawValue) }
    }
    
    var currencies: Data? {
        get { return UserDefaults.standard.data(forKey: Prefs.KEYS.CURRENCIES.rawValue) }
        set (newValue) { UserDefaults.standard.set(newValue, forKey: Prefs.KEYS.CURRENCIES.rawValue) }
    }
}

