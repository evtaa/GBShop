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
    func throbberStart()
    func throbberStop()
    func showNoProducts()
    func showPaymentFailed()
    func showPaymentPassed()
    func hideResultsView()
}

final class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowAlert {
    //MARK: Private properties
    private let presenter: BasketViewOutput
    
    internal var basketView: BasketView {

            return self.view as! BasketView
    }
    
    internal var contentsResults = [Content]() {
        didSet {
            var sum = 0
             contentsResults.forEach { (item) in
                sum += item.price
            }
            let view = self.basketView.tableView.tableFooterView as? BasketTableFooterView
            view?.configure(withValue: sum)
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
    
    //MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFooterViewHeight(for: basketView.tableView.tableFooterView)
    }
    
    func updateFooterViewHeight(for footer: UIView?) {
        guard let footer = footer else { return }
        footer.frame.size.height = footer.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height
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
        throbberStop()
    }
    
    //MARK: ConfigureUI
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
        self.title = "Basket"
        let barButtonItem = UIBarButtonItem(title: "Pay", style: .plain, target: self, action: #selector(payBasket))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func configureRefreshControl () {
        self.basketView.refreshControl.addTarget(self, action: #selector(refreshContentsBasket), for: .valueChanged)
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
        cell.tapRemovingProduct = { [weak self] content in
            let set = CharacterSet(charactersIn: " ")
            let optionalIdProduct = content.idProduct.components(separatedBy: set).compactMap({Int($0)}).last
            guard let idProduct = optionalIdProduct,
                  let self = self
            else {
                return
            }
            self.presenter.viewDidDeleteFromBasket(idProduct: idProduct)
        }
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BasketViewController: BasketViewInput {
    
    
    func throbberStart() {
        DispatchQueue.main.async {
            self.basketView.indicator.startAnimating()
        }
    }
    
    func throbberStop() {
        DispatchQueue.main.async {
            self.basketView.indicator.stopAnimating()
            //self.basketView.indicator.removeFromSuperview()
        }
    }
    
    func showNoProducts() {
        self.basketView.resultLabel.text = "No products"
        self.basketView.resultView.isHidden = false
        self.contentsResults = []
        self.basketView.tableView.reloadData()
    }
    
    func showPaymentFailed() {
        self.basketView.resultLabel.text = "Payment failed"
        self.basketView.resultView.isHidden = false
        //self.contentsResults = []
        self.basketView.tableView.reloadData()
    }
    
    func showPaymentPassed() {
        self.basketView.resultLabel.text = "Payment passed"
        self.basketView.resultView.isHidden = false
        self.contentsResults = []
        self.basketView.tableView.reloadData()
    }
    
    func hideResultsView() {
        self.basketView.resultView.isHidden = true
    }
}
