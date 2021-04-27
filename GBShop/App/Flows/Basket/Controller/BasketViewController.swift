//
//  BasketViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 26.04.2021.
//

import UIKit

protocol BasketViewInput: class {
    
    var contentsResults: [Content] { get set }
    
    var basketView: BasketView {get}
    
    func showError(error: Error)
    
    func throbber(show: Bool)
}

final class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Private properties
    
    private let presenter: BasketViewOutput
    
    internal var basketView: BasketView {

            return self.view as! BasketView
    }
    
    internal var contentsResults = [Content]() {
        didSet {
            self.basketView.tableView.reloadData()
        }
    }
    private struct Constant {
        static let reuseIdentifier = "reuseId"
    }
    
    //MARK: Init
    
    init(presenter: BasketViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        self.view = BasketView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.presenter.viewDidBasket(idUser: 123)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        throbber(show: false)
    }
    
    //MARK: Private
    
    private func configure () {
        self.configureTableView()
        self.configureNavigationBar()
        self.configureRefreshControl()
    }
    
    private func configureTableView () {
        self.basketView.tableView.register(BasketCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
        self.basketView.tableView.delegate = self
        self.basketView.tableView.dataSource = self
    }
    
    private func configureNavigationBar () {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Basket"
        let barButtonItem = UIBarButtonItem(title: "Pay", style: .plain, target: self, action: #selector(payBasket))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func configureRefreshControl () {
        self.basketView.newRefreshControl.addTarget(self, action: #selector(refreshContentsBasket), for: .valueChanged)
    }
    
    //MARK: - Actions
    
    @objc func payBasket () {
        self.presenter.viewDidPayBasket(idUser: 123)
    }
    
    @objc func refreshContentsBasket () {
        self.presenter.viewDidBasket(idUser: 123)
    }
    
    //MARK: TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentsResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        guard let cell = dequeueCell as? BasketCell else {
            return dequeueCell
        }
        let content = self.contentsResults [indexPath.row]
        let contentModel = ContentCellModelFactory.cellModel(from: content)
        cell.configure(with: contentModel)
        return cell
    }
}

extension BasketViewController: BasketViewInput {
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
}
