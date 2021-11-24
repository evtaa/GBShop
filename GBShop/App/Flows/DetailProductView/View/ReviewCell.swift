//
//  ReviewsCell.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import UIKit

class ReviewCell: UITableViewCell {
    //MARK: Properties
    var tapApprovingReview: ((_ review: ReviewCellModel) -> Void)?
    var tapRemovingReview: ((_ review: ReviewCellModel) -> Void)?
    
    //MARK: Private properties
    private var review: ReviewCellModel?
    
    //MARK: - SubView
    private(set) lazy var idUserLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var textReviewLabel: LabelDarkStyle = {
        let label = LabelDarkStyle ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    private(set) lazy var approveReviewButton: ButtonDarkStyle = {
        let button = ButtonDarkStyle ()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Approve this review", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(approveReviewTouchUpInsideButton), for: .touchUpInside)
        return button
    } ()
    
    private(set) lazy var removeReviewButton: ButtonDarkStyle = {
        let button = ButtonDarkStyle ()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remove this review", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(removeReviewTouchUpInsideButton), for: .touchUpInside)
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
    func configure (with review: ReviewCellModel) {
        self.review = review
        self.idUserLabel.text = review.idUser
        self.textReviewLabel.text = review.textReview
        
    }
    
    //MARK: - Actions
    @objc private func approveReviewTouchUpInsideButton () {
        guard let review = self.review
        else {
            return
        }
        tapApprovingReview? (review)
    }
    
    @objc private func removeReviewTouchUpInsideButton () {
        guard let review = self.review
        else {
            return
        }
        tapRemovingReview? (review)
    }
    
    // MARK: - ConfigureUI
    override func prepareForReuse() {
        self.idUserLabel.text = nil
        self.textReviewLabel.text = nil
    }
    
    private func configureUI () {
        self.configContentView()
        self.addIdUserLabel()
        self.addTextReviewLabel()
        self.addApproveReviewButton()
        self.addRemoveReviewButton()
    }
    
    private func configContentView () {
        self.contentView.backgroundColor = .black
    }
    
    private func addIdUserLabel () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.idUserLabel)
        NSLayoutConstraint.activate([
            self.idUserLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 10),
            self.idUserLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            self.idUserLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5)
        ])
    }
    
    private func addTextReviewLabel () {
        self.contentView.addSubview(self.textReviewLabel)
        NSLayoutConstraint.activate([
            self.textReviewLabel.topAnchor.constraint(equalTo: self.idUserLabel.bottomAnchor, constant: 10),
            self.textReviewLabel.leadingAnchor.constraint(equalTo: idUserLabel.leadingAnchor),
            self.textReviewLabel.trailingAnchor.constraint(equalTo: idUserLabel.trailingAnchor)
        ])
    }
    
    private func addApproveReviewButton () {
        self.contentView.addSubview(self.approveReviewButton)
        NSLayoutConstraint.activate([
            self.approveReviewButton.topAnchor.constraint(equalTo: self.textReviewLabel.bottomAnchor, constant: 10),
            self.approveReviewButton.widthAnchor.constraint(equalToConstant: 3 * UIScreen.main.bounds.width/5 - 15),
            self.approveReviewButton.trailingAnchor.constraint(equalTo: idUserLabel.trailingAnchor),
        ])
    }
    
    private func addRemoveReviewButton () {
        let marginGuide = self.contentView.layoutMarginsGuide
        self.contentView.addSubview(self.removeReviewButton)
        NSLayoutConstraint.activate([
            self.removeReviewButton.topAnchor.constraint(equalTo: self.approveReviewButton.bottomAnchor, constant: 10),
            self.removeReviewButton.leadingAnchor.constraint(equalTo: approveReviewButton.leadingAnchor),
            self.removeReviewButton.trailingAnchor.constraint(equalTo: approveReviewButton.trailingAnchor),
            self.removeReviewButton.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
        ])
    }
}

