//
//  WishlistItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 30/06/22.
//

import UIKit
import SDWebImage

protocol WishlistItemInteraction : AnyObject {
    func didSelect(_ id: String)
    func didRemoveTapped(_ id: String)
    func didAddToCartTapped(_ id: String)
}

final class WishlistItemViewCell: UITableViewCell {

    static let identifier = "WishlistItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var soldAmountLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var checkboxView: UIView!
    
    
    // MARK: - Variables
    var data : WishlistDataModel? {
        didSet { configureCell() }
    }
    var isUnchecked = false {
        didSet { uncheckAll() }
    }
    
    weak var delegate : WishlistItemInteraction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        guard let id = data?.id else { return }
        delegate?.didRemoveTapped(id)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let id = data?.products.id else { return }
        delegate?.didAddToCartTapped(id)
    }
}

extension WishlistItemViewCell {
    private func setupUI() {
        selectionStyle = .none
        productImageView.clipsToBounds = true
        productImageView.roundedCorner(with: 8)
        addToCartButton.roundedCorner(with: 8)
        checkbox.delegate = self
    }
    
    private func configureCell() {
        guard let data = data?.products else { return }
        let imageUrl = URL(string: data.productImages[0].image)
        productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_placeholder.large"))
        productNameLabel.text = data.name
        priceLabel.text = data.price.convertToCurrency()
        ratingLabel.text = "\(data.ratingAverage)"
        soldAmountLabel.text = "Terjual \(data.amountSold)"
    }
    
    private func uncheckAll() {
        checkbox.isChecked = !isUnchecked
    }

    class func nib() -> UINib {
        UINib(nibName: "WishlistItemViewCell", bundle: nil)
    }
}

extension WishlistItemViewCell : CheckboxClickable {
    func didTap(_ isSelected: Bool) {
        if !isSelected { return }
        guard let id = data?.id else { return }
        delegate?.didSelect(id)
    }
}
