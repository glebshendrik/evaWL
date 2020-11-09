//
//  UserSettings.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 15.09.2020.
//

import Foundation

struct UserSettings: Codable {
    var pin: Pin?
}


struct Pin: Codable {
    var code: String?
}
