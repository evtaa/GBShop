//
//  PersonalDataViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import UIKit

protocol PersonalDataViewInput: class {
    func showInsertingDataUserError (error: Error, withMessage message: String)
    func showSuccessChangingDataUser ()
    func showFailedChangingDataUser ()
}

class PersonalDataViewController: UIViewController {
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
        self.configure()
    }
    
    // MARK: Configure
    private func configure() {
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.title = "Personal data"
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
}

extension PersonalDataViewController: PersonalDataViewInput {
    
    func showInsertingDataUserError (error: Error,withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: "\(message) ", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func  showSuccessChangingDataUser () {
        let alert = UIAlertController(title: "Notification", message: "Personal data were changed successful", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel,handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func  showFailedChangingDataUser () {
        let alert = UIAlertController(title: "Notification", message: "Personal data were changed failed", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}
