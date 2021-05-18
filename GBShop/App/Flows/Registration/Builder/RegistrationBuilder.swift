//
//  RegistrationBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation

class RegistrationBuilder {
    static func build (requestFactory: RequestFactory,separatorFactoryAbstract: SeparatorFactoryAbstract) -> RegistrationViewController {
        let presenter = RegistrationPresenter(requestFactory: requestFactory)
        let viewController = RegistrationViewController(presenter: presenter, separatorFactoryAbstract: separatorFactoryAbstract)
        presenter.viewInput = viewController
        return viewController
    }
}
