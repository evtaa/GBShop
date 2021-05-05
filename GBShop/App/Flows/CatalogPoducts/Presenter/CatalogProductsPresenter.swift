//
//  CatalogProductsPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import Foundation
import UIKit

protocol CatalogProductsViewOutput: class {
    func viewDidCatalogProducts(pageNumber: Int, idCategory: Int)
    func viewDidAddToBasket(idProduct: Int, quantity: Int)
}


final class CatalogProductsPresenter: CatchError {
    //MARK: Properties
    weak var viewInput: (CatalogProductsViewInput & UIViewController & ShowAlert)?

    //MARK: Properties private
    private var requestFactory: RequestFactory
    private var basketDataRequestFactory: BasketDataRequestFactory
    private var catalogDataRequestFactory: ProductsDataRequestFactory
    
    
    //MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.basketDataRequestFactory = requestFactory.makeBasketDataRequestFactory()
        self.catalogDataRequestFactory = requestFactory.makeProductsDataRequestFactory()
    }
    
    //MARK: Requests
    
    private func requestCatalogProducts(pageNumber: Int, idCategory: Int) {
        catalogDataRequestFactory.downloadCatalogData(pageNumber: pageNumber, idCategory: idCategory) { [weak self] (response) in
            guard let self = self else { return }
                self.viewInput?.throbberStop()
            switch response.result {
            case .success(let downloadCatalogData):
                debugPrint (downloadCatalogData)
                DispatchQueue.main.async {
                    guard !downloadCatalogData.isEmpty else {
                        self.viewInput?.showNoProducts()
                        return
                    }
                    self.viewInput?.hideResultsView()
                    self.viewInput?.productsResults = downloadCatalogData
                    self.viewInput?.catalogProductsView.newRefreshControl.endRefreshing()
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
            self.viewInput?.throbberStop()
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
}

// MARK: - SearchViewOutput
extension CatalogProductsPresenter: CatalogProductsViewOutput {
    func viewDidCatalogProducts(pageNumber: Int, idCategory: Int) {
        self.viewInput?.throbberStart()
        self.requestCatalogProducts(pageNumber: pageNumber, idCategory: idCategory)
    }
    
    func viewDidAddToBasket(idProduct: Int, quantity: Int) {
        self.viewInput?.throbberStart()
        self.requestAddToBasket(idProduct: idProduct, quantity: quantity)
    }
}
