//
//  TabBarBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import Foundation
import UIKit

final class ShopTabBarModuleBuilder {
    
    static func build(requestFactory: RequestFactory, separatorFactoryAbstract: SeparatorFactoryAbstract) -> ShopTabBarController{
        let viewController = ShopTabBarController (requestFactory: requestFactory, separatorFactoryAbstract: separatorFactoryAbstract)
        return viewController
    }
}
