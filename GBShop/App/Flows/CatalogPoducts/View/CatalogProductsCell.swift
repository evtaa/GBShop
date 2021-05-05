//
//  CatalogProductsCell.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import UIKit

class CatalogProductsCell: UITableViewCell {
    //MARK: Properties
    var tapAddingProduct: ((_ content: ProductCellModel) -> Void)?
    
    //MARK: Private properties
    private var product: ProductCellModel?
    
    //MARK: - SubView
    private(set) lazy var productNameLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var idProductLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    } ()
    
    private(set) lazy var addProductButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Add to a basket", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(addProductTouchUpInsideButton), for: .touchUpInside)
        return button
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
    func configure (with product: ProductCellModel) {
        self.product = product
        self.productNameLabel.text = product.productName
        self.priceLabel.text = product.price
        self.idProductLabel.text = product.idProduct
    }
    
    //MARK: - Actions
    
    @objc private func addProductTouchUpInsideButton () {
        guard let product = self.product
        else {
            return
        }
        tapAddingProduct? (product)
    }
    
    // MARK: - ConfigureUI
    override func prepareForReuse() {
        self.productNameLabel.text = nil
        self.priceLabel.text = nil
        self.idProductLabel.text = nil
    }
    
    private func configureUI () {
        self.configContentView()
        self.addProductNameLabel()
        self.addPriceLabel()
        self.addIdProductLabel()
        self.addAddProductButton()
    }
    
    private func configContentView () {
        self.contentView.backgroundColor = .black
    }
    
    private func addProductNameLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.productNameLabel)
        NSLayoutConstraint.activate([
            self.productNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 10),
            self.productNameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            self.productNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5)
        ])
    }
    
    private func addPriceLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.priceLabel)
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant: 10),
            self.priceLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            self.priceLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5)
        ])
    }
    
    private func addIdProductLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(idProductLabel)
        NSLayoutConstraint.activate([
            self.idProductLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            self.idProductLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            self.idProductLabel.widthAnchor.constraint(equalToConstant: 2 * UIScreen.main.bounds.width/5),
            self.idProductLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5),
        ])
    }
    
    private func addAddProductButton () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(addProductButton)
        NSLayoutConstraint.activate([
            self.addProductButton.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            self.addProductButton.leadingAnchor.constraint(equalTo: idProductLabel.trailingAnchor, constant: 5),
            self.addProductButton.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 0),
            self.addProductButton.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5),
        ])
    }
}
