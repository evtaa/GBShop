//
//  RegistRequestFactory.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.04.2021.
//

import Foundation
import Alamofire

protocol RegistRequestFactory {
    func registration (idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse <RegisterUserResult>) -> Void)
}

