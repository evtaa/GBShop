//
//  RemoveReviewResult.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 21.04.2021.
//

import Foundation

struct RemoveReviewResult: Codable {
    let result: Int
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}
