//
//  CatalogProductsView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import UIKit

class CatalogProductsView: UIView {
  
    //MARK: - Subviews
    let tableView = UITableView ()
    let newRefreshControl = UIRefreshControl()
    let resultView = UIView()
    let resultLabel = UILabel()
    
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
        self.backgroundColor = .black
        self.configureRefreshControl()
        self.configureTableView()
        self.addEmptyResultView()
        self.setupConstraints()
    }
    
    private func configureRefreshControl () {
        self.newRefreshControl.tintColor = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 0.7)
    }
    
    private func configureTableView () {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100

        self.tableView.separatorInset = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 5.0)
        self.tableView.isHidden = false
        self.tableView.tableFooterView = UIView ()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = newRefreshControl
        } else {
            tableView.addSubview(newRefreshControl)
        }
        self.addSubview(self.tableView)
    }
    
    private func addEmptyResultView() {
        self.resultView.translatesAutoresizingMaskIntoConstraints = false
        self.resultView.backgroundColor = .black
        self.resultView.isHidden = true
        
        self.resultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.resultLabel.textColor = .white
        self.resultLabel.textAlignment = .center
        self.resultLabel.font = UIFont.systemFont(ofSize: 16.0)
        
        self.addSubview(self.resultView)
        self.resultView.addSubview(self.resultLabel)
    }
    
    private func setupConstraints () {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0.0),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.resultView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.resultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.resultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.resultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.resultLabel.topAnchor.constraint(equalTo: self.resultView.topAnchor, constant: 12.0),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.resultView.leadingAnchor),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor),
        ])
    }
}
