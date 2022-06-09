//
//  ShippingOptionsViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

class ShippingOptionsViewCell: UITableViewCell {

    static let identifier = "ShippingOptionsViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    class func nib() -> UINib {
        UINib(nibName: "ShippingOptionsViewCell", bundle: nil)
    }
}
