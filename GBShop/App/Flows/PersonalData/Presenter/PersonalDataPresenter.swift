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
    func openAuth()
}

class PersonalDataPresenter: CatchError {
    // MARK: Properties
    weak var viewInput: (PersonalDataViewInput & UIViewController)?
    
    // MARK: Private properties
    private var requestFactory: RequestFactory
    private var userDataRequestFactory: UserDataRequestFactory
    
    // MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.userDataRequestFactory = requestFactory.makeUserDataRequestFactory()
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
    
    // MARK: Navigation
    private func backToAuth () {
        self.viewInput?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private functions
    private func checkDataUser (dataUser: DataUser) throws -> Bool {
        guard let countUsername = dataUser.username?.count,
              countUsername > 0 else {
            throw InsertingDataUserError.invalidUsername
        }
        guard let countPassword = dataUser.password?.count,
              countPassword > 0 else {
            throw InsertingDataUserError.invalidPassword
        }
        guard let isEmail = dataUser.email?.isValidEmail,
              isEmail == true else {
            throw InsertingDataUserError.invalidEmail
        }
        guard let countCreditCard = dataUser.creditCard?.count,
              countCreditCard > 0 else {
            throw InsertingDataUserError.invalidCreditCard
        }
        guard let countBio = dataUser.bio?.count,
              countBio > 0 else {
            throw InsertingDataUserError.invalidBio
        }
        return true
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
    
    func openAuth() {
        self.backToAuth()
    }
}

