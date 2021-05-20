//
//  RequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation

import Alamofire

class RequestFactory {
    //MARK: - Properties
    //let baseUrl = URL(string: "http://127.0.0.1:8080/")!
    let baseUrl = URL(string: "https://mighty-harbor-34171.herokuapp.com/")!
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeUserDataRequestFactory() -> UserDataRequestFactory {
        let errorParser = makeErrorParser()
        return UserData(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeProductsDataRequestFactory() -> ProductsDataRequestFactory {
        let errorParser = makeErrorParser()
        return ProductsData(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeReviewsDataRequestFactory() -> ReviewsDataRequestFactory {
        let errorParser = makeErrorParser()
        return Review(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeBasketDataRequestFactory() -> BasketDataRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
