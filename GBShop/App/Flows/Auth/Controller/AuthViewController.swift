//
//  AuthViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import UIKit

protocol AuthViewInput: class {
    func showNotificationData(message: String)
    func hideNotificationData ()
    func showLogout ()
    //func showError (withMessage message: String)
}

class AuthViewController: UIViewController, ShowAlert {

    // MARK: Properties
    
    private var presenter: AuthViewOutput
    
    // MARK: Private properties
    
    internal var authView: AuthView {

            return self.view as! AuthView
    }
    
    //MARK: Init
    
    init(presenter: AuthViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        self.view = AuthView ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
       // self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Configure
    
    private func configure () {
        self.configureNavigationBar()
        self.configureActions()
    }
    
    func configureNavigationBar () {
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector (checkLogout))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func configureActions () {
        self.authView.loginButton.addTarget(self, action: #selector(checkLogin), for: .touchUpInside)
        self.authView.createAccountButton.addTarget(self, action: #selector(openRegistration), for: .touchUpInside)
    }
    
    // MARK: Private functions
    private func showInfoData(message: String) {
        self.authView.infoDataLabel.text = message
        self.authView.infoDataLabel.isHidden = false
    }
    // MARK: Actions
    @objc func checkLogin () {
        self.presenter.viewDidLogin(userName: self.authView.usernameTextField.text,
                                    password: self.authView.passwordTextField.text)
    }
    
    @objc func checkLogout () {
        self.presenter.viewDidLogout(idUser: 123)
    }
    
    @objc func openRegistration () {
        self.presenter.viewDidRegistration()
    }
    
}

extension AuthViewController: AuthViewInput {
    func showNotificationData(message: String) {
        self.showInfoData(message: message)
    }
    
    func hideNotificationData() {
        self.authView.infoDataLabel.isHidden = true
    }
    
    func showLogout() {
        self.showInfoData(message: "You are logged out")
    }
}
