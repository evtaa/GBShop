//
//  ProductsData.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 15.04.2021.
//

import Foundation
import Alamofire

class ProductsData: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ProductsData: ProductsDataRequestFactory {
    func downloadCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<[Product]>) -> Void) {
        let requestModel = CatalogData(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func downloadGoodById(idProduct: Int, completionHandler: @escaping (AFDataResponse<GoodByIdResult>) -> Void) {
        let requestModel = GoodById(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductsData {
    struct CatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let pageNumber: Int
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": idCategory
            ]
        }
    }
    struct GoodById: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        let idProduct: Int
        var parameters: Parameters? {
            return [
                "id_product": idProduct
            ]
        }
    }
}

