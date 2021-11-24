//
//  TabBarBuilder.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import Foundation
import UIKit

final class ShopTabBarModuleBuilder {
    
    static func build(requestFactories: RequestFactories, separatorFactoryAbstract: SeparatorFactoryAbstract) -> ShopTabBarController{
        let viewController = ShopTabBarController (requestFactories: requestFactories, separatorFactoryAbstract: separatorFactoryAbstract)
        return viewController
    }
}
