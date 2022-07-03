//
//  CartViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/07/22.
//

import UIKit

final class CartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var promoButton: UIButton!
    
    // MARK: - Variables
    private enum SectionType {
        case items, purchase
    }
    private let sections : [SectionType] = [.items, .purchase]
    private var quantity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Keranjang"))
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        print("HAPUS")
    }
    
    @IBAction func promoButtonTapped(_ sender: Any) {
        print("PROMO")
    }
    
    @IBAction func purchaseButtonTapped(_ sender: Any) {
        print("PURCHASE")
    }
}

extension CartViewController {
    private func setupUI() {
        promoButton.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        promoButton.roundedCorner(with: 8)
        purchaseButton.roundedCorner(with: 8)
        purchaseButton.setTitle("Beli (\(quantity))", for: .normal)
        checkButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CartItemViewCell.nib(),
            forCellReuseIdentifier: CartItemViewCell.identifier
        )
    }
    
    private func checkButton() {
        if quantity == 0 {
            purchaseButton.isEnabled = false
            purchaseButton.alpha = 0.5
        } else {
            purchaseButton.isEnabled = true
            purchaseButton.alpha = 1
        }
    }
}

extension CartViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CartItemViewCell.identifier,
            for: indexPath
        ) as? CartItemViewCell
        return cell ?? UITableViewCell()
    }
}
