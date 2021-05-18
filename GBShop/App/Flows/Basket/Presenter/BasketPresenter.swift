//
//  BasketPresenter.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 27.04.2021.
//

import Foundation

import UIKit

protocol BasketViewOutput: class {
    func viewDidBasket(idUser: Int)
    func viewDidPayBasket(idUser: Int)
    func viewDidDeleteFromBasket (idProduct: Int) 
}


final class BasketPresenter: CheckingDataUser, TrackableMixIn {
    //MARK: Properties
    weak var viewInput: (BasketViewInput & UIViewController & ShowAlert)?

    //MARK: Properties private
    private var requestFactory: RequestFactory
    private var basketDataRequestFactory: BasketDataRequestFactory
    
    //MARK: Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.basketDataRequestFactory = requestFactory.makeBasketDataRequestFactory()
    }
    
    //MARK: Requests
    private func requestContentsFromBasket(idUser: Int) {
        basketDataRequestFactory.getBasket(idUser: idUser) { [weak self] (response) in
            guard let self = self else { return }
                self.viewInput?.throbberStop()
            switch response.result {
            case .success(let getBasket):
                debugPrint (getBasket)
                DispatchQueue.main.async {
                    guard !getBasket.contents.isEmpty else {
                        self.viewInput?.showNoProducts()
                        return
                    }
                    self.viewInput?.hideResultsView()
                    self.viewInput?.contentsResults = getBasket.contents
                    self.viewInput?.basketView.refreshControl.endRefreshing()
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
    
    private func requestPayBasket(idUser: Int) {
        basketDataRequestFactory.payBasket(idUser: idUser) { [weak self] (response) in
            guard let self = self else { return }
            self.viewInput?.throbberStop()
            switch response.result {
            case .success(let payBasket):
                debugPrint (payBasket)
                DispatchQueue.main.async {
                    guard payBasket.result == 1 else {
                        self.track(.purchase(idUser: idUser))
                        self.viewInput?.showPaymentFailed()
                        return
                    }
                    self.viewInput?.showPaymentPassed()
                    self.viewInput?.contentsResults = []
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
    private func requestDeleteFromBasket(idProduct: Int) {
        basketDataRequestFactory.deleteFromBasket(idProduct: idProduct) { [weak self] (response) in
            guard let self = self else { return }
            self.viewInput?.throbberStop()
            switch response.result {
            case .success(let deleteFromBasket):
                debugPrint (deleteFromBasket)
                DispatchQueue.main.async {
                    guard deleteFromBasket.result == 1 else {
                        return
                    }
                    self.track(.removeFromCart(idProduct: idProduct))
                    self.requestContentsFromBasket(idUser: 123)
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
extension BasketPresenter: BasketViewOutput {
    func viewDidBasket(idUser: Int) {
        self.viewInput?.throbberStart()
        self.requestContentsFromBasket(idUser: 123)
    }
    func viewDidPayBasket(idUser: Int) {
        self.viewInput?.throbberStart()
        self.requestPayBasket(idUser: 123)
    }
    func viewDidDeleteFromBasket (idProduct: Int) {
        self.viewInput?.throbberStart()
        self.requestDeleteFromBasket(idProduct: idProduct)
    }
}
