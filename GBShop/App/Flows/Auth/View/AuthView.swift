//
//  AuthView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import UIKit

class AuthView: UIView {

    //MARK: - Subviews
    let noCorrectDataLabel = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let createAccountButton = UIButton()
    
    
    
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
//        self.configureLogoutButton()
        self.configureCreateAccountButton()
        self.setupConstraints()
    }
    
    private func configureNoCorrectDataLabel () {
        self.noCorrectDataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noCorrectDataLabel.isHidden = true
        self.noCorrectDataLabel.numberOfLines = 2
        self.noCorrectDataLabel.textColor = .white
        self.noCorrectDataLabel.backgroundColor = .black
        self.noCorrectDataLabel.textAlignment = .left
        self.noCorrectDataLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.addSubview(self.noCorrectDataLabel)
    }
    
    private func configureUsernameTextField () {
        self.usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameTextField.textColor = .white
        self.usernameTextField.backgroundColor = .black
        self.usernameTextField.textAlignment = .left
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.usernameTextField.font = UIFont.systemFont(ofSize: 18.0)
        self.addSubview(self.usernameTextField)
    }
    
    private func configurePasswordTextField () {
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.textColor = .white
        self.passwordTextField.backgroundColor = .black
        self.passwordTextField.textAlignment = .left
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.passwordTextField.font = UIFont.systemFont(ofSize: 18.0)
        self.addSubview(self.passwordTextField)
    }
    
    private func configureLoginButton () {
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.setTitleColor(.white, for: .normal)
        self.loginButton.setTitleShadowColor(.gray, for: .normal)
        self.loginButton.titleLabel?.textAlignment = .center
        self.loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.loginButton.backgroundColor = .black
        self.addSubview(self.loginButton)
    }
    
    private func configureCreateAccountButton () {
        self.createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        self.createAccountButton.setTitle("Create new account", for: .normal)
        self.createAccountButton.setTitleColor(.white, for: .normal)
        self.createAccountButton.setTitleShadowColor(.gray, for: .normal)
        self.createAccountButton.titleLabel?.textAlignment = .center
        self.createAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.createAccountButton.backgroundColor = .black
        self.addSubview(self.createAccountButton)
    }
    
    private func setupConstraints () {
        let safeArea = self.safeAreaLayoutGuide
        let widthButton = CGFloat(80.0)
        let widthCreateAccountButton = CGFloat(165)
        let widthLabel = CGFloat(180)
        let widthTextField = CGFloat(160)
        
        NSLayoutConstraint.activate([
            
            self.noCorrectDataLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60.0),
            self.noCorrectDataLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            self.noCorrectDataLabel.heightAnchor.constraint(equalToConstant: 60),
            self.noCorrectDataLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthLabel/2),
            
            self.usernameTextField.topAnchor.constraint(equalTo: self.noCorrectDataLabel.bottomAnchor, constant: 10.0),
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
