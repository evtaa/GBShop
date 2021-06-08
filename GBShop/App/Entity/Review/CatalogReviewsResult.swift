//
//  CatalogReviewResult.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 21.04.2021.
//

import Foundation

struct CatalogReviewsResult: Codable {
    let countReviews: Int
    let pageNumber: Int
    let errorMessage: String?
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case countReviews = "count_reviews"
        case pageNumber = "page_number"
        case errorMessage = "error_message"
        case reviews
    }
    
    struct Review: Codable {
        let idUser: Int
        let textReview: String
        
        enum CodingKeys: String, CodingKey {
            case idUser = "id_user"
            case textReview = "text_review"
        }
    }
}
