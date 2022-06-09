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
    
    // MARK: - Section
    private enum SectionType {
        case header, description, review, discussion, others, shipping
    }
    private let sections : [SectionType] = [
        .header, .description, .shipping, .review, .discussion, .others
    ]
    
    // MARK: - Variable
    var qty = 0
    var price = 1
    var total = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func plusButtonTapped(_ sender: Any) {
        qty += 1
        total = price * qty
        qtyLabel.text = "\(qty)"
        priceLabel.text = "Rp\(total)"
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if qty == 0 { return }
        qty -= 1
        total = price * qty
        qtyLabel.text = "\(qty)"
        priceLabel.text = "Rp\(total)"
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        print("ADD TO CART")
    }
}

extension DetailViewController {
    private func setupUI() {
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
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            DetailHeaderViewCell.nib(),
            forCellReuseIdentifier: DetailHeaderViewCell.identifier
        )
        tableView.register(
            DetailDescriptionViewCell.nib(),
            forCellReuseIdentifier: DetailDescriptionViewCell.identifier
        )
        tableView.register(
            ShippingOptionsViewCell.nib(),
            forCellReuseIdentifier: ShippingOptionsViewCell.identifier
        )
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
        case .header: return 1
        case .shipping: return 1
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
        default: return cell
        }
    }
}
