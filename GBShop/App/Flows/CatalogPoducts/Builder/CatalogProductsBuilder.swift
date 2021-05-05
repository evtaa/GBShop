//
//  CatalogProductsBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import Foundation
import UIKit

final class CatalogProductsModuleBuilder {
    
    static func build(requestFactory: RequestFactory) -> CatalogProductsViewController {
        let presenter = CatalogProductsPresenter(requestFactory: requestFactory)
        let viewController = CatalogProductsViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
