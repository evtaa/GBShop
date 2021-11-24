//
//  DetailProductHeaderCell.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 10.05.2021.
//

import UIKit

class HeaderInSection: UITableViewHeaderFooterView {
    //MARK: - SubView
    private(set) lazy var titleLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    //MARK: - Init   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.configureUI ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configure (with title: String) {
        self.titleLabel.text = title
    }
    
    // MARK: - ConfigureUI
    override func prepareForReuse() {
        self.titleLabel.text = nil

    }
    
    private func configureUI () {
        self.configContentView()
        self.addTitleLabel()
    }
    
    private func configContentView () {
        self.contentView.backgroundColor = .darkGray
    }
    
    private func addTitleLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            self.titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5),
            self.titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
        ])
    }
}
