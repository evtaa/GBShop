//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation
import UIKit

protocol RegistrationViewOutput: class {
    func viewDidRegistration(dataUser: DataUser)
    func openAuth() 
}

class RegistrationPresenter {
    // MARK: Properties
    weak var viewInput: (RegistrationViewInput & UIViewController)?
    
    // MARK: Private properties
    private var requestFactory: RequestFactory
    private var userDataRequestFactory: UserDataRequestFactory
    
    // MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.userDataRequestFactory = requestFactory.makeUserDataRequestFactory()
    }
    
    // MARK: Request
    private func requestRegistration (dataUser: DataUser) {
        guard let username = dataUser.username,
              let password = dataUser.password,
              let email = dataUser.email,
              let gender = dataUser.gender,
              let creditCard = dataUser.creditCard,
              let bio = dataUser.bio
              else {
            return
        }
        userDataRequestFactory.registration(idUser: dataUser.idUser,
                                            username: username,
                                            password: password,
                                            email: email,
                                            gender: gender,
                                            creditCard: creditCard,
                                            bio: bio) { (response) in
            switch response.result {
            case .success(let registration):
                debugPrint(registration)
                DispatchQueue.main.async {
                    self.viewInput?.showSuccessRegistration()
                } 
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.viewInput?.showFailedRegistration()
            }
        }
    }
    
    // MARK: Navigation
    private func backToAuth () {
        self.viewInput?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private functions
    private func checkDataUser (dataUser: DataUser) throws -> Bool {
        guard let countUsername = dataUser.username?.count,
              countUsername > 0 else {
            throw InsertingDataUserError.invalidUsername
        }
        guard let countPassword = dataUser.password?.count,
              countPassword > 0 else {
            throw InsertingDataUserError.invalidPassword
        }
        guard let isEmail = dataUser.email?.isValidEmail,
              isEmail == true else {
            throw InsertingDataUserError.invalidEmail
        }
        guard let countCreditCard = dataUser.creditCard?.count,
              countCreditCard > 0 else {
            throw InsertingDataUserError.invalidCreditCard
        }
        guard let countBio = dataUser.bio?.count,
              countBio > 0 else {
            throw InsertingDataUserError.invalidBio
        }
        return true
    }
}

extension RegistrationPresenter: RegistrationViewOutput {
    func viewDidRegistration(dataUser: DataUser) {
        do {
            guard (try self.checkDataUser(dataUser: dataUser)) == true else {
                return
            }
            self.requestRegistration(dataUser: dataUser)
        } catch InsertingDataUserError.invalidUsername {
            viewInput?.showInsertingDataUserError(error: InsertingDataUserError.invalidUsername, withMessage: InsertingDataUserError.invalidUsername.rawValue)
        }
        catch InsertingDataUserError.invalidPassword {
            viewInput?.showInsertingDataUserError(error: InsertingDataUserError.invalidPassword, withMessage: InsertingDataUserError.invalidPassword.rawValue)
        }
        catch InsertingDataUserError.invalidEmail {
            viewInput?.showInsertingDataUserError(error: InsertingDataUserError.invalidEmail, withMessage: InsertingDataUserError.invalidEmail.rawValue)
        }
        catch InsertingDataUserError.invalidCreditCard {
            viewInput?.showInsertingDataUserError(error: InsertingDataUserError.invalidCreditCard, withMessage: InsertingDataUserError.invalidCreditCard.rawValue)
        }
        catch InsertingDataUserError.invalidBio {
            viewInput?.showInsertingDataUserError(error: InsertingDataUserError.invalidBio, withMessage: InsertingDataUserError.invalidBio.rawValue)
        }
        catch {
            viewInput?.showInsertingDataUserError(error: Error.self as! Error, withMessage: "Неизвестная ошибка")
        }
    }
    
    func openAuth() {
        self.backToAuth()
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UITextField {
    var isEmail: Bool? {
        return self.text?.isValidEmail
    }
}
