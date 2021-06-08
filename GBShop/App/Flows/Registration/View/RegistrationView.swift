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
    var usernameLabel = UILabel()
    var usernameTextField = UITextField()
    var passwordLabel = UILabel()
    var passwordTextField = UITextField()
    var emailLabel = UILabel()
    var emailTextField = UITextField()
    var genderLabel = UILabel()
    var genderSegmentControl = UISegmentedControl(items: ["Male", "Female"])
    var creditCardLabel = UILabel()
    var creditCardTextField = UITextField()
    var bioLabel = UILabel()
    var bioTextField = UITextField()
    
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
        self.configureForLabelOfAccountProperties(for: &self.usernameLabel, withTitle: "Username:")
    }
    private func configurePasswordLabel () {
        self.configureForLabelOfAccountProperties(for: &self.passwordLabel, withTitle: "Password:")
    }
    private func configureEmailLabel () {
        self.configureForLabelOfAccountProperties(for: &self.emailLabel, withTitle: "Email:")
    }
    private func configureGenderLabel () {
        self.configureForLabelOfAccountProperties(for: &self.genderLabel, withTitle: "Gender:")
    }
    private func configureCreditCardLabel () {
        self.configureForLabelOfAccountProperties(for: &self.creditCardLabel, withTitle: "Number of credit card:")
    }
    private func configureBioLabel () {
        self.configureForLabelOfAccountProperties(for: &self.bioLabel, withTitle: "Bio:")
    }
    
    private func configureUsernameTextField () {
        self.configureForTextFieldOfAccountProperties(for: &self.usernameTextField, withTextPlaceholder: "username")
    }
    private func configurePasswordTextField () {
        self.configureForTextFieldOfAccountProperties(for: &self.passwordTextField, withTextPlaceholder: "password")
    }
    private func configureEmailTextField () {
        self.configureForTextFieldOfAccountProperties(for: &self.emailTextField, withTextPlaceholder: "email")
    }
    private func configureGenderSegmentControl () {
        self.genderSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.genderSegmentControl.setTitle("Male", forSegmentAt: 0)
        self.genderSegmentControl.setTitle("Female", forSegmentAt: 1)
        self.genderSegmentControl.selectedSegmentIndex = 0
        self.genderSegmentControl.layer.cornerRadius = 5.0
        self.genderSegmentControl.backgroundColor = .gray
        self.genderSegmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)], for: .normal)
        self.scrollView.addSubview(genderSegmentControl)
    }
    private func configureCreditCardTextField () {
        self.configureForTextFieldOfAccountProperties(for: &self.creditCardTextField, withTextPlaceholder: "number of credit card")
    }
    private func configureBioTextField () {
        self.configureForTextFieldOfAccountProperties(for: &self.bioTextField, withTextPlaceholder: "bio")
    }
    
    private func configureForLabelOfAccountProperties (for label: inout UILabel, withTitle title: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = title
        self.scrollView.addSubview(label)
    }
    
    private func configureForTextFieldOfAccountProperties (for textField: inout UITextField, withTextPlaceholder placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = UIFont.systemFont(ofSize: 18.0)
        self.scrollView.addSubview(textField)
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
                
            self.usernameLabel.topAnchor.constraint(equalTo: scrollArea.topAnchor, constant: 30.0),
            self.usernameLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.usernameLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.usernameTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.usernameTextField.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            
            self.passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.passwordLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.passwordLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.passwordLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.passwordTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.passwordTextField.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            
            self.emailLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.emailLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.emailLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.emailLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.emailTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.emailTextField.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.emailTextField.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            
            self.genderLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.genderLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.genderLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.genderLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.genderSegmentControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.genderSegmentControl.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.genderSegmentControl.widthAnchor.constraint(equalToConstant: 130.0),
            self.genderSegmentControl.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            
            self.creditCardLabel.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.creditCardLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.creditCardLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.creditCardLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.creditCardTextField.topAnchor.constraint(equalTo: creditCardLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.creditCardTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.creditCardTextField.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.creditCardTextField.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            
            self.bioLabel.topAnchor.constraint(equalTo: creditCardTextField.bottomAnchor, constant: topIndentBetweenUIOfAccountProperties),
            self.bioLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.bioLabel.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.bioLabel.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties),
            
            self.bioTextField.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: topIndentBetweenUI),
            self.bioTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: leadingIndentUIOfAccountProperties),
            self.bioTextField.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: trailingIndentUIOfAccountProperties),
            self.bioTextField.heightAnchor.constraint(equalToConstant: heightUIOfAccountProperties)
        ])
    }
}
