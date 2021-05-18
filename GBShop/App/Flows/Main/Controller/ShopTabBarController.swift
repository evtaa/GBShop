//
//  TabBarController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import UIKit

class ShopTabBarController: UITabBarController {
    //MARK: - Properties
    let separatorFactoryAbstract: SeparatorFactoryAbstract
    
    // MARK: - Init
    init(requestFactory: RequestFactory, separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.separatorFactoryAbstract = separatorFactoryAbstract
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = self.createViewControllers(requestFactory: requestFactory)
        self.configureTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Configure
    private func configureTabBar () {
        self.selectedIndex = 1
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .black
        self.tabBar.barTintColor = .black
    }
    
    // MARK: - Private functions
    private func createViewControllers (requestFactory: RequestFactory) -> [UIViewController] {
        var controllers = [UIViewController]()
        
        let personalDataViewController = PersonalDataBuilder.build(requestFactory: requestFactory, separatorFactoryAbstract: separatorFactoryAbstract)
        personalDataViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profileSelect"))
        personalDataViewController.tabBarItem.tag = 0
        let personalDataNavigationController = NavigationControllerDarkStyle(rootViewController: personalDataViewController)
        controllers.append(personalDataNavigationController)
        
        let catalogProductsViewController = CatalogProductsModuleBuilder.build(requestFactory: requestFactory)
        catalogProductsViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), selectedImage: UIImage(named: "searchSelect"))
        catalogProductsViewController.tabBarItem.tag = 1
        let catalogProductsNavigationController = NavigationControllerDarkStyle(rootViewController: catalogProductsViewController)
        controllers.append(catalogProductsNavigationController)
        
        let basketViewController = BasketModuleBuilder.build(requestFactory: requestFactory)
        basketViewController.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(named: "basket"), selectedImage: UIImage(named: "basketSelect"))
        basketViewController.tabBarItem.tag = 2
        let basketNavigationController = NavigationControllerDarkStyle(rootViewController: basketViewController)
        controllers.append(basketNavigationController)
        
        return controllers
    }
}
