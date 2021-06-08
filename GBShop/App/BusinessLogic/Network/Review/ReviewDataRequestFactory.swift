//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 21.04.2021.
//

import Foundation
import Alamofire

protocol ReviewsDataRequestFactory {
    func addReview(idUser: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
    func removeReview(idComment: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
    func catalogReviews(idProduct: Int, pageNumber: Int, completionHandler: @escaping (AFDataResponse<CatalogReviewsResult>) -> Void)
}
