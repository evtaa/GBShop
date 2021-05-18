//
//  AuthViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import UIKit
import FirebaseAnalytics

protocol AuthViewInput: class {
    func showNotificationData(message: String)
    func hideNotificationData ()
    func showLogout ()
    var separatorFactoryAbstract: SeparatorFactoryAbstract {get set}
}

class AuthViewController: UIViewController, ShowAlert {
    // MARK: Properties
    private var presenter: AuthViewOutput
    var separatorFactoryAbstract: SeparatorFactoryAbstract
    
    // MARK: Private properties
    internal var authView: AuthView {

            return self.view as! AuthView
    }
    
    //MARK: Init
    init(presenter: AuthViewOutput, separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.presenter = presenter
        self.separatorFactoryAbstract = separatorFactoryAbstract
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
    }
    
    //MARK: Configure
    private func configure () {
        self.configureNavigationBar()
        self.configureActions()
    }
    
    func configureNavigationBar () {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector (logoutButtonTouchUpInside))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
        self.navigationController?.navigationBar.accessibilityIdentifier = "authNavigationBar"
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "logout"
    }
    
    private func configureActions () {
        self.authView.loginButton.addTarget(self, action: #selector(loginButtonTouchUpInside), for: .touchUpInside)
        self.authView.createAccountButton.addTarget(self, action: #selector(createAccountButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: Private functions
    private func showInfoData(message: String) {
        self.authView.infoDataLabel.text = message
        self.authView.infoDataLabel.isHidden = false
    }
    // MARK: Actions
    @objc func loginButtonTouchUpInside () {
        self.presenter.viewDidLogin(userName: self.authView.usernameTextField.text,
                                    password: self.authView.passwordTextField.text)
    }
    
    @objc func logoutButtonTouchUpInside () {
        self.presenter.viewDidLogout(idUser: 123)
    }
    
    @objc func createAccountButtonTouchUpInside () {
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
