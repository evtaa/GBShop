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
    var reviewTextView = TextViewDarkStyle()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configureUI () {
        backgroundColor = .black
        configureReviewTextView ()
        setupConstraints()
    }
    
    // MARK: Private functions
    private func configureReviewTextView () {
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.text = Constant.placeholderForReview
        reviewTextView.font = UIFont.systemFont(ofSize: 16)
        reviewTextView.textColor = UIColor.darkGray
        addSubview(reviewTextView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            reviewTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            reviewTextView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            reviewTextView.bottomAnchor.constraint (equalTo: bottomAnchor, constant: -100),
        ])
    }
}
