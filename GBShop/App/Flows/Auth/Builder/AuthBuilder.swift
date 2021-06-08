//
//  AuthBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import Foundation
import UIKit

final class AuthModuleBuilder {
    
    static func build(requestFactory: RequestFactory) -> AuthViewController {
        let presenter = AuthPresenter(requestFactory: requestFactory)
        let viewController = AuthViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
