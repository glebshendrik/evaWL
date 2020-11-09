//
//  authAccountResponse.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 28.07.2020.
//

import Foundation

// MARK: - AuthAccountResponse
struct AuthAccountResponse: Codable {
    let issues: [Issue]?
    let access_token: String?
    let session: String?
    let message: String?
    let text: String?
}

struct UpdateSessionResponse: Codable {
    let access_token: String
    let session: String
}

// MARK: - Issue
struct Issue: Codable {
    let text, type, value: String?
}

struct TotpResponse: Codable {
    let backupPassword: String
    let otpID: Int
    let otpLink: String

    enum CodingKeys: String, CodingKey {
        case backupPassword = "backup_password"
        case otpID = "otp_id"
        case otpLink = "otp_link"
    }
}

struct ResendEmailResponse: Codable {
    let code: Int?
    let message: String?
}

