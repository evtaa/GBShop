//
//  ContentCellModel.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import Foundation
struct ContentCellModel {
    var productName: String
    var idProduct: String
    var price: String
    var quantity: String
}

final class ContentCellModelFactory {
    static func cellModel (from model: Content) -> ContentCellModel {
        return ContentCellModel(productName: "Name: " + model.productName,
                                idProduct: "ID: " + String(model.idProduct),
                                price: "Price: " + String(model.price),
                                quantity: "Quantity: " + String(model.quantity))
    }
}
