//
//  BasketView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import UIKit

class BasketView: UIView {

    //MARK: - Subviews
    let tableView = UITableView ()
    let newRefreshControl = UIRefreshControl()
    let ResultView = UIView()
    let ResultLabel = UILabel()
    
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
        self.backgroundColor = .white
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
        self.tableView.rowHeight = 100
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
        self.ResultView.translatesAutoresizingMaskIntoConstraints = false
        self.ResultView.backgroundColor = .white
        self.ResultView.isHidden = true
        
        self.ResultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.ResultLabel.textColor = UIColor.darkGray
        self.ResultLabel.textAlignment = .center
        self.ResultLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addSubview(self.ResultView)
        self.ResultView.addSubview(self.ResultLabel)
    }
    
    private func setupConstraints () {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0.0),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.ResultView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.ResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.ResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.ResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.ResultLabel.topAnchor.constraint(equalTo: self.ResultView.topAnchor, constant: 12.0),
            self.ResultLabel.leadingAnchor.constraint(equalTo: self.ResultView.leadingAnchor),
            self.ResultLabel.trailingAnchor.constraint(equalTo: self.ResultView.trailingAnchor),
            
        ])
    }
}
