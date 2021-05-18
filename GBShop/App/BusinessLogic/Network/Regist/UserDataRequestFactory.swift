//
//  UserDataRequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation
import Alamofire

protocol UserDataRequestFactory {
    func registration (idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse <RegisterUserResult>) -> Void)
    func changeUserData (idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse <ChangeUserDataResult>) -> Void)
}

