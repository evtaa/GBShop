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
    
    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode(Int.self, forKey: .result)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.productPrice = try container.decode(Int.self, forKey: .productPrice)
        self.productDescription = try container.decode(String.self, forKey: .productDescription)
    }
}
