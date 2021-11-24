//
//  CatalogProductsViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.05.2021.
//

import UIKit

protocol CatalogProductsViewInput: class {
    var productsResults: [Product] { get set }
    var catalogProductsView: CatalogProductsView {get}
    func showNoProducts()
    func hideResultsView()
}

class CatalogProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowAlert {
    //MARK: Private properties
    private let presenter: CatalogProductsViewOutput
    
    internal var catalogProductsView: CatalogProductsView {

            return self.view as! CatalogProductsView
    }
    
    internal var productsResults = [Product]() {
        didSet {
            self.catalogProductsView.tableView.reloadData()
        }
    }
    private struct Constant {
        static let reuseIdentifier = "reuseId"
    }
    
    //MARK: Init
    init(presenter: CatalogProductsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = CatalogProductsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.presenter.viewDidCatalogProducts(pageNumber: 123, idCategory: 123)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: ConfigureUI
    private func configure () {
        self.configureTableView()
        self.configureNavigationBar()
        self.configureRefreshControl()
    }
    
    private func configureTableView () {
        self.catalogProductsView.tableView.register(CatalogProductsCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
        self.catalogProductsView.tableView.delegate = self
        self.catalogProductsView.tableView.dataSource = self
    }
    
    private func configureNavigationBar () {
        self.title = "Search"
    }
    
    private func configureRefreshControl () {
        self.catalogProductsView.refreshControl.addTarget(self, action: #selector(refreshProductsCatalog), for: .valueChanged)
    }
    
    //MARK: - Actions
    @objc func refreshProductsCatalog () {
        self.presenter.viewDidCatalogProducts(pageNumber: 123, idCategory: 123)
    }
    
    //MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        guard let cell = dequeueCell as? CatalogProductsCell else {
            return dequeueCell
        }
        let product = self.productsResults [indexPath.row]
        let productModel = ProductCellModelFactory.cellModel(from: product)
        cell.configure(with: productModel)
        cell.tapAddingProduct = { [weak self] product in
            let set = CharacterSet(charactersIn: " ")
            let optionalIdProduct = product.idProduct.components(separatedBy: set).compactMap({Int($0)}).last
            guard let idProduct = optionalIdProduct,
                  let self = self
            else {
                return
            }
            self.presenter.viewDidAddToBasket(idProduct: idProduct, quantity: 1)
        }
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = self.productsResults[indexPath.row]
        self.presenter.viewDidDetailProductController(product: product)
    }
    
}

extension CatalogProductsViewController: CatalogProductsViewInput {
    
    func showNoProducts() {
        self.catalogProductsView.resultLabel.text = "No products"
        self.catalogProductsView.resultView.isHidden = false
        self.productsResults = []
        self.catalogProductsView.tableView.reloadData()
    }
    
    func hideResultsView() {
        self.catalogProductsView.resultView.isHidden = true
    }
}

