//
//  Currency.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 29.07.2020.
//

import Foundation


struct CurrenciesList: Codable {
    let currencies: [Currency]?
    
    func archived() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static func unarchive(_ data: Data) -> [Currency]? {
        return try? JSONDecoder().decode([Currency].self, from: data)
    }
}
// MARK: - Currency
struct Currency: Codable, Equatable {
    let id, fullName: String?
    let crypto, payinEnabled, payinPaymentID: Bool?
    let payinConfirmations: Int?
    let payoutEnabled, payoutIsPaymentID, transferEnabled, delisted: Bool?
    let payoutFee, payoutMinimalAmount: String?
    let precisionPayout, precisionTransfer: Int?
    let avgProcessingTime: String?

    enum CodingKeys: String, CodingKey {
        case id, fullName, crypto, payinEnabled
        case payinPaymentID = "payinPaymentId"
        case payinConfirmations, payoutEnabled
        case payoutIsPaymentID = "payoutIsPaymentId"
        case transferEnabled, delisted, payoutFee, payoutMinimalAmount, precisionPayout, precisionTransfer
        case avgProcessingTime
    }
}

//struct CurrencyPriceHistoryItem: Codable {
//    let timestamp, open, close, min: String?
//    let max, volume, volumeQuote: String?
//
//    enum CodingKeys: String, CodingKey {
//        case timestamp
//        case open
//        case close, min, max, volume, volumeQuote
//    }
//}

struct CurrencyPriceHistoryItem: Codable {
    let price: Double?
    let ts: String?
}

struct CurrencyWithPrice: Codable {
    let symbol, ask, bid, last: String?
    let low, high, welcomeOpen, volume: String?
    let volumeQuote, timestamp: String?

    enum CodingKeys: String, CodingKey {
        case symbol, ask, bid, last, low, high
        case welcomeOpen = "open"
        case volume, volumeQuote, timestamp
    }
}

struct CurrencyBalance: Codable {
    let currency, available, reserved: String?
}

struct CurrencyAddress: Codable {
    let address, currency, paymentId: String?
}

struct LastTenCurrencyAddress: Codable {
    let address, publicKey, paymentId: String?
}

struct FiatCurrencyExternalId: Codable {
    let externalId: String?
    let ticker: String?
    
    enum CodingKeys: String, CodingKey {
        case externalId = "external_id"
        case ticker
    }
}

struct BaseQuoteCurrency: Codable {
    let error: ErrorCode?
    let id, baseCurrency, quoteCurrency, quantityIncrement: String?
    let tickSize, takeLiquidityRate, provideLiquidityRate, feeCurrency: String?
}

struct ErrorCode: Codable {
    let code: Int?
    let description: String?
    let message: String?
}
