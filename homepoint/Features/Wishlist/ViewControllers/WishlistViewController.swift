//
//  WishlistViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 29/06/22.
//

import UIKit

enum WishlistPageType {
    case normal, edit
}

final class WishlistViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var checkbox: UIView!
    @IBOutlet weak var itemAmount: UILabel!
    
    
    // MARK: - Variables
    var pageType : WishlistPageType = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .defaultNav)
    }
    
    @IBAction func cleanButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        switch pageType {
        case .normal:
            pageType = .edit
            editButton.setTitle("Batal", for: .normal)
            editButton.setTitleColor(ColorCollection.grayTextColor.value, for: .normal)
            checkbox.isHidden = false
            itemAmount.text = "Pilih semua (3)"
        case .edit:
            pageType = .normal
            editButton.setTitle("Atur", for: .normal)
            editButton.setTitleColor(ColorCollection.primaryColor.value, for: .normal)
            checkbox.isHidden = true
            itemAmount.text = "3 Produk"
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension WishlistViewController {
    private func setupUI() {
        checkbox.isHidden = true
        cleanButton.roundedCorner(with: 8)
        bottomContainerView.dropShadow(
            with: 0.1,
            radius: 4,
            offset: CGSize(width: 0, height: -4)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            WishlistItemViewCell.nib(),
            forCellReuseIdentifier: WishlistItemViewCell.identifier
        )
    }
}

// MARK: - TableView
extension WishlistViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        3
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WishlistItemViewCell.identifier,
            for: indexPath
        ) as? WishlistItemViewCell
        cell?.state = pageType
        return cell ?? UITableViewCell()
    }
}
