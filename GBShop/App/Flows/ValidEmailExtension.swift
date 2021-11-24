//
//  ValidEmailExtension.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import Foundation
import UIKit

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
