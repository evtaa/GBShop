//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 01.05.2021.
//

import UIKit

protocol RegistrationViewInput: class {
    func showSuccessRegistration ()
    func showFailedRegistration ()
    var separatorFactoryAbstract: SeparatorFactoryAbstract {get set}
}

class RegistrationViewController: UIViewController, ShowAlert {
    // MARK: Properties
    var separatorFactoryAbstract: SeparatorFactoryAbstract
    
    var gender: String {
        get {
            switch self.registrationView.dataUserView.genderSegmentControl.selectedSegmentIndex {
            case 0:
                return "Male"
            case 1:
                return "Female"
            default:
                return "Male"
            }
        }
    }
    var registrationView: RegistrationView {
        get {
            return self.view as! RegistrationView
        }
    }
    private let presenter: RegistrationViewOutput
    
    // MARK: Init
    init(presenter: RegistrationPresenter, separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.presenter = presenter
        self.separatorFactoryAbstract = separatorFactoryAbstract
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        self.view = RegistrationView(separatorFactoryAbstract: separatorFactoryAbstract)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    // MARK: Configure
    private func configure() {
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.title = "Registration"
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTouchUpInside))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    //MARK: Actions
    @objc private func doneButtonTouchUpInside () {
        let dataUser = DataUser(idUser: 123,
                                username: self.registrationView.dataUserView.usernameTextField.text,
                                password: self.registrationView.dataUserView.passwordTextField.text,
                                email: self.registrationView.dataUserView.emailTextField.text,
                                gender: gender,
                                creditCard: self.registrationView.dataUserView.creditCardTextField.text,
                                bio: self.registrationView.dataUserView.bioTextField.text)
        self.presenter.viewDidRegistration(dataUser: dataUser)
    }
}

extension RegistrationViewController: RegistrationViewInput {
    
    func  showSuccessRegistration () {
        self.showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Registration was success", withTitleOfAction: "OK") { _ in
            self.presenter.openTabBar()
        }
    }
    
    func  showFailedRegistration () {
        self.showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Registration was failed", withTitleOfAction: "OK", handlerOfAction: nil)
    }
}
