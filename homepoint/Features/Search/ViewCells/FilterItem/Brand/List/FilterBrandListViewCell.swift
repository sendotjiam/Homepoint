//
//  FilterBrandListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 27/06/22.
//

import UIKit

final class FilterBrandListViewCell: UITableViewCell {

    static let identifier = "FilterBrandListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    var brands = [String]() {
        didSet { configureCell() }
    }
    var filteredBrands = [BrandCellModel]()
    var temp = [BrandCellModel]()
    var selectedBrands : [String : Bool] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
    }
}

extension FilterBrandListViewCell {
    private func setupUI() {
        selectionStyle = .none
        searchView.roundedCorner(with: 6)
        searchView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        
        searchField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            BrandItemViewCell.nib(),
            forCellReuseIdentifier: BrandItemViewCell.idenfier
        )
    }
    
    private func configureCell() {
        tableViewHeight.constant = CGFloat(brands.count) * 36.0
        brands.forEach { brand in
            filteredBrands.append(BrandCellModel(brand))
            selectedBrands[brand] = false
        }
        temp = filteredBrands
        tableView.reload()
    }
    
    class func nib() -> UINib {
        UINib(nibName: "FilterBrandListViewCell", bundle: nil)
    }
}

extension FilterBrandListViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
}

extension FilterBrandListViewCell:
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        brands.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BrandItemViewCell.idenfier,
            for: indexPath
        ) as? BrandItemViewCell
        cell?.brand = filteredBrands[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let key = filteredBrands[indexPath.row].title
        selectedBrands[key]?.toggle()
    }
}

