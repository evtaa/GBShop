//
//  BasketBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 27.04.2021.
//

import Foundation
import UIKit

final class BasketModuleBuilder {
    
    static func build(requestFactories: RequestFactories) -> BasketViewController {
        let presenter = BasketPresenter(requestFactories: requestFactories)
        let viewController = BasketViewController(presenter: presenter)
        presenter.viewInput = viewController 
        return viewController
    }
}
