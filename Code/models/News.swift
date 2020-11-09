//
//  News.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 07.08.2020.
//

import Foundation

// MARK: - Welcome
struct News: Codable {
    let title, body, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case title, body
        case createdAt = "created_at"
    }
}
