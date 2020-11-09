//
//  Wallet.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 19.07.2020.
//

import Foundation

class Wallet: Codable, Equatable {
    static func == (lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.currencyBalance?.currency == rhs.currencyBalance?.currency && lhs.price == rhs.price
    }
    
    //var hidden: Bool?
    var price: String?
    var balanceInBtc: String?
    var currencyFullname: String?
    var precision: Int?
    var change24H: Double?
    var payoutIsPaymentID: Bool?
    var isCrypto: Bool?
    var currencyBalance: CurrencyBalance?
    var currencyAddress: CurrencyAddress?
    
    init(currency: CurrencyBalance) {
        //self.hidden = hidden
        self.currencyBalance = currency
    }
    
    init(currencyFullname: String) {
        //self.hidden = hidden
        self.currencyFullname = currencyFullname
    }
    
    
//    init(deletable: Bool, hideble: Bool, id: String) {
//        self.deletable = deletable
//        self.hideble = hideble
//        self.id = id
//    }
//    
//    init(isCoin: Bool, isFeatured: Bool, isToken: Bool, id: String, name: String) {
//        self.isCoin = isCoin
//        self.isFeatured = isFeatured
//        self.isToken = isToken
//        self.name = name
//    }
}
