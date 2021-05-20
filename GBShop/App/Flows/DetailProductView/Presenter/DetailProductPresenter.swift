//
//  DetailProductPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 10.05.2021.
//

import Foundation
import UIKit

protocol DetailProductViewOutput: class {
    func viewDidDetailProduct(idProduct: Int, pageNumber: Int)
    func viewDidAddToBasket(idProduct: Int, quantity: Int)
    func viewDidApproveReview(idComment: Int)
    func viewDidRemoveReview(idComment: Int)
    func viewDidAddingReview()
}


final class DetailProductPresenter: TrackableMixIn {
    //MARK: Properties
    weak var viewInput: (DetailProductViewInput & UIViewController & ShowAlert)?

    //MARK: Properties private
    private var requestFactories: RequestFactories
    
    //MARK: Init
    init(requestFactories: RequestFactories) {
        self.requestFactories = requestFactories
    }
    
    //MARK: Requests
    private func requestGoodById(idProduct: Int) {
        requestFactories.productsRequestFactory.downloadGoodById (idProduct: idProduct) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let downloadGoodById):
                debugPrint (downloadGoodById)
                DispatchQueue.main.async {
                    guard downloadGoodById.result == 12 else {
                        self.viewInput?.showNoDetailsProduct()
                        return
                    }
                    self.track(.viewItem(idProduct: idProduct))
                    self.viewInput?.hideResultsView()
                    self.viewInput?.detailProductResult = downloadGoodById
                    self.viewInput?.detailProductView.refreshControl.endRefreshing()
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
    
    private func requestCatalogReviews(idProduct: Int, pageNumber: Int) {
        requestFactories.reviewsRequestFactory.catalogReviews(idProduct: idProduct, pageNumber: pageNumber) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let catalogReviews):
                debugPrint (catalogReviews)
                DispatchQueue.main.async {
                    guard !catalogReviews.reviews.isEmpty else {
                        return
                    }
                    self.viewInput?.hideResultsView()
                    self.viewInput?.reviewsResult = catalogReviews.reviews
                    self.viewInput?.detailProductView.refreshControl.endRefreshing()
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
    
    private func requestAddToBasket(idProduct: Int, quantity: Int) {
        requestFactories.basketRequestFactory.addToBasket(idProduct: idProduct, quantity: quantity) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let addToBasket):
                debugPrint (addToBasket)
                DispatchQueue.main.async {
                    guard addToBasket.result == 1 else {
                        return
                    }
                    self.track(.addToCart(idProduct: idProduct, quantity: quantity))
                    //self.requestContentsFromBasket(idUser: 123)
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
    
    private func requestRemoveReview(idComment: Int) {
        requestFactories.reviewsRequestFactory.removeReview(idComment: idComment) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let removeReview):
                debugPrint (removeReview)
                DispatchQueue.main.async {
                    guard removeReview.result == 1 else {
                        return
                    }
                    //self.requestContentsFromBasket(idUser: 123)
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
    private func pushAddingReviewController() {
        let controller = AddingReviewModuleBuilder.build(requestFactories: requestFactories)
        self.viewInput?.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - SearchViewOutput
extension DetailProductPresenter: DetailProductViewOutput {
    func viewDidDetailProduct(idProduct: Int, pageNumber: Int) {
        self.requestGoodById(idProduct: idProduct)
        self.requestCatalogReviews(idProduct: idProduct, pageNumber: pageNumber)
    }
    
    func viewDidAddToBasket(idProduct: Int, quantity: Int) {
        self.requestAddToBasket(idProduct: idProduct, quantity: quantity)
    }
    
    func viewDidApproveReview(idComment: Int) {
        
    }
    
    func viewDidRemoveReview(idComment: Int) {
        self.requestRemoveReview(idComment: idComment)
    }
    
    func viewDidAddingReview() {
        self.pushAddingReviewController()
    }
    
 
}
