//
//  BasketDataRequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 25.04.2021.
//

import Foundation
import Alamofire

protocol BasketDataRequestFactory {
    func addToBasket(idProduct: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
    func deleteFromBasket(idProduct: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void)
    func payBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
    func getBasket(idUser: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void)
}
