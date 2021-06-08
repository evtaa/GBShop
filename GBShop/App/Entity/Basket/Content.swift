//
//  Content.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import Foundation

struct Content: Codable {
    let idProduct: Int
    let productName: String
    let price: Int
    let quantity: Int
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price = "price"
        case quantity
        case errorMessage = "error_message"
    }
}
