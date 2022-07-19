//
//  WishlistItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 30/06/22.
//

import UIKit
import SDWebImage

protocol WishlistItemInteraction : AnyObject {
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
    var state : WishlistPageType? {
        didSet { hideView() }
    }
    var shouldChecked : Bool = false {
        didSet {
            checkbox.isChecked = shouldChecked
        }
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
    }
    
    private func configureCell() {
        guard let data = data?.products else { return }
        let imageUrl = URL(string: data.productImages[0].image)
        productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_dummy"))
        productNameLabel.text = data.name
        priceLabel.text = data.price.convertToCurrency()
        ratingLabel.text = "\(data.ratingAverage)"
        soldAmountLabel.text = "Terjual \(data.amountSold)"
    }
    
    private func hideView() {
        switch state {
        case .normal:
            self.bottomStackView.isHidden = false
        case .edit:
            self.bottomStackView.isHidden = true
        case .none:
            break
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "WishlistItemViewCell", bundle: nil)
    }
}
