//
//  OrderFilterItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit

final class OrderFilterItemViewCell: UICollectionViewCell {

    static let identifier = "OrderFilterItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Data
    var data : OrderFilterItemCellModel? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension OrderFilterItemViewCell {
    private func setupUI() {
        containerView.roundedCorner(with: 8)
    }
    
    private func configureCell() {
        guard let data = data else { return }
        nameLabel.text = data.title
        if data.isSelected {
            containerView.backgroundColor = ColorCollection.primaryColor.value
            nameLabel.textColor = ColorCollection.whiteColor.value
            iconImageView.image = UIImage(named: data.imageUrl + ".selected")
        } else {
            containerView.backgroundColor = ColorCollection.whiteColor.value
            nameLabel.textColor = .black
            iconImageView.image = UIImage(named: data.imageUrl)
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "OrderFilterItemViewCell", bundle: nil)
    }
}
