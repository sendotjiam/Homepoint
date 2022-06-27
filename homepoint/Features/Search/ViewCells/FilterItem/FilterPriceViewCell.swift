//
//  FilterPriceViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class FilterPriceViewCell: UITableViewCell {

    static let identifier = "FilterPriceViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var maximumView: UIView!
    @IBOutlet weak var minimumView: UIView!
    @IBOutlet weak var maximumField: UITextField!
    @IBOutlet weak var minimumField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
}

extension FilterPriceViewCell {
    private func setupUI() {
        selectionStyle = .none
        minimumField.delegate = self
        maximumField.delegate = self
        minimumView.roundedCorner(with: 6)
        minimumView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        maximumView.roundedCorner(with: 6)
        maximumView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
    }
    
    class func nib() -> UINib {
        UINib(nibName: "FilterPriceViewCell", bundle: nil)
    }
}

extension FilterPriceViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(
        _ textField: UITextField,
        reason: UITextField.DidEndEditingReason
    ) {
        
    }
}
