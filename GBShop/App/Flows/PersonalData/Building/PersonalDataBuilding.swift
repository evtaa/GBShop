//
//  PersonalDataBuilding.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation

class PersonalDataBuilder {
    static func build (requestFactory: RequestFactory) -> PersonalDataViewController {
            let presenter = PersonalDataPresenter(requestFactory: requestFactory)
            let viewController = PersonalDataViewController(presenter: presenter)
            presenter.viewInput = viewController
            return viewController
    }
}
