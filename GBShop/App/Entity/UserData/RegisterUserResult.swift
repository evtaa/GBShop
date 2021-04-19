//
//  RegisterUserResult.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation

struct RegisterUserResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
        case errorMessage = "error_message"
    }
}
