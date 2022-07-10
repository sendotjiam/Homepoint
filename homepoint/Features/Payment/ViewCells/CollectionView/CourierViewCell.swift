//
//  CourierViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

final class CourierCellModel {
    let title : String
    let image : String
    let price : Double
    
    init(title: String, image: String, price: Double) {
        self.title = title
        self.image = image
        self.price = price
    }
}

final class CourierViewCell: UICollectionViewCell {

    static let identifier = "CourierViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var courierImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var courier : CourierCellModel? {
        didSet { configureCell() }
    }
    
    override var isSelected: Bool {
        didSet {
            setSelected()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension CourierViewCell {
    private func setupUI() {
        containerView.backgroundColor = .white
        containerView.roundedCorner(with: 8)
        selectedImageView.image = UIImage(named: "ic_select")
    }
    
    private func configureCell() {
        guard let data = courier else { return }
        titleLabel.text = data.title
        courierImageView.image = UIImage(named: data.image)
        priceLabel.text = data.price == 0 ? "Gratis" : data.price.convertToCurrency()
    }
    
    private func setSelected() {
        if isSelected {
            containerView.backgroundColor = ColorCollection.lightBlueColor.value
            selectedImageView.image = UIImage(named: "ic_selected")
        } else {
            containerView.backgroundColor = .white
            selectedImageView.image = UIImage(named: "ic_select")
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "CourierViewCell", bundle: nil)
    }
}
