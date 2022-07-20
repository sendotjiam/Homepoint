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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var strikethroughPriceLabel: UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var soldNumberLabel : UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    
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
        imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_placeholder.large"))
        nameLabel.text = data.name
        ratingLabel.text = "\(data.ratingAverage)"
        soldNumberLabel.text = "Terjual \(data.amountSold)"
        
        if data.discount == 0.0 {
            discountView.isHidden = true
            strikethroughPriceLabel.isHidden = true
            priceLabel.text = data.price.convertToCurrency()
        } else {
            let discountValue = (data.price * (data.discount / 100))
            let finalPrice = data.price - discountValue
            let price = data.price.convertToCurrency()
            discountView.isHidden = false
            strikethroughPriceLabel.isHidden = false
            strikethroughPriceLabel.attributedText = price
                .strikethroughText(
                    color: .red,
                    range: NSRange(
                        location: 0,
                        length: price.count
                    )
                )
            priceLabel.text = finalPrice.convertToCurrency()
            discountLabel.text = "\(Int(data.discount))%"
        }
    }
    
    class func nib() -> UINib { UINib(nibName: "SmallProductCardViewCell", bundle: nil) }
}
