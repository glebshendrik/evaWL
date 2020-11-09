//
//  CryptoCurrency.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 29.07.2020.
//

import Foundation

//{
//   "id": "BTC",
//   "fullName": "Bitcoin",
//   "crypto": true,
//   "payinEnabled": true,
//   "payinPaymentId": false,
//   "payinConfirmations": 2,
//   "payoutEnabled": true,
//   "payoutIsPaymentId": false,
//   "transferEnabled": true,
//   "delisted": false,
//   "payoutFee": "0.00958",
//   "payoutMinimalAmount": "0.00958",
//   "precisionPayout": 10,
//   "precisionTransfer": 10
//}

// MARK: - CryptoCurrency
class CryptoCurrency: Codable {
    var id, fullName: String?
    var crypto, payinEnabled, payinPaymentID: Bool?
    var payinConfirmations: Int?
    var payoutEnabled, payoutIsPaymentID, transferEnabled, delisted: Bool?
    var payoutFee, payoutMinimalAmount: String?
    var precisionPayout, precisionTransfer: Int?

    enum CodingKeys: String, CodingKey {
        case id, fullName, crypto, payinEnabled
        case payinPaymentID = "payinPaymentId"
        case payinConfirmations, payoutEnabled
        case payoutIsPaymentID = "payoutIsPaymentId"
        case transferEnabled, delisted, payoutFee, payoutMinimalAmount, precisionPayout, precisionTransfer
    }

    init(id: String?, fullName: String?, crypto: Bool?, payinEnabled: Bool?, payinPaymentID: Bool?, payinConfirmations: Int?, payoutEnabled: Bool?, payoutIsPaymentID: Bool?, transferEnabled: Bool?, delisted: Bool?, payoutFee: String?, payoutMinimalAmount: String?, precisionPayout: Int?, precisionTransfer: Int?) {
        self.id = id
        self.fullName = fullName
        self.crypto = crypto
        self.payinEnabled = payinEnabled
        self.payinPaymentID = payinPaymentID
        self.payinConfirmations = payinConfirmations
        self.payoutEnabled = payoutEnabled
        self.payoutIsPaymentID = payoutIsPaymentID
        self.transferEnabled = transferEnabled
        self.delisted = delisted
        self.payoutFee = payoutFee
        self.payoutMinimalAmount = payoutMinimalAmount
        self.precisionPayout = precisionPayout
        self.precisionTransfer = precisionTransfer
    }
}
