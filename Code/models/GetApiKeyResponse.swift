//
//  GetApiKeyResponse.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 28.07.2020.
//

import Foundation

// MARK: - AuthAccountResponse
struct GetApiKeyResponse: Codable {
    let private_key: String?
    let public_key: String?
}
