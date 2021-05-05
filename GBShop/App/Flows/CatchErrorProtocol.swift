//
//  CatchErrorProtocol.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import Foundation
import UIKit

protocol CatchError {
    
}

extension CatchError {
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
}
