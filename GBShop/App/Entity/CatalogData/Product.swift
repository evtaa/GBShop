//
//  Product.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 15.04.2021.
//

import Foundation

struct Product: Codable {
    let idProduct: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idProduct = try container.decode(Int.self, forKey: .idProduct)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.price = try container.decode(Int.self, forKey: .price)
    }
}
