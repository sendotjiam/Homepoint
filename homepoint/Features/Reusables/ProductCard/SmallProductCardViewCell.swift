//
//  ProductCardViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit
import SDWebImage

final class SmallProductCardViewCell: UICollectionViewCell {

    static let identifier = "SmallProductCardViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var soldNumberLabel : UILabel!
    
    // MARK: - Data
    var data : ProductDataModel? {
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
            color: ColorCollection.ligthTextColor.value
        )
        containerView.roundedCorner(with: 8)
        containerView.dropShadow(
            with: 0.05,
            radius: 2,
            offset: CGSize(width: 0, height: 1)
        )
        containerView.clipsToBounds = true
    }
    
    private func configureCell() {
        guard let data = data else { return }
        let imageUrl = URL(string: data.productImages[0].image)
        imageView.sd_setImage(with: imageUrl, completed: nil)
        nameLabel.text = data.name
        priceLabel.text = "Rp\(data.price)"
        ratingLabel.text = "\(data.ratingAverage)"
        soldNumberLabel.text = "Terjual \(data.amountSold)"
    }
    
    class func nib() -> UINib { UINib(nibName: "SmallProductCardViewCell", bundle: nil) }
}
