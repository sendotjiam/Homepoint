//
//  DetailViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    
    // MARK: - Section
    private enum SectionType {
        case header, description, review, discussion, others, shipping
    }
    private let sections : [SectionType] = [
        .header, .description, .shipping, .review, .discussion, .others
    ]
    private var reviewList : Int = 10
    private var singlePrice = 100000
    private var discount = 50000
    
    // MARK: - Variable
    var qty = 1
    var price = 0
    var total = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar(shouldHide: true)
        setNavigationBar(type: .backSearchAndCart(isTransparent: true))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideTabBar(shouldHide: false)
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
        print("ADD TO CART")
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
    
    private func countTotalPrice() {
        price = singlePrice * qty
        total = price - discount
        qtyLabel.text = "\(qty)"
        let priceStr = price.separateInt(with: ".")
        let totalStr = total.separateInt(with: ".")
        let attributedPrice = "Rp\(priceStr)"
        discountedPriceLabel.attributedText = attributedPrice
            .strikethroughText(
                range: NSRange(
                    location: 0,
                    length: priceStr.count + 2
                )
            )
        priceLabel.text = "Rp\(totalStr)"
    }
    
    private func setPriceLabel() {
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
        print(nibs.count)
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
        case .review: return reviewList + 2
        case .discussion: return 3 + 1
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
        default: return UITableViewCell()
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
            cellHeader.colors = ["#F1C6B9", "#f1f1f1", "#000000"]
            cellHeader.didTapCompareButton = { [weak self] in
                print("HEADER")
            }
            return cellHeader as? T
        case .description:
            guard let cellDescription = cell as? DetailDescriptionViewCell
            else { return nil }
            cellDescription.didTapSeeMoreButton = { [weak self] in
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
                cellSeeMore.didTapSeeMoreButton = { [weak self] in
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
        default: return cell
        }
    }
}
