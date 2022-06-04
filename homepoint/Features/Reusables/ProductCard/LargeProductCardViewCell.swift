//
//  LargeProductCardViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit

final class LargeProductCardViewCell: UICollectionViewCell {

    static let identifier = "LargeProductCardViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var bottomView : UIView!
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

extension LargeProductCardViewCell {
    private func setupUI() {
        containerView.clipsToBounds = true
        containerView.addBorder(
            width: 1,
            color: ColorCollection.ligthTextColor.value
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
    
    class func nib() -> UINib {
        UINib(nibName: "LargeProductCardViewCell", bundle: nil)
    }
}

