//
//  UserAvatar.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 05.10.2020.
//

import Foundation

struct UserAvatarElement: Codable {
    let url: String
}

typealias UserAvatar = [UserAvatarElement]
