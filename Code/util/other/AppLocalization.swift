//
//  AppLocalizations.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 07.07.2020.
//

import Foundation
import UIKit

enum AppLocalization: String, CaseIterable {
    case ENGLISH = "English - English"
    case CHINA_SIMPLE = "Chinese-S - 简体中文"
    case CHINA_TRADITIONAL = "Chinese-T - 繁體中文"
    case RUSSIAN = "Russian - Русский"
//    case JAPANESE = "Japanese - 日本語"
    case KOREAN = "Korean - 한국어"
    case PORTUGUESE = "Portuguese - Português"
    case SPANISH = "Spanish - Español"
    case GERMAN = "German - Deutsch"
    case FRENCH = "French - Français"
    case ITALIAN = "Italian - Italiano"
    case DEFAULT
}

extension AppLocalization {
    var code: String {
           switch self {
           case .ENGLISH: return "en"
           case .CHINA_SIMPLE: return "zh-Hans"
           case .CHINA_TRADITIONAL: return "zh-Hant"
           case .RUSSIAN: return "ru"
           //case .JAPANESE: return "ja"
           case .KOREAN: return "ko"
           case .PORTUGUESE: return "pt-BR"
           case .SPANISH: return "es"
           case .GERMAN: return "de"
           case .ITALIAN: return "it"
           case .FRENCH: return "fr"
           case .DEFAULT:
           return ""
        }
       }
}

extension AppLocalization {
    func describing() -> String {
        return String(describing: self)
    }
}

extension AppLocalization {
    static func fromString(_ lang: String?) -> AppLocalization {
        guard let languageString = lang else { return .ENGLISH }
        return AppLocalization.allCases.first { $0.describing() == languageString } ?? .DEFAULT
    }
    
    static func getList() -> [AppLocalization] {
        return AppLocalization.allCases.dropLast() //drops Default value
    }
}

class AppLocalizationManager {
    static let shared = AppLocalizationManager()
    
    func getUserLang() -> AppLocalization {
        return Prefs.shared.USERLANG
    }
    
    func setUserLang(_ lang: AppLocalization) {
        Bundle.setLanguage(lang.code)
        Prefs.shared.USERLANG = lang
    }
}
