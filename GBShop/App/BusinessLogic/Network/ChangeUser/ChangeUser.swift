////
////  ChangeUser.swift
////  GBShop
////
////  Created by Alexandr Evtodiy on 09.04.2021.
////
//
//import Foundation
//import Alamofire
//
//class ChangeUser: AbstractRequestFactory {
//    var errorParser: AbstractErrorParser
//    var sessionManager: Session
//    var queue: DispatchQueue
//    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
//    
//    init(
//        errorParser: AbstractErrorParser,
//        sessionManager: Session,
//        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
//        self.errorParser = errorParser
//        self.sessionManager = sessionManager
//        self.queue = queue
//    }
//}
//
//extension ChangeUser: ChangeUserRequestFactory {
//    
//    func changeUserData (idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
//        let requestModel = ChangeUserData(baseUrl: baseUrl, idUser: idUser, username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
//        self.request(request: requestModel, completionHandler: completionHandler)
//    }
//}
//
//extension ChangeUser {
//    struct ChangeUserData: RequestRouter {
//        let baseUrl: URL
//        let method: HTTPMethod = .get
//        let path: String = "changeUserData.json"
//        
//        let idUser: Int
//        let username: String
//        let password: String
//        let email: String
//        let gender: String
//        let creditCard: String
//        let bio: String
//        var parameters: Parameters? {
//            return [
//                "id_user": idUser,
//                "username": username,
//                "password": password,
//                "email": email,
//                "gender": gender,
//                "credit_card": creditCard,
//                "bio": bio
//            ]
//        }
//    }
//}
