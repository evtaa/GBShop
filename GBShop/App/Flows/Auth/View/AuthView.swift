//
//  AuthView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import UIKit

class AuthView: UIView {

    //MARK: - Subviews
    let infoDataLabel = LabelDarkStyle()
    let usernameTextField = TextFieldDarkStyle()
    let passwordTextField = TextFieldDarkStyle()
    let loginButton = ButtonDarkStyle()
    let createAccountButton = ButtonDarkStyle()
    let scrollView = UIScrollView ()
    
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI () {
        self.backgroundColor = .black
        self.configureNoCorrectDataLabel()
        self.configureUsernameTextField()
        self.configurePasswordTextField()
        self.configureLoginButton()
        self.configureCreateAccountButton()
        self.setupConstraints()
    }
    
    private func configureNoCorrectDataLabel () {
        self.infoDataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoDataLabel.isHidden = true
        self.infoDataLabel.numberOfLines = 2
        self.infoDataLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.addSubview(self.infoDataLabel)
    }
    
    private func configureUsernameTextField () {
        self.usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameTextField.placeholder = "username"
        self.addSubview(self.usernameTextField)
    }
    
    private func configurePasswordTextField () {
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.placeholder = "password"
        self.passwordTextField.isSecureTextEntry = true
        self.addSubview(self.passwordTextField)
    }
    
    private func configureLoginButton () {
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.setTitle("Login", for: .normal)
        self.addSubview(self.loginButton)
    }
    
    private func configureCreateAccountButton () {
        self.createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        self.createAccountButton.setTitle("Create new account", for: .normal)
        self.addSubview(self.createAccountButton)
    }
    
    private func setupConstraints () {
        let safeArea = self.safeAreaLayoutGuide
        let widthButton = CGFloat(80.0)
        let widthCreateAccountButton = CGFloat(165)
        let widthLabel = CGFloat(180)
        let widthTextField = CGFloat(160)
        
        NSLayoutConstraint.activate([
            
            self.infoDataLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60.0),
            self.infoDataLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            self.infoDataLabel.heightAnchor.constraint(equalToConstant: 60),
            self.infoDataLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthLabel/2),
            
            self.usernameTextField.topAnchor.constraint(equalTo: self.infoDataLabel.bottomAnchor, constant: 10.0),
            self.usernameTextField.widthAnchor.constraint(equalToConstant: widthTextField),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 20),
            self.usernameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthTextField/2),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 10.0),
            self.passwordTextField.widthAnchor.constraint(equalToConstant: widthTextField),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 20),
            self.passwordTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthTextField/2),
            
            self.loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30.0),
            self.loginButton.widthAnchor.constraint(equalToConstant: widthButton),
            self.loginButton.heightAnchor.constraint(equalToConstant: 20.0),
            self.loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthButton/2),
            
            self.createAccountButton.widthAnchor.constraint(equalToConstant: widthCreateAccountButton),
            self.createAccountButton.heightAnchor.constraint(equalToConstant: 20.0),
            self.createAccountButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthCreateAccountButton/2),
            self.createAccountButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40),
        ])
    }

}
