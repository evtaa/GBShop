//
//  AddingReviewModuleBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 13.05.2021.
//

import Foundation
import UIKit

final class AddingReviewModuleBuilder {
    
    static func build(requestFactories: RequestFactories) -> AddingReviewViewController {
        let presenter = AddingReviewPresenter(requestFactories: requestFactories)
        let viewController = AddingReviewViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
