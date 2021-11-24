//
//  CatchErrorProtocol.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import Foundation
import UIKit

protocol CheckingDataUser {
    
}

extension CheckingDataUser {
    func catchErrorInsertingDataUser (forViewController controller: (UIViewController & ShowAlert), doSomething: () throws -> Void) {
        do {
           try doSomething()
        } catch InsertingDataUserError.invalidUsername {
            self.showError(forViewController: controller, withMessage: InsertingDataUserError.invalidUsername.rawValue)
        }
        catch InsertingDataUserError.invalidPassword {
            self.showError(forViewController: controller, withMessage: InsertingDataUserError.invalidPassword.rawValue)
        }
        catch InsertingDataUserError.invalidEmail {
            self.showError(forViewController: controller, withMessage: InsertingDataUserError.invalidEmail.rawValue)
        }
        catch InsertingDataUserError.invalidCreditCard {
            self.showError(forViewController: controller, withMessage: InsertingDataUserError.invalidCreditCard.rawValue)
        }
        catch InsertingDataUserError.invalidBio {
            self.showError(forViewController: controller, withMessage: InsertingDataUserError.invalidBio.rawValue)
        }
        catch {
            self.showError(forViewController: controller, withMessage: "A unacceptable error. You should contact to administrator")
        }
    }
    
    func showError (forViewController controller: (ShowAlert & UIViewController), withMessage message: String) {
        controller.showAlert(forViewController: controller, withTitleOfAlert: "Error", andMessage: message, withTitleOfAction: "OK", handlerOfAction: nil)
    }
    
    func checkDataUser (dataUser: DataUser) throws -> Bool {
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
