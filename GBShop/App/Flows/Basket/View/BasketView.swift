//
//  BasketView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import UIKit

class BasketView: TableScreenDarkStyle {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure () {
        configureTableView()
    }
    private func configureTableView () {
        let footerView = BasketTableFooterView()
        footerView.configure(withValue: 0)
        tableView.tableFooterView = footerView
    }
}
