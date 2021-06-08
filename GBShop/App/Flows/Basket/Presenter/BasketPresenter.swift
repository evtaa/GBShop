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
    
}


final class BasketPresenter {
    //MARK: Properties
    weak var viewInput: BasketViewInput?
    
    //MARK: Properties private
    private let basketData: BasketDataRequestFactory
    
    //MARK: Init
    init(basketDataRequestFactory: BasketDataRequestFactory) {
        self.basketData = basketDataRequestFactory
    }
    
    //MARK: Requests
    private func requestContentsFromBasket(idUser: Int) {
        basketData.getBasket(idUser: idUser) { [weak self] (response) in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
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
                    self.viewInput?.basketView.newRefreshControl.endRefreshing()
                }
            case .failure(let error):
                debugPrint (error.localizedDescription)
                DispatchQueue.main.async {
                    self.viewInput?.showError(error: error)
                }
            }
        }
    }
    
    private func requestPayBasket(idUser: Int) {
        basketData.payBasket(idUser: idUser) { [weak self] (response) in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            switch response.result {
            case .success(let payBasket):
                debugPrint (payBasket)
                DispatchQueue.main.async {
                    guard payBasket.result == 1 else {
                        self.viewInput?.showPaymentFailed()
                        return
                    }
                    self.viewInput?.showPaymentPassed()
                    self.viewInput?.contentsResults = []
                }
            case .failure(let error):
                debugPrint (error.localizedDescription)
                DispatchQueue.main.async {
                    self.viewInput?.showError(error: error)
                }
            }
        }
    }
}

// MARK: - SearchViewOutput
extension BasketPresenter: BasketViewOutput {
    func viewDidBasket(idUser: Int) {
        self.viewInput?.throbber(show: true)
        self.requestContentsFromBasket(idUser: 123)
    }
    func viewDidPayBasket(idUser: Int) {
        self.viewInput?.throbber(show: true)
        self.requestPayBasket(idUser: 123)
    }
}
