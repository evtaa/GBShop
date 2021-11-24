//
//  Review.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 21.04.2021.
//

import Foundation
import Alamofire

class Review: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(
        baseUrl: URL,
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Review: ReviewsDataRequestFactory {
    func addReview(idUser: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReview(baseUrl: baseUrl, idUser: idUser, text: text)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeReview(idComment: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = RemoveReview(baseUrl: baseUrl, idComment: idComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func catalogReviews(idProduct: Int, pageNumber: Int, completionHandler: @escaping (AFDataResponse<CatalogReviewsResult>) -> Void) {
        let requestModel = CatalogReviews(baseUrl: baseUrl, idProduct: idProduct, pageNumber: pageNumber)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Review {
    struct AddReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        //let path: String = "login.json"
        let path: String = "addReview"
        
        let idUser: Int
        let text: String
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "text": text
            ]
        }
    }
    
    struct RemoveReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        //let path: String = "login.json"
        let path: String = "removeReview"
        
        let idComment: Int
        var parameters: Parameters? {
            return [
                "id_comment": idComment
            ]
        }
    }
    
    struct CatalogReviews: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        //let path: String = "login.json"
        let path: String = "catalogReviews"
        
        let idProduct: Int
        let pageNumber: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct,
                "page_number": pageNumber
            ]
        }
    }
}

