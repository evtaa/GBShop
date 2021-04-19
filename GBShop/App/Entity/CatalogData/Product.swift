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
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price = "price"
        case errorMessage = "error_message"
    }
}
