//
//  BrandItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class BrandItemViewCell: UITableViewCell {

    static let idenfier = "BrandItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var brandLabel: UILabel!
    
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
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "BrandItemViewCell", bundle: nil)
    }
}
