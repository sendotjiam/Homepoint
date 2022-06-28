//
//  DetailViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var realPriceLabel: UILabel!
    
    // MARK: - Section
    private enum SectionType {
        case header, description, review, discussion, others, shipping
    }
    private let sections : [SectionType] = [
        .header, .description, .shipping, .review, .discussion, .others
    ]
    private var reviewList : Int = 10
    
    // MARK: - Variable
    private var qty = 1.0
    private var price = 0.0
    private var total = 0.0
    private var discount : Double = 0.0
    private var discountedPrice = 0.0
    private var originalPrice = 0.0
    private var productData : ProductDataModel?
    private var otherProducts = [ProductDataModel]()
    
    private let vm = DetailViewModel()
    private let bag = DisposeBag()
    
    private let loader = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: ColorCollection.primaryColor.value,
        padding: 0
    )
    
    // MARK: - Life Cycle
    init(_ id: String) {
        super.init(nibName: Constants.DetailVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        vm.getProductAndOtherProducts(id: id)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backSearchAndCart(isTransparent: true))
    }
    
    // MARK: - Actions
    @IBAction func plusButtonTapped(_ sender: Any) {
        qty += 1
        countTotalPrice()
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if qty <= 1 { return }
        qty -= 1
        countTotalPrice()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
    }
}

extension DetailViewController {
    private func setupUI() {
        countTotalPrice()
        bottomContainerView.dropShadow(
            with: 0.1,
            radius: 4,
            offset: CGSize(width: 0, height: -4)
        )
        plusButton.roundedCorner(with: 4)
        minusButton.addBorder(width: 1, color: .lightGray)
        minusButton.roundedCorner(with: 4)
        addToCartButton.roundedCorner(with: 8)
        setupTableView()
        if #available(iOS 11.0, *) {
             tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    private func bindViewModel() {
        vm.error.subscribe { print($0.element) }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            guard let self = self,
                  let show = $0.element
            else { return }
            DispatchQueue.main.async {
                self.showLoader(self.loader, show)
                self.overlayView.isHidden = show ? false : true
            }
        }.disposed(by: bag)
        vm.successGetProduct.subscribe { [weak self] in
            self?.handleSuccessGetProduct($0.element)
        }.disposed(by: bag)
        vm.successGetOthersProducts.subscribe { [weak self] in
            self?.handleSuccessGetOtherProducts($0.element)
        }
    }
    
    private func handleSuccessGetProduct(
        _ product : ProductDataModel?
    ) {
        guard let data = product else { return }
        originalPrice = data.price
        discount = data.discount
        discountedPrice = originalPrice - discount
        countTotalPrice()
        self.productData = data
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func handleSuccessGetOtherProducts(
        _ products : [ProductDataModel]?
    ) {
        self.otherProducts = products ?? []
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func countTotalPrice() {
        price = originalPrice * qty
        discountedPrice = originalPrice - discount
        let priceStr = price.convertToCurrency()
        let discountedStr = discountedPrice.convertToCurrency()
        let attributedPrice = "\(priceStr)"
        realPriceLabel.attributedText = attributedPrice
            .strikethroughText(
                range: NSRange(
                    location: 0,
                    length: priceStr.count
                )
            )
        qtyLabel.text = "\(Int(qty))"
        discountedPriceLabel.text = "\(discountedStr)"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell([
            DetailHeaderViewCell.nib(),
            DetailDescriptionViewCell.nib(),
            ShippingOptionsViewCell.nib(),
            ReviewHeaderViewCell.nib(),
            ReviewListViewCell.nib(),
            ReviewSeeMoreViewCell.nib(),
            DiscussHeaderViewCell.nib(),
            DiscussListViewCell.nib(),
            OtherViewCell.nib()
        ], [
            DetailHeaderViewCell.identifier,
            DetailDescriptionViewCell.identifier,
            ShippingOptionsViewCell.identifier,
            ReviewHeaderViewCell.identifier,
            ReviewListViewCell.identifier,
            ReviewSeeMoreViewCell.identifier,
            DiscussHeaderViewCell.identifier,
            DiscussListViewCell.identifier,
            OtherViewCell.identifier
        ])
    }
    
    private func registerTableViewCell(
        _ nibs : [UINib],
        _ identifiers : [String]
    ) {
        for idx in 0..<nibs.count{
            tableView.register(
                nibs[idx],
                forCellReuseIdentifier: identifiers[idx]
            )
        }
    }
}

// MARK: - Navigation Bar
extension DetailViewController {
    override func searchTapped(sender: UIBarButtonItem) {
        let vc = SearchViewController("")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TableView
extension DetailViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch sections[section] {
        case .description : return productData?.description == "" ? 0 : 1
        case .review: return reviewList + 2
        case .discussion: return 3 + 1
        case .others : return otherProducts.isEmpty ? 0 : 1
        default: return 1
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        var cell : UITableViewCell?
        switch sections[indexPath.section] {
        case .header:
            cell = generateCell(DetailHeaderViewCell.identifier, indexPath)
        case .description:
            cell = generateCell(DetailDescriptionViewCell.identifier, indexPath)
        case .shipping:
            cell = generateCell(ShippingOptionsViewCell.identifier, indexPath)
        case .review:
            switch indexPath.row {
            case 0:
                cell = generateCell(ReviewHeaderViewCell.identifier, indexPath)
            case reviewList + 1:
                cell = generateCell(ReviewSeeMoreViewCell.identifier, indexPath)
            default:
                cell = generateCell(ReviewListViewCell.identifier, indexPath)
            }
        case .discussion:
            switch indexPath.row {
            case 0:
                cell = generateCell(DiscussHeaderViewCell.identifier, indexPath)
            default:
                cell = generateCell(DiscussListViewCell.identifier, indexPath)
            }
        case .others:
            cell = generateCell(OtherViewCell.identifier, indexPath)
        }
        return cell ?? UITableViewCell()
    }
    
    private func generateCell<T : UITableViewCell>(
        _ id: String,
        _ indexPath: IndexPath
    ) -> T? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: id,
            for: indexPath
        ) as? T
        switch sections[indexPath.section] {
        case .header:
            guard let cellHeader = cell as? DetailHeaderViewCell
            else { return nil }
            cellHeader.data = productData
            cellHeader.colors = ["#F1C6B9", "#f1f1f1", "#000000"]
            cellHeader.didTapCompareButton = {
                print("HEADER")
            }
            return cellHeader as? T
        case .description:
            guard let cellDescription = cell as? DetailDescriptionViewCell
            else { return nil }
            cellDescription.content = productData?.description
            cellDescription.didTapSeeMoreButton = {
                print("DESCRIPTION")
            }
            return cellDescription as? T
        case .review:
            switch indexPath.row {
            case 0:
                guard let cellHeader = cell as? ReviewHeaderViewCell
                else { return nil }
                return cellHeader as? T
            case reviewList + 1:
                guard let cellSeeMore = cell as? ReviewSeeMoreViewCell
                else { return nil }
                cellSeeMore.didTapSeeMoreButton = {
                    print("SEE MORE")
                }
                return cellSeeMore as? T
            default:
                guard let cellList = cell as? ReviewListViewCell
                else { return nil }
                return cellList as? T
            }
        case .discussion:
            switch indexPath.row {
            case 0:
                guard let cellHeader = cell as? DiscussHeaderViewCell
                else { return nil }
                
                return cellHeader as? T
            default:
                guard let cellList = cell as? DiscussListViewCell
                else { return nil }
                return cellList as? T
            }
        case .others:
            guard let cell = cell as? OtherViewCell
            else { return nil }
            cell.products = otherProducts
            cell.didSelectItem = { [weak self] in
                let vc = DetailViewController($0)
                self?.navigationController?
                    .pushViewController(
                        vc,
                        animated: true
                    )
            }
            return cell as? T
        default: return cell
        }
    }
}
