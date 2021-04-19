//
//  Regist.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation
import Alamofire

class UserData: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    //let baseUrl = URL(string: "http://127.0.0.1:8080/")!
    let baseUrl = URL(string: "https://mighty-harbor-34171.herokuapp.com/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension UserData: UserDataRequestFactory {
    func registration(idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = Registration(baseUrl: baseUrl, idUser: idUser, username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func changeUserData (idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, idUser: idUser, username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension UserData {
    struct Registration: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        //let path: String = "registerUser.json"
        let path: String = "register"
        
        let idUser: Int
        let username: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        //let path: String = "changeUserData.json"
        let path: String = "changeUserData"
        
        let idUser: Int
        let username: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
}
