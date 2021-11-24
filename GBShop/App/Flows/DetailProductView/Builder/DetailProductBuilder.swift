//
//  DetailProductBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 10.05.2021.
//

import Foundation
import UIKit

final class DetailProductModuleBuilder {
    
    static func build(requestFactory: RequestFactory) -> DetailProductViewController {
        let presenter = DetailProductPresenter(requestFactory: requestFactory)
        let viewController = DetailProductViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
