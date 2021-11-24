//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import UIKit

class BasketCell: UITableViewCell {
    //MARK: Properties
    var tapRemovingProduct: ((_ content: ContentCellModel) -> Void)?
    
    //MARK: Private properties
    private var content: ContentCellModel?
    
    //MARK: - SubView
    private(set) lazy var productNameLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var quantityLabel: UILabel = {
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
    
    private(set) lazy var removeProductButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Remove from a basket", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(removeProductTouchUpInsideButton), for: .touchUpInside)
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
    func configure (with content: ContentCellModel) {
        self.content = content
        self.productNameLabel.text = content.productName
        self.quantityLabel.text = content.quantity
        self.priceLabel.text = content.price
        self.idProductLabel.text = content.idProduct
    }
    
    //MARK: - Actions
    
    @objc private func removeProductTouchUpInsideButton () {
        guard let content = self.content
        else {
            return
        }
        tapRemovingProduct? (content)
    }
    
    // MARK: - ConfigureUI
    override func prepareForReuse() {
        self.productNameLabel.text = nil
        self.quantityLabel.text = nil
        self.priceLabel.text = nil
        self.idProductLabel.text = nil
    }
    
    private func configureUI () {
        self.configContentView()
        self.addProductNameLabel()
        self.addQuantityLabel()
        self.addPriceLabel()
        self.addIdProductLabel()
        self.addRemoveProductButton()
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
    
    private func addQuantityLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.quantityLabel)
        NSLayoutConstraint.activate([
            self.quantityLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant: 10),
            self.quantityLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            self.quantityLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5)
        ])
      
    }
    
    private func addPriceLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.priceLabel)
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.quantityLabel.bottomAnchor, constant: 10),
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
    
    private func addRemoveProductButton () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(removeProductButton)
        NSLayoutConstraint.activate([
            self.removeProductButton.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            self.removeProductButton.leadingAnchor.constraint(equalTo: idProductLabel.trailingAnchor, constant: 5),
            self.removeProductButton.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 0),
            self.removeProductButton.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5),
        ])
    }
}
