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
}


final class DetailProductPresenter: ShowAlert {
    //MARK: Properties
    weak var viewInput: (DetailProductViewInput & UIViewController & ShowAlert)?

    //MARK: Properties private
    private var requestFactory: RequestFactory
    private var basketDataRequestFactory: BasketDataRequestFactory
    private var catalogDataRequestFactory: ProductsDataRequestFactory
    private var reviewsDataRequestFactory: ReviewsDataRequestFactory
    
    
    
    //MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.basketDataRequestFactory = requestFactory.makeBasketDataRequestFactory()
        self.catalogDataRequestFactory = requestFactory.makeProductsDataRequestFactory()
        self.reviewsDataRequestFactory = requestFactory.makeReviewsDataRequestFactory()
    }
    
    //MARK: Requests
    private func requestGoodById(idProduct: Int) {
        catalogDataRequestFactory.downloadGoodById (idProduct: idProduct) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let downloadGoodById):
                debugPrint (downloadGoodById)
                DispatchQueue.main.async {
                    guard downloadGoodById.result == 12 else {
                        self.viewInput?.showNoDetailsProduct()
                        return
                    }
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
                    self.showError(forViewController: viewInput, withMessage: "Network error \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func requestCatalogReviews(idProduct: Int, pageNumber: Int) {
        reviewsDataRequestFactory.catalogReviews(idProduct: idProduct, pageNumber: pageNumber) { [weak self] (response) in
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
                    self.showError(forViewController: viewInput, withMessage: "Network error \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func requestAddToBasket(idProduct: Int, quantity: Int) {
        basketDataRequestFactory.addToBasket(idProduct: idProduct, quantity: quantity) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let addToBasket):
                debugPrint (addToBasket)
                DispatchQueue.main.async {
                    guard addToBasket.result == 1 else {
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
                    self.showError(forViewController: viewInput, withMessage: "Network error \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func requestRemoveReview(idComment: Int) {
        reviewsDataRequestFactory.removeReview(idComment: idComment) { [weak self] (response) in
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
                    self.showError(forViewController: viewInput, withMessage: "Network error \(error.localizedDescription)")
                }
            }
        }
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
    
 
}
