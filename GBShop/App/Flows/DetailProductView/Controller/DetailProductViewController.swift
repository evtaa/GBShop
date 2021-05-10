//
//  DetailProductViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import Foundation
import UIKit

protocol DetailProductViewInput: class {
    var detailProductResult: GoodByIdResult? { get set }
    var reviewsResult: [ReviewOfProduct] {get set}
    var detailProductView: DetailProductView {get}
    func showNoDetailsProduct()
    func hideResultsView()
}

class DetailProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowAlert {
    //MARK: Private properties
    private let presenter: DetailProductViewOutput
    
    internal var detailProductView: DetailProductView {

            return self.view as! DetailProductView
    }
    
    var product: Product!
    private var isHiddenReviews: Bool = false {
        didSet {
            self.detailProductView.tableView.reloadData()
        }
    }

    var detailProductResult: GoodByIdResult? {
        didSet {
            self.detailProductView.tableView.reloadData()
        }
    }
    
    internal var reviewsResult = [ReviewOfProduct]() {
        didSet {
            self.detailProductView.tableView.reloadData()
        }
    }
    
    private struct Constant {
        static let reuseIdentifierDetailProduct = "reuseIdDetailProduct"
        static let reuseIdentifierReview = "reuseIdReview"
        static let reuseIdentifierHeaderInSection = "reuseIdHeaderInSection"
    }
    
    //MARK: Init
    init(presenter: DetailProductViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = DetailProductView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.presenter.viewDidDetailProduct(idProduct: product.idProduct, pageNumber: 123)
    }
    
    //MARK: ConfigureUI
    private func configure () {
        self.configureTableView()
        self.configureNavigationBar()
        self.configureRefreshControl()
    }
    
    private func configureTableView () {
        self.detailProductView.tableView.register(DetailProductCell.self, forCellReuseIdentifier: Constant.reuseIdentifierDetailProduct)
        self.detailProductView.tableView.register(ReviewCell.self, forCellReuseIdentifier: Constant.reuseIdentifierReview)
        self.detailProductView.tableView.register(HeaderInSection.self, forHeaderFooterViewReuseIdentifier: Constant.reuseIdentifierHeaderInSection)
        self.detailProductView.tableView.delegate = self
        self.detailProductView.tableView.dataSource = self
    }
    
    private func configureNavigationBar () {
        self.title = "Description"
    }
    
    private func configureRefreshControl () {
        self.detailProductView.refreshControl.addTarget(self, action: #selector(refreshDetailProduct), for: .valueChanged)
    }
    
    //MARK: - Actions
    @objc func refreshDetailProduct () {
        self.presenter.viewDidDetailProduct(idProduct: product.idProduct, pageNumber: 123)
    }
    
    //MARK: TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.isHiddenReviews ? 1:2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return reviewsResult.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let dequeueCell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifierDetailProduct, for: indexPath)
            guard let detailProductResult = self.detailProductResult,
                  let cell = dequeueCell as? DetailProductCell else {
                return dequeueCell
            }
            let detailProductModel = DetailProductCellModelFactory.cellModel(from: detailProductResult, and: product)
            cell.configure(with: detailProductModel, andHideOrShowReviewsButton: isHiddenReviews)
            
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
            cell.tapHidingShowingReviews = { [weak self] in
                guard let self = self else {
                    return
                }
                self.isHiddenReviews.toggle()
            }
            
            return cell
        case 1:
            let dequeueCell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifierReview, for: indexPath)
            guard let cell = dequeueCell as? ReviewCell else {
                return dequeueCell
            }
            let review = self.reviewsResult [indexPath.row]
            let reviewModel = ReviewCellModelFactory.cellModel(from: review)
            cell.configure(with: reviewModel)
            
            cell.tapApprovingReview = { [weak self] review in
                guard let self = self
                else {
                    return}
                self.presenter.viewDidApproveReview(idComment: 123)
            }
            cell.tapRemovingReview = { [weak self] review in
                guard let self = self
                else {
                    return}
                self.presenter.viewDidRemoveReview(idComment: 123)
            }
            
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dequeueCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.reuseIdentifierHeaderInSection)
        guard let cell = dequeueCell as? HeaderInSection else {
            return dequeueCell
        }
        switch section {
        case 0:
            cell.configure(with: "Product description")
        case 1:
            cell.configure(with: "Reviews")
        default:
            return cell
        }
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailProductViewController: DetailProductViewInput {
  
    func showNoDetailsProduct() {
        self.detailProductView.resultLabel.text = "No products"
        self.detailProductView.resultView.isHidden = false
        //self.detailProductResult = nil
        self.detailProductView.tableView.reloadData()
    }
    
    func hideResultsView() {
        self.detailProductView.resultView.isHidden = true
    }
}

