//
//  RegistrationView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 30.04.2021.
//

import UIKit

class RegistrationView: UIView {
    
    //MARK: Subviews
    let scrollView = UIScrollView()
    var usernameLabel = LabelDarkStyle()
    var usernameTextField = TextFieldDarkStyle()
    var passwordLabel = LabelDarkStyle()
    var passwordTextField = TextFieldDarkStyle()
    var emailLabel = LabelDarkStyle()
    var emailTextField = TextFieldDarkStyle()
    var genderLabel = LabelDarkStyle()
    var genderSegmentControl = SegmentedControlDarkStyle(items: ["Male", "Female"])
    var creditCardLabel = LabelDarkStyle()
    var creditCardTextField = TextFieldDarkStyle()
    var bioLabel = LabelDarkStyle()
    var bioTextField = TextFieldDarkStyle()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI () {
        self.backgroundColor = .black
        self.configureScrollView ()
        self.configureUsernameLabel ()
        self.configureUsernameTextField ()
        self.configurePasswordLabel ()
        self.configurePasswordTextField ()
        self.configureEmailLabel ()
        self.configureEmailTextField ()
        self.configureGenderLabel ()
        self.configureGenderSegmentControl ()
        self.configureCreditCardLabel ()
        self.configureCreditCardTextField ()
        self.configureBioLabel ()
        self.configureBioTextField ()
        self.setupConstraints()
    }
    
    // MARK: Private functions
    private func configureScrollView () {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    private func  configureUsernameLabel () {
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username:"
        self.scrollView.addSubview(usernameLabel)
    }
    private func configurePasswordLabel () {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password:"
        self.scrollView.addSubview(passwordLabel)
    }
    private func configureEmailLabel () {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email:"
        self.scrollView.addSubview(emailLabel)
    }
    private func configureGenderLabel () {
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.text = "Gender:"
        self.scrollView.addSubview(genderLabel)
    }
    private func configureCreditCardLabel () {
        creditCardLabel.translatesAutoresizingMaskIntoConstraints = false
        creditCardLabel.text = "Number of credit card:"
        self.scrollView.addSubview(creditCardLabel)
    }
    private func configureBioLabel () {
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.text = "Bio:"
        self.scrollView.addSubview(bioLabel)
    }
    
    private func configureUsernameTextField () {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "username"
        self.scrollView.addSubview(usernameTextField)
    }
    private func configurePasswordTextField () {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        self.scrollView.addSubview(passwordTextField)
    }
    private func configureEmailTextField () {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "email"
        self.scrollView.addSubview(emailTextField)
    }
    private func configureGenderSegmentControl () {
        self.genderSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(genderSegmentControl)
    }
    private func configureCreditCardTextField () {
        creditCardTextField.translatesAutoresizingMaskIntoConstraints = false
        creditCardTextField.placeholder = "number of credit card"
        self.scrollView.addSubview(creditCardTextField)
    }
    private func configureBioTextField () {
        bioTextField.translatesAutoresizingMaskIntoConstraints = false
        bioTextField.placeholder = "bio"
        self.bioTextField.spellCheckingType = .yes
        self.scrollView.addSubview(bioTextField)
    }
    
    private func setupConstraints () {
        let scrollArea = self.scrollView.contentLayoutGuide
        
        let leadingIndentUIOfAccountProperties = CGFloat(10)
        let trailingIndentUIOfAccountProperties = CGFloat(-10)
       
        let topIndentBetweenUIOfAccountProperties = CGFloat(20)
        let topIndentBetweenUI = CGFloat(5)
        let heightUIOfAccountProperties = CGFloat(20)

        NSLayoutConstraint.activate([
            
            self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.bottomAnchor),
            
            self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.topAnchor),
            self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.bottomAnchor, constant: 0),
                
            self.usernameLabel.topAnchor.constraint(equalTo: scrollArea.topAnchor, constant: 30.0),
            self.usernameLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.usernameLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.usernameTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.usernameTextField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.usernameTextField.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            
            self.passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.passwordLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.passwordLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.passwordLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            self.passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.passwordTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            
            self.emailLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.emailLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.emailLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.emailLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            self.emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.emailTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            
            self.genderLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.genderLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.genderLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.genderLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            self.genderSegmentControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.genderSegmentControl.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.genderSegmentControl.widthAnchor.constraint(equalToConstant: 160),
            self.genderSegmentControl.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            
            self.creditCardLabel.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.creditCardLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.creditCardLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.creditCardLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            self.creditCardTextField.topAnchor.constraint(equalTo: creditCardLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.creditCardTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.creditCardTextField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.creditCardTextField.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            
            self.bioLabel.topAnchor.constraint(equalTo: creditCardTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.bioLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.bioLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.bioLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
            
            self.bioTextField.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.bioTextField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            self.bioTextField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            self.bioTextField.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor, multiplier: 1),
        ])
    }
}
