//
//  PersonalDataPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation
import UIKit

protocol PersonalDataViewOutput: class {
    func viewDidChangePersonalData(dataUser: DataUser)
    func logout(idUser: Int)
}

class PersonalDataPresenter: CheckingDataUser, TrackableMixIn {
    // MARK: Properties
    weak var viewInput: (PersonalDataViewInput & UIViewController)?
    
    // MARK: Private properties
    private var requestFactory: RequestFactory
    private var userDataRequestFactory: UserDataRequestFactory
    private var authRequestFactory: AuthRequestFactory
    
    // MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.userDataRequestFactory = requestFactory.makeUserDataRequestFactory()
        self.authRequestFactory = requestFactory.makeAuthRequestFactory()
        
    }
    
    // MARK: Request
    private func requestChangePersonalData (dataUser: DataUser) {
        guard let username = dataUser.username,
              let password = dataUser.password,
              let email = dataUser.email,
              let gender = dataUser.gender,
              let creditCard = dataUser.creditCard,
              let bio = dataUser.bio
              else {
            return
        }
        userDataRequestFactory.changeUserData(idUser: dataUser.idUser,
                                            username: username,
                                            password: password,
                                            email: email,
                                            gender: gender,
                                            creditCard: creditCard,
                                            bio: bio) { (response) in
            switch response.result {
            case .success(let changeUserData):
                debugPrint(changeUserData)
                DispatchQueue.main.async {
                    self.viewInput?.showSuccessChangingDataUser()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.viewInput?.showFailedChangingDataUser()
            }
        }
    }
    
    private func requestLogout(idUser: Int) {
        authRequestFactory.logout(idUser: idUser) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let logout):
                debugPrint (logout)
                DispatchQueue.main.async {
                    if (logout.result == 1) {
                        self.track(.logout(method: AnalyticsEvent.logoutParams.methodDefault))
                        self.backToAuth()
                    }
                }
            case .failure(let error):
                debugPrint (error.localizedDescription)
            }
        }
    }
    
    // MARK: Navigation
    private func backToAuth () {
        guard let separatorFactoryAbstract = viewInput?.separatorFactoryAbstract else {
            return
        }
        let authViewController = AuthModuleBuilder.build(requestFactory: self.requestFactory, separatorFactoryAbstract: separatorFactoryAbstract)
        authViewController.showLogout()
        let navigationAuthViewController = NavigationControllerDarkStyle(rootViewController: authViewController)
        //navigationAuthViewController.modalPresentationStyle = .fullScreen
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow == true}.last
        keyWindow?.rootViewController = navigationAuthViewController
       // self.viewInput?.tabBarController?.present(navigationAuthViewController, animated: true, completion: nil)
    }
}

extension PersonalDataPresenter: PersonalDataViewOutput {
    func viewDidChangePersonalData(dataUser: DataUser) {
        guard let controller = viewInput as? (ShowAlert & UIViewController) else {
            return
        }
        
        self.catchErrorInsertingDataUser(forViewController: controller) {
            guard (try self.checkDataUser(dataUser: dataUser)) == true else {
                return
            }
            self.requestChangePersonalData(dataUser: dataUser)
        }
    }
    
    func logout(idUser: Int) {
        self.requestLogout(idUser: idUser)
    }
}

