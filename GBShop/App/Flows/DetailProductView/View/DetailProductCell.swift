//
//  DetailProductCell.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import UIKit

class DetailProductCell: UITableViewCell {
    //MARK: Properties
    var tapAddingProduct: ((_ detailProduct: DetailProductCellModel) -> Void)?
    var tapHidingShowingReviews: (() -> Void)?
    
    //MARK: Private properties
    private var detailProduct: DetailProductCellModel?
    
    //MARK: - SubView
    private(set) lazy var productNameLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var priceLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var descriptionLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()

    private(set) lazy var idProductLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    } ()
    
    private(set) lazy var addProductButton: ButtonDarkStyle = {
        let button = ButtonDarkStyle ()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to a basket", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(addProductTouchUpInsideButton), for: .touchUpInside)
        return button
    } ()
    
    private(set) lazy var hideShowReviewsButton: ButtonDarkStyle = {
        let button = ButtonDarkStyle ()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hide reviews", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(hideShowReviewsTouchUpInsideButton), for: .touchUpInside)
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
    func configure (with detailProduct: DetailProductCellModel, andHideOrShowReviewsButton: Bool) {
        switch andHideOrShowReviewsButton {
        case true:
            hideShowReviewsButton.setTitle("Show reviews", for: .normal)
        case false:
            hideShowReviewsButton.setTitle("Hide reviews", for: .normal)
        }
        self.detailProduct = detailProduct
        self.productNameLabel.text = detailProduct.productName
        self.priceLabel.text = detailProduct.price
        self.descriptionLabel.text = detailProduct.description
        self.idProductLabel.text = detailProduct.idProduct
    }
    
    //MARK: - Actions
    @objc private func addProductTouchUpInsideButton () {
        guard let detailProduct = self.detailProduct
        else {
            return
        }
        tapAddingProduct? (detailProduct)
    }
    
    @objc private func hideShowReviewsTouchUpInsideButton () {
        tapHidingShowingReviews? ()
    }
    
    // MARK: - ConfigureUI
    override func prepareForReuse() {
        self.productNameLabel.text = nil
        self.priceLabel.text = nil
        self.descriptionLabel.text = nil
        self.idProductLabel.text = nil
    }
    
    private func configureUI () {
        self.configContentView ()
        self.addProductNameLabel ()
        self.addPriceLabel ()
        self.addDescriptionLabel ()
        self.addIdProductLabel ()
        self.addAddProductButton ()
        self.addHideShowReviewsButton ()
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
        self.contentView.addSubview(self.priceLabel)
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant: 10),
            self.priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor)
        ])
    }
    
    private func addDescriptionLabel () {
        self.contentView.addSubview(self.descriptionLabel)
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor)
        ])
    }
    
    private func addIdProductLabel () {
        self.contentView.addSubview(idProductLabel)
        NSLayoutConstraint.activate([
            self.idProductLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10),
            self.idProductLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            self.idProductLabel.widthAnchor.constraint(equalToConstant: 2 * UIScreen.main.bounds.width/5),
            //self.idProductLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5),
        ])
    }
    
    private func addAddProductButton () {
        self.contentView.addSubview(addProductButton)
        NSLayoutConstraint.activate([
            self.addProductButton.topAnchor.constraint(equalTo: self.idProductLabel.topAnchor),
            self.addProductButton.leadingAnchor.constraint(equalTo: idProductLabel.trailingAnchor, constant: 5),
            self.addProductButton.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            self.addProductButton.bottomAnchor.constraint(equalTo: idProductLabel.bottomAnchor),
        ])
    }
    
    private func addHideShowReviewsButton () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(hideShowReviewsButton)
        NSLayoutConstraint.activate([
            self.hideShowReviewsButton.topAnchor.constraint(equalTo: self.idProductLabel.bottomAnchor,constant: 10),
            self.hideShowReviewsButton.leadingAnchor.constraint(equalTo: addProductButton.leadingAnchor),
            self.hideShowReviewsButton.trailingAnchor.constraint(equalTo: addProductButton.trailingAnchor),
            self.hideShowReviewsButton.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
        ])
    }
}
