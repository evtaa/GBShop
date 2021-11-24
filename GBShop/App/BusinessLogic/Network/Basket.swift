//
//  Basket.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 25.04.2021.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
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

extension Basket: BasketDataRequestFactory {
    func addToBasket(idProduct: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasket(baseUrl: baseUrl, idProduct: idProduct, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteFromBasket(idProduct: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasket(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct AddToBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let idProduct: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct,
                "quantity": quantity
            ]
        }
    }
    
    struct DeleteFromBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let idProduct: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct,
            ]
        }
    }
    
    struct PayBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        
        let idUser: Int
        var parameters: Parameters? {
            return [
                "id_user": idUser,
            ]
        }
    }
    
    struct GetBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getBasket"
        
        let idUser: Int
        var parameters: Parameters? {
            return [
                "id_user": idUser,
            ]
        }
    }
}
