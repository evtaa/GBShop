//
//  DetailProductView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import UIKit

class DetailProductView: TableScreenDarkStyle {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    private func configureUI () {
        self.configureTableView()
    }
    
    private func configureTableView () {
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 20
    }
    }
