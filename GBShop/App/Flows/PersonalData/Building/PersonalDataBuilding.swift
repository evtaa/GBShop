//
//  PersonalDataBuilding.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation
import UIKit

class PersonalDataBuilder {
    static func build (requestFactories: RequestFactories,
                       separatorFactoryAbstract: SeparatorFactoryAbstract) -> PersonalDataViewController {
        let presenter = PersonalDataPresenter(requestFactories: requestFactories)
        let viewController = PersonalDataViewController(presenter: presenter, separatorFactoryAbstract: separatorFactoryAbstract)
            presenter.viewInput = viewController
            return viewController
    }
}
