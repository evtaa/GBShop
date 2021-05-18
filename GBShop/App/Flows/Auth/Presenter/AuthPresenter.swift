//
//  AuthPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import Foundation
import UIKit

protocol AuthViewOutput: class {
    func viewDidLogin(userName: String?, password: String?)
    func viewDidLogout(idUser: Int)
    func viewDidRegistration()
}

final class AuthPresenter: CheckingDataUser, TrackableMixIn {
    
    // MARK: Properties
    weak var viewInput: (UIViewController & AuthViewInput)?
    
    // MARK: Private properties
    private var requestFactory: RequestFactory
    private var authRequestFactory: AuthRequestFactory
    
    // MARK: Init
    internal init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.authRequestFactory = requestFactory.makeAuthRequestFactory()
    }
    
    // MARK: Request
    private func requestLogin (userName: String?, password: String?) {
        guard let userName = userName,
              let password = password else {
            return
        }
        authRequestFactory.login(userName: userName, password: password) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let login):
                debugPrint(login)
                DispatchQueue.main.async {
                    if (login.result == 1) {
                        self.track(.login(method: AnalyticsEvent.loginParams.methodDefault, success: true))
                        self.viewInput?.hideNotificationData()
                        self.openTabBar()
                    } else {
                        self.viewInput?.showNotificationData(message: "The request was failed")
                    }
                }
            case .failure(let error):
                self.track(.login(method: AnalyticsEvent.loginParams.methodDefault, success: false))
                debugPrint(error.localizedDescription)
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
                        self.viewInput?.showLogout()
                    }
                }
            case .failure(let error):
                debugPrint (error.localizedDescription)
            }
        }
    }
    
    // MARK: Navigations
    private func openRegistration () {
        guard let separatorFactoryAbstract = viewInput?.separatorFactoryAbstract else {
            return
        }
        let registrationViewController = RegistrationBuilder.build(requestFactory: requestFactory, separatorFactoryAbstract: separatorFactoryAbstract)
        self.viewInput?.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    private func openTabBar () {
        guard let separatorFactoryAbstract = viewInput?.separatorFactoryAbstract else {
            return
        }
        let shopTabBarViewController = ShopTabBarModuleBuilder.build(requestFactory: requestFactory, separatorFactoryAbstract: separatorFactoryAbstract)
        //shopTabBarViewController.modalPresentationStyle = .fullScreen
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow == true}.last
        keyWindow?.rootViewController = shopTabBarViewController
        //self.viewInput?.navigationController?.present(shopTabBarViewController, animated: true, completion: nil)
    }
    
    // MARK: Private functions
    private func checkUsernameAndPassword (username: String?, password: String?) throws -> Bool {
        guard let countUsername = username?.count,
              countUsername > 0 else {
            throw InsertingDataUserError.invalidUsername
        }
        guard let countPassword = password?.count,
              countPassword > 0 else {
            throw InsertingDataUserError.invalidPassword
        }
        return true
    }
    
    private func catchErrorInsertingUsernamePassword ( doSomething: () throws -> Void) {
        guard let viewInput = viewInput as? (UIViewController & ShowAlert & AuthViewInput) else {
            return
        }
        do {
           try doSomething()
        } catch InsertingDataUserError.invalidUsername {
            viewInput.showNotificationData(message: InsertingDataUserError.invalidUsername.rawValue)
        }
        catch InsertingDataUserError.invalidPassword {
            viewInput.showNotificationData(message: InsertingDataUserError.invalidPassword.rawValue)
        }
        catch {
            self.showError(forViewController: viewInput, withMessage: "A unacceptable error. You should contact to administrator")
        }
    }
}

extension AuthPresenter: AuthViewOutput {
    func viewDidLogin(userName: String?, password: String?) {
        self.catchErrorInsertingUsernamePassword {
            guard (try self.checkUsernameAndPassword(username: userName, password: password)) == true else {
                return
            }
            self.requestLogin(userName: userName, password: password)
        }
    }
    
    func viewDidLogout(idUser: Int) {
        self.requestLogout(idUser: idUser)
    }
    
    func viewDidRegistration() {
        self.openRegistration()
    }
    
}
