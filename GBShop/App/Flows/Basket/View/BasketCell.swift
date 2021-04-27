//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import UIKit

class BasketCell: UITableViewCell {
    
    //MARK: - SubView
    
    private(set) lazy var productNameLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var idProductLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    } ()
    
    private(set) lazy var quantityLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func configure (with content: ContentCellModel) {
        self.productNameLabel.text = content.productName
        self.quantityLabel.text = content.quantity
        self.priceLabel.text = content.price
        self.idProductLabel.text = content.idProduct
    }
    
    // MARK: - ConfigureUI
    
    override func prepareForReuse() {
        self.productNameLabel.text = nil
        self.quantityLabel.text = nil
        self.priceLabel.text = nil
        self.idProductLabel.text = nil
    }
    
    private func configureUI () {
        self.addProductNameLabel()
        self.addQuantityLabel()
        self.addPriceLabel()
        self.addIdProductLabel()
    }
    
    private func addProductNameLabel () {
        self.contentView.addSubview(self.productNameLabel)
        NSLayoutConstraint.activate([
            self.productNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.productNameLabel.widthAnchor.constraint(equalToConstant: 100.0),
            self.productNameLabel.heightAnchor.constraint(equalToConstant: 50.0),
            self.productNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        ])
    }
    
    private func addQuantityLabel () {
        self.contentView.addSubview(self.quantityLabel)
        NSLayoutConstraint.activate([
            self.quantityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.quantityLabel.widthAnchor.constraint(equalToConstant: 100.0),
            self.quantityLabel.heightAnchor.constraint(equalToConstant: 50.0),
            self.quantityLabel.leadingAnchor.constraint(equalTo: self.productNameLabel.trailingAnchor, constant: 10)
        ])
      
    }
    
    private func addPriceLabel () {
        self.contentView.addSubview(self.priceLabel)
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.priceLabel.heightAnchor.constraint(equalToConstant: 50.0),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.quantityLabel.trailingAnchor, constant: 10),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
            
        ])
    }
    
    private func addIdProductLabel () {
        self.contentView.addSubview(idProductLabel)
        NSLayoutConstraint.activate([
            self.idProductLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant: 5),
            self.idProductLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.idProductLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.idProductLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
}
