//
//  RequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation

import Alamofire

class RequestFactory {
    
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
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeExitRequestFactory() -> ExitRequestFactory {
        let errorParser = makeErrorParser()
        return Exit(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRegistRequestFactory() -> RegistRequestFactory {
        let errorParser = makeErrorParser()
        return Regist(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeChangeUserRequestFactory() -> ChangeUserRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUser(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
