//
//  DetailProductCellModel.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import Foundation
struct DetailProductCellModel {
    var productName: String
    var price: String
    var description: String
    var idProduct: String
}

final class DetailProductCellModelFactory {
    static func cellModel (from model: GoodByIdResult, and product: Product) -> DetailProductCellModel {
        return DetailProductCellModel(productName: "Name: " + model.productName,
                                      price: "Price: " + String(model.productPrice),
                                      description: "Description: " + String(model.productDescription),
                                      idProduct: "ID: " + String(product.idProduct))
    }
}
