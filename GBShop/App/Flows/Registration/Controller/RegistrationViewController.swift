//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 01.05.2021.
//

import UIKit

enum InsertingDataUserError: String, Error {
    case invalidUsername = "You entered invalid username"
    case invalidPassword = "You entered invalid password"
    case invalidEmail = "You entered invalid email"
    case invalidCreditCard = "You entered invalid number of credit card"
    case invalidBio = "You entered invalid bio"
}

struct DataUser {
    let idUser: Int
    let username: String?
    let password: String?
    let email: String?
    let gender: String?
    let creditCard: String?
    let bio: String?
}

protocol RegistrationViewInput: class {
    func showInsertingDataUserError (error: Error,withMessage message: String)
    func showSuccessRegistration ()
    func showFailedRegistration ()
}

class RegistrationViewController: UIViewController {
    // MARK: Properties
    var gender: String {
        get {
            switch self.registrationView.genderSegmentControl.selectedSegmentIndex {
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
    init(presenter: RegistrationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        self.view = RegistrationView()
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(registration))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    //MARK: Actions
    @objc private func registration () {
        let dataUser = DataUser(idUser: 123,
                                username: self.registrationView.usernameTextField.text,
                                password: self.registrationView.passwordTextField.text,
                                email: self.registrationView.emailTextField.text,
                                gender: gender,
                                creditCard: self.registrationView.creditCardTextField.text,
                                bio: self.registrationView.bioTextField.text)
        self.presenter.viewDidRegistration(dataUser: dataUser)
    }
}

extension RegistrationViewController: RegistrationViewInput {
    
    func showInsertingDataUserError (error: Error,withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: "\(message) ", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func  showSuccessRegistration () {
        let alert = UIAlertController(title: "Notification", message: "Registration was success", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel) { _ in 
            self.presenter.openAuth()
        }
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func  showFailedRegistration () {
        let alert = UIAlertController(title: "Notification", message: "Registration was failed", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}
