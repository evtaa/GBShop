//
//  AuthBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import Foundation
import UIKit

final class AuthModuleBuilder {
    
    static func build(requestFactories: RequestFactories,
                      separatorFactoryAbstract: SeparatorFactoryAbstract) -> AuthViewController {
        let presenter = AuthPresenter(requestFactories: requestFactories)
        let viewController = AuthViewController(presenter: presenter, separatorFactoryAbstract: separatorFactoryAbstract)
        presenter.viewInput = viewController
        return viewController
    }
}
