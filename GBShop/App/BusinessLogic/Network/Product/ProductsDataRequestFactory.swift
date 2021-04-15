//
//  ProductsDataRequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 15.04.2021.
//

import Foundation
import Alamofire

protocol ProductsDataRequestFactory {
    func downloadCatalogData(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse <[Product]>) -> Void)
    func downloadGoodById (idProduct: Int, completionHandler: @escaping (AFDataResponse<GoodByIdResult>) -> Void)
}
