//
//  PaymentOrderListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

final class PaymendOrderListCellModel {
    let productId : String
    let title : String
    let quantity : Int
    let price : Double
    let needInsurance: Bool
    let discount : Double
    var isInsurance : Bool
    
    init(productId: String, title: String, quantity: Int, price: Double, needInsurance: Bool, discount : Double, isInsurance: Bool = false) {
        self.productId = productId
        self.title = title
        self.quantity = quantity
        self.price = price
        self.needInsurance = needInsurance
        self.discount = discount
        self.isInsurance = isInsurance
    }
}

protocol PaymentOrderListDelegate : AnyObject {
    func didTapInsurance(id: String, _ includeInsurance: Bool, _ insurancePrice : Double)
}

final class PaymentOrderListViewCell: UITableViewCell {

    static let identifier = "PaymentOrderListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var insuranceView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var insuranceCheckbox: Checkbox!
    @IBOutlet weak var insurancePriceLabel: UILabel!
    
    // MARK: - Variables
    var data : PaymendOrderListCellModel? {
        didSet { configureCell() }
    }
    var insurancePrice = 0.0
    weak var delegate : PaymentOrderListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension PaymentOrderListViewCell {
    private func setupUI() {
        insuranceCheckbox.delegate = self
        selectionStyle = .none
        insuranceView.isHidden = true
    }
    
    private func configureCell() {
        guard let data = data else { return }
        titleLabel.text = data.title
        priceLabel.text = data.price.convertToCurrency()
        quantityLabel.text = "\(data.quantity)x"
        insurancePriceLabel.text = (data.price * 1/100).convertToCurrency()
        insuranceView.isHidden = data.needInsurance ? false : true
    }
    
    class func nib() -> UINib {
        UINib(nibName: "PaymentOrderListViewCell", bundle: nil)
    }
}

extension PaymentOrderListViewCell : CheckboxClickable {
    func didTap(_ isSelected: Bool) {
        guard let data = data else { return }
        let insurancePrice = data.price * 1/100
        delegate?.didTapInsurance(id: data.productId, isSelected, insurancePrice)
    }
}
