//
//  PersonalDataView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 02.05.2021.
//

import Foundation
import UIKit

class PersonalDataView: UIView {
    //MARK: Subviews
    let scrollView = UIScrollView()
    let dataUserView: DataUserViewDarkStyle
    let logoutButton = ButtonDarkStyle()
    
    // MARK: Init
    init(separatorFactoryAbstract: SeparatorFactoryAbstract) {
        dataUserView = DataUserViewDarkStyle(separatorFactoryAbstract: separatorFactoryAbstract)
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configureUI () {
        backgroundColor = .black
        configureScrollView()
        configureDataUserView()
        configureLogoutButton()
        setupConstraints()
    }
    
    // MARK: Private functions
    private func configureScrollView () {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
    }
    
    private func configureDataUserView () {
        dataUserView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(dataUserView)
    }
    
    private func configureLogoutButton () {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        scrollView.addSubview(self.logoutButton)
    }
    
    private func setupConstraints () {
        let scrollArea = self.scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor, constant: 0),
                
            dataUserView.topAnchor.constraint(equalTo: scrollArea.topAnchor, constant: 30.0),
            dataUserView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: 10),
            dataUserView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: -10),
            dataUserView.heightAnchor.constraint(equalToConstant: 350),
            
            logoutButton.topAnchor.constraint(equalTo: dataUserView.bottomAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: 3*UIScreen.main.bounds.width/4),
            logoutButton.trailingAnchor.constraint(equalTo: dataUserView.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
