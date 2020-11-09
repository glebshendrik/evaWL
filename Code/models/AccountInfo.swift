//
//  AccountInfo.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 12.10.2020.
//

import Foundation

struct AccountInfo: Codable {
    let company: Company?
    let externalId: String?
    let isFiatAllowed: Bool?

    enum CodingKeys: String, CodingKey {
        case company
        case externalId = "external_id"
        case isFiatAllowed = "is_fiat_allowed"
    }
}

struct Company: Codable {
    let isInstitutional: Bool?

    enum CodingKeys: String, CodingKey {
        case isInstitutional = "is_institutional"
    }
}
