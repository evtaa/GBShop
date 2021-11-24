//
//  BasketTableFooterView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 17.05.2021.
//

import UIKit

class BasketTableFooterView: UIView {
    // MARK: Properties
    let valueLabel = LabelDarkStyle()
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ConfigureUI
    private func configureUI () {
        backgroundColor = .darkGray
        configureValueLabel()
        setupConstraints()
    }
    
    private func configureValueLabel() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.backgroundColor = .darkGray
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0
        addSubview(valueLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                                        valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                        valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                                        valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                                        valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)])
    }
    // MARK: Public functions
    func configure (withValue value: Int) {
        valueLabel.text = "Order amount: \(value)"
    }
}
