//
//  OrderListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit

final class OrderListViewCell: UITableViewCell {

    static let identifier = "OrderListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productAmountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Data
    var data : [String: Any] = [:] {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension OrderListViewCell {
    private func setupUI() {
        containerView.addBorder(
            width: 1,
            color: ColorCollection.blueLigthColor.value
        )
        containerView.roundedCorner(with: 8)
        containerView.dropShadow(
            with: 0.1,
            radius: 2,
            offset: CGSize(width: 0, height: 1)
        )
        productImageView.clipsToBounds = true
        productImageView.roundedCorner(with: 4)
        statusView.roundedCorner(with: 4)
        selectionStyle = .none
    }
    
    private func configureCell() {
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "OrderListViewCell", bundle: nil)
    }
}
