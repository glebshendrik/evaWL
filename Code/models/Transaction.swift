//
//  Transaction.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 29.07.2020.
//

import Foundation

typealias TransactionsResponsee = [Transaction]

//api.multiexchange.com/api/2/account/transactions

//PARAMS
//currency    String    Currency code
//sort    String    Sort direction
//Accepted values: DESC, ASC
//Default value: DESC
//by    String    Defines filter type
//Accepted values: timestamp or index
//Default value timestamp
//from    Datetime or Number    Interval initial value (optional parameter)
//If sorting by timestamp is used, then Datetime, otherwise Number of index value.
//till    Datetime or Number    Interval end value (optional parameter)
//If sorting by timestamp is used, then Datetime, otherwise Number of index value.
//limit    Number    Default value: 100
//Max value: 1000
//offset    Number    Default value: 0
//Max value: 100000
//showSenders    Boolean    Default value: false
//Show senders addresses for payins
//

//{
//  "id": "6a2fb54d-7466-490c-b3a6-95d8c882f7f7",
//  "index": 20400458,
//  "currency": "ETH",
//  "amount": "38.616700000000000000000000",
//  "fee": "0.000880000000000000000000",
//  "address": "0xfaEF4bE10dDF50B68c220c9ab19381e20B8EEB2B",
//  "hash": "eece4c17994798939cea9f6a72ee12faa55a7ce44860cfb95c7ed71c89522fe8",
//  "status": "pending",
//  "type": "payout",
//  "createdAt": "2017-05-18T18:05:36.957Z",
//  "updatedAt": "2017-05-18T19:21:05.370Z",
//  "confirmations": 0
//}

// MARK: - Transaction
class Transaction: Codable {
    var id: String?
    var index: Int?
    var currency, amount, fee, address: String?
    var hash, status, type, createdAt: String?
    var updatedAt: String?
    var confirmations: Int?
    
    var clientOrderId: String?
    var symbol: String?
    var fromCurrency: String?
    var toCurrency: String?
    var side: String?
    var timeInForce: String?
    var quantity: String?
    var price: String?
    var avgPrice: String?
    var cumQuantity: String?
    var timestamp: String?
    var paymentId: String?
    
    public init(id: String?, index: Int?, currency: String?, amount: String?, hash: String?, status: String?, type: String?, createdAt: String?, fee: String?, address: String?, updatedAt: String?, confirmations: Int?, clientOrderId: String?, symbol: String?, fromCurrency: String?, toCurrency: String?, side: String?, timeInForce: String?, quantity: String?, price: String?, avgPrice: String?, cumQuantity: String?, timestamp: String?, paymentId: String?) {
        self.id = id
        self.index = index
        self.currency = currency
        self.amount = amount
        self.fee = fee
        self.address = address
        self.hash = hash
        self.status = status
        self.type = type
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.confirmations = confirmations
        self.clientOrderId = clientOrderId
        self.symbol = symbol
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.side = side
        self.timeInForce = timeInForce
        self.quantity = quantity
        self.price = price
        self.avgPrice = avgPrice
        self.cumQuantity = cumQuantity
        self.timestamp = timestamp
        self.paymentId = paymentId
    }

    func getWhen() -> String {
        guard let createdDate = self.createdAt else { return "" }
        guard let splitterDate = createdDate.split(separator: "T")[safe: 0]?.description else { return "" }
        return splitterDate
    }
    
    func getWhenFull() -> String {
        guard let createdDate = self.createdAt else { return "" }
        let dateFormatterFrom = DateFormatter()
        dateFormatterFrom.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterFrom.locale = NSLocale.current
        dateFormatterFrom.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = createdDate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression).replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "")
        let date = dateFormatterFrom.date(from: dateString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formattedDate = dateFormatter.string(from: date!).uppercased()
        return formattedDate
    }
    
    func getWhenFullFormatted() -> String {
        guard let createdDate = self.createdAt else { return "" }
        let dateFormatterFrom = DateFormatter()
        dateFormatterFrom.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterFrom.locale = NSLocale.current
        dateFormatterFrom.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = createdDate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression).replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "")
        let date = dateFormatterFrom.date(from: dateString)
        
        let dateFormatter = DateFormatter()
      //  dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM d, yyyy, h:mm a"
        
        let formattedDate = dateFormatter.string(from: date!).uppercased()
        return formattedDate
    }
    
    func getUpdatedAt() -> String? {
        guard let updatedAt = self.updatedAt else { return nil }
        let dateFormatterFrom = DateFormatter()
        dateFormatterFrom.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterFrom.locale = NSLocale.current
        dateFormatterFrom.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = updatedAt.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression).replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "")
        let date = dateFormatterFrom.date(from: dateString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formattedDate = dateFormatter.string(from: date!).uppercased()
        return formattedDate
    }
    
    func getStatus() -> TransactionStatus? {
        guard let status = self.status else { return nil }
        return TransactionStatus(rawValue: status)
    }
    
    func getType() -> TransactionType? {
        guard let status = self.type else { return nil }
        return TransactionType(rawValue: status)
    }
    
    func getMaxConfirmationsCount() -> Int {
        let currencies = StaticCurrenciesLoader.shared.currencies
        let currency = currencies.first { $0.id == self.currency }
        return currency?.payinConfirmations ?? -1
    }
}

enum TransactionStatus: String {
    case created, pending, failed, success, new
}

enum TransactionType: String {
    case payout, payin, bankToExchange, withdraw, deposit, exchangeToBank, limit
}

struct AddressCurrency: Codable {
    let address, publicKey: String?
    let error: ErrorCode?
}


struct SendOffchainCheckResponse: Codable {
    let result: Bool
}
