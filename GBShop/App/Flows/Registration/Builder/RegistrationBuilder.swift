//
//  RegistrationBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation

class RegistrationBuilder {
    static func build (requestFactory: RequestFactory) -> RegistrationViewController {
            let presenter = RegistrationPresenter(requestFactory: requestFactory)
            let viewController = RegistrationViewController(presenter: presenter)
            presenter.viewInput = viewController
            return viewController
    }
}
