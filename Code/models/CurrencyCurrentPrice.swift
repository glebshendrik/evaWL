//
//  CurrencyCurrentPrice.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 30.09.2020.
//

import Foundation

struct CurrencyCurrentPrice: Codable {
    let curr: String?
    let unit: String?
    let price: Double?
    let ts: String?
    let code: Int?
}
