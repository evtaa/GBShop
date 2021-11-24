//
//  ReviewOfProduct.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import Foundation
struct ReviewOfProduct: Codable {
    let idUser: Int
    let textReview: String
    
    enum CodingKeys: String, CodingKey {
        case idUser = "id_user"
        case textReview = "text_review"
    }
}
