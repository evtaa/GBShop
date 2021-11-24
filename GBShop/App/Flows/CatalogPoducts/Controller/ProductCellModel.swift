//
//  ProductCellModel.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 05.05.2021.
//

import Foundation
struct ProductCellModel {
    var productName: String
    var idProduct: String
    var price: String
}

final class ProductCellModelFactory {
    static func cellModel (from model: Product) -> ProductCellModel {
        return ProductCellModel(productName: "Name: " + model.productName,
                                idProduct: "ID: " + String(model.idProduct),
                                price: "Price: " + String(model.price))
    }
}
