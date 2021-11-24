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
    var separatorFactoryAbstract: SeparatorFactoryAbstract {get set}
}

class PersonalDataViewController: UIViewController, ShowAlert {
    // MARK: Properties
    var separatorFactoryAbstract: SeparatorFactoryAbstract
    
    var gender: String {
        get {
            switch self.personalDataView.dataUserView.genderSegmentControl.selectedSegmentIndex {
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
    init(presenter: PersonalDataPresenter, separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.separatorFactoryAbstract = separatorFactoryAbstract
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        self.view = PersonalDataView(separatorFactoryAbstract: separatorFactoryAbstract)
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
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(changePersonalData))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    //MARK: Actions
    @objc private func changePersonalData () {
        let dataUser = DataUser(idUser: 123,
                                username: self.personalDataView.dataUserView.usernameTextField.text,
                                password: self.personalDataView.dataUserView.passwordTextField.text,
                                email: self.personalDataView.dataUserView.emailTextField.text,
                                gender: gender,
                                creditCard: self.personalDataView.dataUserView.creditCardTextField.text,
                                bio: self.personalDataView.dataUserView.bioTextField.text)
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
