//
//  AddingReviewViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 13.05.2021.
//

import UIKit

protocol AddingReviewViewInput: class {
    var addingReviewView: AddingReviewView {get}
    func showSuccessAddingReview ()
    func showFailedAddingReview ()
    func showError(forViewController: UIViewController, withMessage: String)
}

class AddingReviewViewController: UIViewController, UITextViewDelegate, ShowAlert {
    // MARK: Properties
    var addingReviewView: AddingReviewView {
        get {
            return self.view as! AddingReviewView
        }
    }
    private let presenter: AddingReviewViewOutput
    
    // MARK: Init
    init(presenter: AddingReviewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        self.view = AddingReviewView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    // MARK: Configure
    private func configure() {
        self.configureNavigationBar()
        self.configureTextView()
    }
    
    private func configureNavigationBar() {
        self.title = "Add a review"
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addReviewTouchUpInsideButton))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func configureTextView() {
        self.addingReviewView.reviewTextView.delegate = self
    }
    
    //MARK: Actions
    @objc private func addReviewTouchUpInsideButton () {
        let review = self.addingReviewView.reviewTextView.text 
        self.presenter.viewDidAddReview(idUser: 123, text: review)
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray {
                textView.text = nil
                textView.textColor = UIColor.white
            }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = "Enter a review"
                textView.textColor = UIColor.darkGray
            }
    }
}

extension AddingReviewViewController: AddingReviewViewInput {
    
    func  showSuccessAddingReview () {
        self.showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "A review was added", withTitleOfAction: "OK") { _ in
            self.presenter.viewDidDetailProduct()
        }
    }
    
    func  showFailedAddingReview () {
        self.showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "A review was't added", withTitleOfAction: "OK", handlerOfAction: nil)
    }
    
    
}
