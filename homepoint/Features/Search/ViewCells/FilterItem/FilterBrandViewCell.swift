//
//  FilterBrandViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class FilterBrandViewCell: UITableViewCell {

    static let identifier = "FilterBrandViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var brands = ["Vishal", "Vishal", "Vishal"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension FilterBrandViewCell {
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BrandItemViewCell.nib(), forCellReuseIdentifier: BrandItemViewCell.idenfier)
    }
    
    class func nib() -> UINib {
        UINib(nibName: "FilterBrandViewCell", bundle: nil)
    }
}

// MARK: - TableView
extension FilterBrandViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrandItemViewCell.idenfier, for: indexPath) as? BrandItemViewCell
        return cell ?? UITableViewCell()
    }
}
