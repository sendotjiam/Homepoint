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
    @IBOutlet weak var strikethroughPriceLabel: UILabel!
    @IBOutlet weak var priceLabel : UILabel!
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
        guard let data = data else { return }
        let imageUrl = URL(string: data.productImages[0].image)
        imageView.sd_setImage(with: imageUrl, completed: nil)
        nameLabel.text = data.name
        ratingLabel.text = "\(data.ratingAverage)"
        soldNumberLabel.text = "Terjual \(data.amountSold)"
        
        if data.discount == 0.0 {
            strikethroughPriceLabel.isHidden = true
            priceLabel.text = data.price.convertToCurrency()
        } else {
            let discountValue = (data.price * (data.discount / 100))
            let finalPrice = data.price - discountValue
            let price = data.price.convertToCurrency()
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
    
    class func nib() -> UINib {
        UINib(nibName: "LargeProductCardViewCell", bundle: nil)
    }
}

