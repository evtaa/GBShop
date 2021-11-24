//
//  ReviewCellModel.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import Foundation
struct ReviewCellModel {
    var idUser: String
    var textReview: String
}

final class ReviewCellModelFactory {
    static func cellModel (from model: ReviewOfProduct) -> ReviewCellModel {
        return ReviewCellModel(idUser: "Id user: " + String(model.idUser) ,
                               textReview: model.textReview)
    }
}
