//
//  BrandItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class BrandCellModel {
    let title: String
    var isSelected : Bool
    
    init(_ title : String, _ isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

final class BrandItemViewCell: UITableViewCell {

    static let idenfier = "BrandItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var brandLabel: UILabel!
    
    // MARK: - Variables
    var brand : BrandCellModel? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkbox.isChecked = selected
    }
}

extension BrandItemViewCell {
    private func setupUI() {
        selectionStyle = .none
    }
    
    private func configureCell() {
        guard let brand = brand else { return }
        brandLabel.text = brand.title
    }
    
    class func nib() -> UINib {
        UINib(nibName: "BrandItemViewCell", bundle: nil)
    }
}
