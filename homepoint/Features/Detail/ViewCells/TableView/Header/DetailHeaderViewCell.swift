//
//  DetailHeaderViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

class DetailHeaderViewCell: UITableViewCell {

    static let identifier = "DetailHeaderViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var soldNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var brandContainerView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var compareButtonView: UIStackView!
    
    var didTapCompareButton : (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func compareButtonTapped(_ sender: Any) {
        didTapCompareButton?()
    }
}


extension DetailHeaderViewCell {
    private func setupUI() {
        compareButtonView.roundedCorner(with: 8)
        brandContainerView.roundedCorner(with: 8)
        selectionStyle = .none
    }
    
    class func nib() -> UINib {
        UINib(nibName: "DetailHeaderViewCell", bundle: nil)
    }
}
