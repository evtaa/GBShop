//
//  RegistrationPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation
import UIKit

protocol RegistrationViewOutput: class {
    func viewDidRegistration(dataUser: DataUser)
    func openAuth()
    func openTabBar()
}

class RegistrationPresenter: CheckingDataUser, TrackableMixIn {
    // MARK: Properties
    weak var viewInput: (RegistrationViewInput & UIViewController)?
    
    // MARK: Private properties
    private var requestFactories: RequestFactories
    
    // MARK: Init
    init(requestFactories: RequestFactories) {
        self.requestFactories = requestFactories
    }
    
    // MARK: Request
    private func requestRegistration (dataUser: DataUser) {
        guard let username = dataUser.username,
              let password = dataUser.password,
              let email = dataUser.email,
              let gender = dataUser.gender,
              let creditCard = dataUser.creditCard,
              let bio = dataUser.bio
        else {
            return
        }
        requestFactories.userRequestFactory.registration(idUser: dataUser.idUser,
                                            username: username,
                                            password: password,
                                            email: email,
                                            gender: gender,
                                            creditCard: creditCard,
                                            bio: bio) { (response) in
            switch response.result {
            case .success(let registration):
                debugPrint(registration)
                self.track(.signUp(method: AnalyticsEvent.signupParams.methodDefault))
                DispatchQueue.main.async {
                    self.viewInput?.showSuccessRegistration()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.viewInput?.showFailedRegistration()
            }
        }
    }
    
    // MARK: Navigation
    private func backToAuth () {
        self.viewInput?.navigationController?.popViewController(animated: true)
    }
    
    private func goToTabBar () {
        guard let separatorFactoryAbstract = viewInput?.separatorFactoryAbstract else {
            return
        }
        let shopTabBarViewController = ShopTabBarModuleBuilder.build(requestFactories: requestFactories,
                                                                     separatorFactoryAbstract: separatorFactoryAbstract)
        shopTabBarViewController.modalPresentationStyle = .fullScreen
        self.viewInput?.dismiss(animated: true, completion: nil)
        self.viewInput?.present(shopTabBarViewController, animated: true, completion: nil)
    }
}

extension RegistrationPresenter: RegistrationViewOutput {
    func viewDidRegistration(dataUser: DataUser) {
        guard let controller = viewInput as? (ShowAlert & UIViewController) else {
            return
        }
        self.catchErrorInsertingDataUser(forViewController: controller) {
            guard (try self.checkDataUser(dataUser: dataUser)) == true else {
                return
            }
            self.requestRegistration(dataUser: dataUser)
        }
    }
    
    func openAuth() {
        self.backToAuth()
    }
    
    func openTabBar() {
        self.goToTabBar()
    }
}


