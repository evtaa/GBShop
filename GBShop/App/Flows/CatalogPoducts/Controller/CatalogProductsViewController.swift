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

class CatalogProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowAlert,
                                     UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    //MARK: - Private properties
    private var searchController = SearchControllerDarkStyle(nibName: nil, bundle: nil)
    private let presenter: CatalogProductsViewOutput
    
    internal var catalogProductsView: CatalogProductsView {

            return self.view as! CatalogProductsView
    }
    private  var isActiveSearch: Bool = false
    internal var searchProducts = [Product]()
    internal var productsResults = [Product]()
    private struct Constant {
        static let reuseIdentifier = "reuseId"
    }
    
    //MARK: - Init
    init(presenter: CatalogProductsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
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
    
    //MARK: - ConfigureUI
    private func configure () {
        self.configureTableView()
        self.configureNavigationBar()
        self.configureSearchController()
        self.configureRefreshControl()
    }
    
    private func configureTableView () {
        self.catalogProductsView.tableView.register(CatalogProductsCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
        self.catalogProductsView.tableView.delegate = self
        self.catalogProductsView.tableView.dataSource = self
        
    }
    
    private func configureSearchController () {
        self.navigationItem.searchController = self.searchController;
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.becomeFirstResponder()
        self.searchController.configure()
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
        self.catalogProductsView.tableView.reloadData()
    }
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isActiveSearch ? self.searchProducts.count : self.productsResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        guard let cell = dequeueCell as? CatalogProductsCell else {
            return dequeueCell
        }
        let product = isActiveSearch ? self.searchProducts [indexPath.row] : self.productsResults [indexPath.row]
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
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = isActiveSearch ? self.searchProducts [indexPath.row] : self.productsResults [indexPath.row]
        self.presenter.viewDidDetailProductController(product: product)
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              text.count > 0
        else {
            isActiveSearch = false
            self.catalogProductsView.tableView.reloadData()
            return
        }
        let predicate: NSPredicate = NSPredicate(format:  "SELF contains %@", text.lowercased())
        self.searchProducts = productsResults.filter({ (product) -> Bool in
            return predicate.evaluate(with: product.productName.lowercased())
        })
        isActiveSearch = true
        self.catalogProductsView.tableView.reloadData()
    }
    
    //MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isActiveSearch = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isActiveSearch = false
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

