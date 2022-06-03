//
//  ProductCardViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit

final class SmallProductCardViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var soldNumberLabel : UILabel!
    
    // MARK: - Data
    var data : [String: Any] = [:] {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension SmallProductCardViewCell {
    private func setupUI() {
        containerView.addBorder(
            width: 1,
            color: .black
        )
        containerView.roundedCorner(with: 8)
        containerView.dropShadow(
            with: 0.05,
            radius: 2,
            offset: CGSize(width: 0, height: 1)
        )
    }
    
    private func configureCell() {
        
    }
}
