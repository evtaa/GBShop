//
//  CatalogProductsView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import UIKit

class CatalogProductsView: TableScreenDarkStyle {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    private func configure () {
        self.accessibilityIdentifier = "catalogProductsView"
    }
}
