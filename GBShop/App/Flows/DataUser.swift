//
//  DataUser.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 08.05.2021.
//

import Foundation

enum InsertingDataUserError: String, Error {
    case invalidUsername = "You entered invalid username"
    case invalidPassword = "You entered invalid password"
    case invalidEmail = "You entered invalid email"
    case invalidCreditCard = "You entered invalid number of credit card"
    case invalidBio = "You entered invalid bio"
}

struct DataUser {
    let idUser: Int
    let username: String?
    let password: String?
    let email: String?
    let gender: String?
    let creditCard: String?
    let bio: String?
}
