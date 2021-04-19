//
//  LoginResult.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
    let authToken: String
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case user
        case authToken = "auth_token"
        case errorMessage = "error_message"
    }
}
