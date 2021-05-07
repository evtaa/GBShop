//
//  PersonalDataViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import UIKit

protocol PersonalDataViewInput: class {
    func showSuccessChangingDataUser ()
    func showFailedChangingDataUser ()
}

class PersonalDataViewController: UIViewController, ShowAlert {
    
    // MARK: Properties
    var gender: String {
        get {
            switch self.personalDataView.genderSegmentControl.selectedSegmentIndex {
            case 0:
                return "Male"
            case 1:
                return "Female"
            default:
                return "Male"
            }
        }
    }
    var personalDataView: PersonalDataView {
        get {
            return self.view as! PersonalDataView
        }
    }
    private let presenter: PersonalDataViewOutput
    
    // MARK: Init
    init(presenter: PersonalDataPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        self.view = PersonalDataView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: Configure
    private func configureUI() {
        self.configureLogoutButton()
        self.configureNavigationBar()
        
    }
    
    private func configureLogoutButton() {
        self.personalDataView.logoutButton.addTarget(self, action: #selector(logoutTouchUpInsideButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        self.title = "Profile"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(changePersonalData))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    //MARK: Actions
    @objc private func changePersonalData () {
        let dataUser = DataUser(idUser: 123,
                                username: self.personalDataView.usernameTextField.text,
                                password: self.personalDataView.passwordTextField.text,
                                email: self.personalDataView.emailTextField.text,
                                gender: gender,
                                creditCard: self.personalDataView.creditCardTextField.text,
                                bio: self.personalDataView.bioTextField.text)
        self.presenter.viewDidChangePersonalData(dataUser: dataUser)
    }
    
    @objc private func logoutTouchUpInsideButton () {
        self.presenter.logout(idUser: 123)
    }
}

extension PersonalDataViewController: PersonalDataViewInput {
    func  showSuccessChangingDataUser () {
        self.showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Personal data were changed successful", withTitleOfAction: "OK", handlerOfAction: nil)
    }
    
    func  showFailedChangingDataUser () {
        self.showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Personal data were changed failed", withTitleOfAction: "OK", handlerOfAction: nil)
    }
}
