//
//  AddingReviewView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 13.05.2021.
//

import UIKit

class AddingReviewView: UIView {
    //MARK: Properties
    struct Constant {
        static let placeholderForReview = "Enter a review"
    }
    
    //MARK: Subviews
    let scrollView = ScrollViewDarkStyle()
    var reviewTextView = TextViewDarkStyle()
    var addReviewButton = ButtonDarkStyle()
    
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
        self.configureReviewTextView ()
        self.setupConstraints()
    }
    
    // MARK: Private functions
    private func configureScrollView () {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    private func configureReviewTextView () {
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.text = Constant.placeholderForReview
        reviewTextView.font = UIFont.systemFont(ofSize: 16)
        reviewTextView.textColor = UIColor.darkGray
        self.scrollView.addSubview(reviewTextView)
    }

    private func setupConstraints () {
        let scrollArea = self.scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.topAnchor),
            self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.bottomAnchor, constant: 0),
            
            self.reviewTextView.topAnchor.constraint(equalTo: scrollArea.topAnchor, constant: 10),
            self.reviewTextView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: 10),
            self.reviewTextView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,constant: -10),
            self.reviewTextView.bottomAnchor.constraint (equalTo: scrollArea.bottomAnchor, constant: -200),
        ])
    }
}
