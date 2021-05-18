//
//  AddingReviewPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 13.05.2021.
//

import Foundation
import UIKit

enum InsertingReviewError: String, Error {
    case invalidReview = "You entered invalid review"
}

protocol AddingReviewViewOutput: class {
    func viewDidAddReview(idUser: Int, text: String?)
    func viewDidDetailProduct() 
}


final class AddingReviewPresenter: TrackableMixIn {
    //MARK: Properties
    weak var viewInput: (AddingReviewViewInput & UIViewController & ShowAlert)?
    
    //MARK: Properties private
    private var requestFactory: RequestFactory
    private var reviewsDataRequestFactory: ReviewsDataRequestFactory
    
    //MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.reviewsDataRequestFactory = requestFactory.makeReviewsDataRequestFactory()
    }
    
    //MARK: Requests
    private func requestAddReview(idUser: Int, text: String) {
        reviewsDataRequestFactory.addReview(idUser: idUser, text: text) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let addReview):
                debugPrint (addReview)
                DispatchQueue.main.async {
                    guard addReview.result == 1 else {
                        self.track(.addReview(idUser: idUser, text: text))
                        self.viewInput?.showFailedAddingReview()
                        return
                    }
                    self.viewInput?.showSuccessAddingReview()
                }
            case .failure(let error):
                guard let viewInput = self.viewInput  else {
                    return
                }
                debugPrint (error.localizedDescription)
                DispatchQueue.main.async {
                    self.viewInput?.showError(forViewController: viewInput, withMessage: "Network error \(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK: Navigation
    private func popToDetailProductController() {
        self.viewInput?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private functions
    private func checkTextOfReview (text: String?) throws -> Bool {
        guard let countText = text?.count,
              countText > 0,
              self.viewInput?.addingReviewView.reviewTextView.text != AddingReviewView.Constant.placeholderForReview
               else {
            throw InsertingReviewError.invalidReview
        }
        return true
    }
    
    private func catchErrorInsertingReview ( doSomething: () throws -> Void) {
        guard let viewInput = viewInput  else {
            return
        }
        do {
           try doSomething()
        } catch InsertingReviewError.invalidReview {
            self.viewInput?.showError(forViewController: viewInput, withMessage: InsertingReviewError.invalidReview.rawValue)
        }
        catch {
            self.viewInput?.showError(forViewController: viewInput, withMessage: "A unacceptable error. You should contact to administrator")
        }
    }
}

// MARK: - AddingReviewViewOutput
extension AddingReviewPresenter: AddingReviewViewOutput {
    func viewDidAddReview(idUser: Int, text: String?) {
        self.catchErrorInsertingReview {
            guard let noOptionalText = text,
                  (try self.checkTextOfReview(text: text)) == true else {
                return
            }
            self.requestAddReview(idUser: idUser, text: noOptionalText)
        }
        
    }
    func viewDidDetailProduct() {
        self.popToDetailProductController()
    }
}



