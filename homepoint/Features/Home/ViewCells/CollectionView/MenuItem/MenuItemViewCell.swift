//
//  MenuItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit
import SDWebImage

final class MenuItemViewCell: UICollectionViewCell {
    
    static let identifier = "MenuItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    // MARK: - Variables
    var subCategory : ProductSubCategoryModel? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MenuItemViewCell {
    
    private func configureCell() {
        guard let subCategory = subCategory else { return }
        let imageUrl = URL(string: subCategory.icon)
        imageView.sd_setImage(with: imageUrl)
        labelView.text = subCategory.name
    }
    
    class func nib() -> UINib { UINib(nibName: "MenuItemViewCell", bundle: nil) }
}