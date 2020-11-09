//
//  MarketRate.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 03.09.2020.
//

import Foundation

struct MarketRate: Codable {
    let curr: String?
    let marketCap, change1H, change24H: Double?
}
