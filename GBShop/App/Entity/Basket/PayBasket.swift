//
//  PayBasket.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 25.04.2021.
//

import Foundation

struct PayBasketResult: Codable {
    let result: Int
    let amount: Int
    let countGoods: Int
    let contents: [Content]
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case amount
        case countGoods = "count_goods"
        case contents
        case errorMessage = "error_message"
    }
}
