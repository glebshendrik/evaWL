//
//  Order.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 27.08.2020.
//

import Foundation

// MARK: - ActiveOrder
struct ActiveOrder: Codable {
    let id: Int
    let clientOrderID, symbol, side, status: String
    let type, timeInForce, quantity, price: String
    let cumQuantity: String
    let postOnly: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case clientOrderID = "clientOrderId"
        case symbol, side, status, type, timeInForce, quantity, price, cumQuantity, postOnly, createdAt, updatedAt
    }
}

typealias ActiveOrders = [ActiveOrder]


struct Order: Codable {
    let error: ErrorCode?
    let id: Int?
    let clientOrderId, symbol, side, status: String?
    let type, timeInForce, quantity, price, avgPrice: String?
    let cumQuantity: String?
    let postOnly: Bool?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, clientOrderId
        case symbol, side, status, type, timeInForce, quantity, price, cumQuantity, postOnly, createdAt, updatedAt, avgPrice, error
    }
}

struct SendToAddressFee : Codable {
    let fee: String?
}

struct WithdrawResponse : Codable {
    let id: String?
    let result: String?
    let error: ErrorCode?
    let code: String?
}

// MARK: - TradingBalanceElement
struct TradingBalanceElement: Codable {
    let currency, available, reserved: String
}

typealias TradingBalance = [TradingBalanceElement]

struct TradingFee: Codable {
    let takeLiquidityRate, provideLiquidityRate: String
}


struct TransferResponse: Codable {
    let id: String?
    let error: ErrorCode?
    let code: String?
}

struct AccountTransaction: Codable {
    let id: String?
    let index: Int?
    let currency, amount, fee, address: String?
    let hash, status, type, createdAt: String?
    let updatedAt: String?
}

typealias AccountTransactions = [AccountTransaction]

struct Trade: Codable {
    let id: Int?
    let clientOrderId: String?
    let orderID: Int?
    let symbol: String?
    let side: String?
    let quantity, price, fee, timestamp: String?
}

typealias Trades = [Trade]

struct Ticker: Codable {
    let symbol, ask, bid, last: String
    let tickerOpen, low, high, volume: String
    let volumeQuote, timestamp: String

    enum CodingKeys: String, CodingKey {
        case symbol, ask, bid, last
        case tickerOpen = "open"
        case low, high, volume, volumeQuote, timestamp
    }
}
