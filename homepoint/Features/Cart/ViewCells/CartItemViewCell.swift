//
//  CartItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/07/22.
//

import UIKit

final class CartItemViewCell: UITableViewCell {

    static let identifier = "CartItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var cartImageView : UIImageView!
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityView: UIStackView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
    }
    
}

extension CartItemViewCell {
    
    private func setupUI() {
        selectionStyle = .none
        cartImageView.clipsToBounds = true
        cartImageView.roundedCorner(with: 8)
        quantityView.roundedCorner(with: 16)
    }
    
    private func configureCell() {
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "CartItemViewCell", bundle: nil)
    }
}

