//
//  PaymentOrderListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

final class PaymendOrderListCellModel {
    let title : String
    let quantity : Int
    let price : Double
    let needInsurance: Bool
    
    init(title: String, quantity: Int, price: Double, needInsurance: Bool) {
        self.title = title
        self.quantity = quantity
        self.price = price
        self.needInsurance = needInsurance
    }
}

protocol PaymentOrderListProtocol : AnyObject {
    func didTapInsurance(_ includeInsurance: Bool)
}

final class PaymentOrderListViewCell: UITableViewCell {

    static let identifier = "PaymentOrderListViewCell"
    
    // MARK: - Outlets
//    @IBOutlet weak var insuranceStackView: UIStackView!
    @IBOutlet weak var insuranceView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var insuranceCheckbox: Checkbox!
    
    // MARK: - Variables
    var data : PaymendOrderListCellModel? {
        didSet { configureCell() }
    }
    weak var delegate : PaymentOrderListProtocol?
    
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
        insuranceView.isHidden = data.needInsurance ? false : true
    }
    
    class func nib() -> UINib {
        UINib(nibName: "PaymentOrderListViewCell", bundle: nil)
    }
}

extension PaymentOrderListViewCell : CheckboxClickable {
    func didTap(_ isSelected: Bool) {
        delegate?.didTapInsurance(isSelected)
    }
}
