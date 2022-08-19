//
//  FilterBrandViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class FilterBrandHeaderViewCell: UITableViewCell {

    static let identifier = "FilterBrandHeaderViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension FilterBrandHeaderViewCell {
    private func setupUI() {
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "FilterBrandHeaderViewCell", bundle: nil)
    }
}
