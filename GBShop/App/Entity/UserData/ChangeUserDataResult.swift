//
//  ChangeUserDataResult.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation

struct ChangeUserDataResult: Codable {
    let result: Int
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}
