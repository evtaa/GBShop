//
//  DataUserViewDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 18.05.2021.
//

import UIKit

class DataUserViewDarkStyle: UIView {
    // MARK: - Properties
    var separatorFactoryAbstract: SeparatorFactoryAbstract
    let containerView = UIStackView()
    let containerGenderView = UIStackView()
    let usernameLabel = LabelDarkStyle()
    let usernameTextField = TextFieldDarkStyle()
    let passwordLabel = LabelDarkStyle()
    let passwordTextField = TextFieldDarkStyle()
    let emailLabel = LabelDarkStyle()
    let emailTextField = TextFieldDarkStyle()
    let genderLabel = LabelDarkStyle()
    let genderSegmentControl = SegmentedControlDarkStyle(items: ["Male", "Female"])
    let creditCardLabel = LabelDarkStyle()
    let creditCardTextField = TextFieldDarkStyle()
    let bioLabel = LabelDarkStyle()
    let bioTextField = TextFieldDarkStyle()
    
    // MARK: - Init
    required init(separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.separatorFactoryAbstract = separatorFactoryAbstract
        super.init(frame: .zero)
        self.configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure () {
        backgroundColor = .black
        configureContainerView()
        configureContainerGenderView()
        configureUsernameLabel ()
        configureUsernameTextField ()
        configurePasswordLabel ()
        configurePasswordTextField ()
        configureEmailLabel ()
        configureEmailTextField ()
        configureGenderLabel ()
        configureGenderSegmentControl ()
        configureCreditCardLabel ()
        configureCreditCardTextField ()
        configureBioLabel ()
        configureBioTextField ()
        setupConstraints()
    }
    private func configureContainerView() {
        let indentBetweenProperties = CGFloat(10)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.distribution = .fillProportionally
        containerView.alignment = .fill
        containerView.spacing = .zero
        containerView.addArrangedSubview(usernameLabel)
        containerView.addArrangedSubview(usernameTextField)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        containerView.addArrangedSubview(passwordLabel)
        containerView.addArrangedSubview(passwordTextField)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        containerView.addArrangedSubview(emailLabel)
        containerView.addArrangedSubview(emailTextField)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        containerView.addArrangedSubview(genderLabel)
        containerView.addArrangedSubview(containerGenderView)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        containerView.addArrangedSubview(creditCardLabel)
        containerView.addArrangedSubview(creditCardTextField)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        containerView.addArrangedSubview(bioLabel)
        containerView.addArrangedSubview(bioTextField)
        addSubview(containerView)
    }
    private func configureContainerGenderView() {
        containerGenderView.axis = .horizontal
        containerGenderView.distribution = .fill
        containerGenderView.alignment = .fill
        containerGenderView.spacing = .zero
        containerGenderView.addArrangedSubview(genderSegmentControl)
        containerGenderView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent())
    }
    private func  configureUsernameLabel () {
        usernameLabel.text = "Username:"
    }
    private func configurePasswordLabel () {
        passwordLabel.text = "Password:"
    }
    private func configureEmailLabel () {
        emailLabel.text = "Email:"
    }
    private func configureGenderLabel () {
        genderLabel.text = "Gender:"
    }
    private func configureCreditCardLabel () {
        creditCardLabel.text = "Number of credit card:"
    }
    private func configureBioLabel () {
        bioLabel.text = "Bio:"
    }
    
    private func configureUsernameTextField () {
        usernameTextField.placeholder = "username"
    }
    private func configurePasswordTextField () {
        passwordTextField.placeholder = "password"
    }
    private func configureEmailTextField () {
        emailTextField.placeholder = "email"
    }
    private func configureGenderSegmentControl () {
        genderSegmentControl.translatesAutoresizingMaskIntoConstraints = false
    }
    private func configureCreditCardTextField () {
        creditCardTextField.placeholder = "number of credit card"
    }
    private func configureBioTextField () {
        bioTextField.placeholder = "bio"
        bioTextField.spellCheckingType = .yes
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                                        containerView.topAnchor.constraint(equalTo: topAnchor),
                                        containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                        containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                        genderSegmentControl.widthAnchor.constraint(equalToConstant:160),
                                        genderSegmentControl.heightAnchor.constraint(equalToConstant:20)])
    }
}
