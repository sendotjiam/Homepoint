//
//  CartItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/07/22.
//

import UIKit
import SDWebImage

protocol CartItemInteraction : AnyObject {
    func didSelect(_ id: String)
    func didLikeTapped(_ id: String)
    func didRemoveTapped(_ id: String)
}

final class CartItemViewCell: UITableViewCell {

    static let identifier = "CartItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var cartImageView : UIImageView!
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityView: UIStackView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    // MARK: - Variables
    var data : CartDataModel? {
        didSet { configureCell() }
    }
    weak var delegate : CartItemInteraction?
    var qty : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        guard let data = data else { return }
        delegate?.didLikeTapped(data.products.id)
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        guard let id = data?.id else { return }
        delegate?.didRemoveTapped(id)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        qty += 1
        quantityLabel.text = "\(qty)"
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if qty == 0 { return }
        qty -= 1
        quantityLabel.text = "\(qty)"
    }
    
}

extension CartItemViewCell {
    
    private func setupUI() {
        selectionStyle = .none
        cartImageView.clipsToBounds = true
        checkbox.delegate = self
        cartImageView.roundedCorner(with: 8)
        quantityView.roundedCorner(with: 12)
    }
    
    private func configureCell() {
        guard let data = data else { return }
        let imageUrl = URL(string: data.products.productImages.first?.image ?? "")
        cartImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_placeholder.large"))
        nameLabel.text = data.products.name
        qty = data.quantity
        quantityLabel.text = "\(qty)"
        priceLabel.text = data.products.getDiscounted(qty: qty).convertToCurrency()
    }
    
    class func nib() -> UINib {
        UINib(nibName: "CartItemViewCell", bundle: nil)
    }
}

extension CartItemViewCell : CheckboxClickable {
    func didTap(_ isSelected: Bool) {
        guard let id = data?.id else { return }
        delegate?.didSelect(id)
    }
}
