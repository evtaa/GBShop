//
//  Analitica.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 16.05.2021.
//

import Foundation
import FirebaseAnalytics

enum AnalyticsEvent {
    case login (method: String, success: Bool)
    case logout (method: String)
    case signUp (method: String)
    case viewItemList (pageNumber: Int, idCategory: Int)
    case viewItem (idProduct: Int)
    case addToCart (idProduct: Int, quantity: Int)
    case removeFromCart(idProduct: Int)
    case purchase (idUser: Int)
    case addReview (idUser: Int, text: String)
    
    enum loginParams {
        static let methodDefault = "default"
    }
    enum logoutParams {
        static let methodDefault = "default"
    }
    enum signupParams {
        static let methodDefault = "default"
    }
}

protocol TrackableMixIn {
    func track (_ event: AnalyticsEvent)
    
}
extension TrackableMixIn {
    func track (_ event: AnalyticsEvent){
        switch event {
        case let .login(method, success):
            Analytics.logEvent(AnalyticsEventLogin, parameters: [
                                AnalyticsParameterMethod: method,
                                AnalyticsParameterSuccess: success])
        case let .logout(method):
            Analytics.logEvent("logout", parameters: [
                                AnalyticsParameterMethod : method])
        case let .signUp(method):
            Analytics.logEvent(AnalyticsEventSignUp, parameters: [
                                AnalyticsParameterMethod : method])
        case let .viewItemList(pageNumber, idCategory):
            Analytics.logEvent(AnalyticsEventViewItemList, parameters:
                                ["pageNumber": pageNumber,
                                 "idCategory": idCategory])
        case let .viewItem(idProduct):
            Analytics.logEvent(AnalyticsEventViewItem, parameters:
                                ["idProduct": idProduct ])
        case let .addToCart(idProduct, quantity):
            Analytics.logEvent(AnalyticsEventAddToCart, parameters:
                                ["idProduct": idProduct,
                                 "quantity": quantity])
        case let .removeFromCart(idProduct):
            Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters:
                                ["idProduct": idProduct ])
        case let .purchase(idUser):
            Analytics.logEvent(AnalyticsEventPurchase, parameters:
                                ["idUser": idUser ])
        case let .addReview(idUser, text):
            Analytics.logEvent("addReview", parameters:
                                ["idUser": idUser,
                                 "text": text])
        }
    }
}

