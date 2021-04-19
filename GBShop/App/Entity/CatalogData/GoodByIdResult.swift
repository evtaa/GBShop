//
//  GoodByIdResult.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 15.04.2021.
//

import Foundation

struct GoodByIdResult: Codable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
        case errorMessage = "error_message"
    }
}
