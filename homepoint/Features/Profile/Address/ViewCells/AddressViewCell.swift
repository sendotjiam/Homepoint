//
//  AddressViewCell.swift
//  homepoint
//
//  Created by Kartika on 26/06/22.
//

import UIKit

final class AddressViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainAddressLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var item: AddressDataModel? {
        didSet {
            if let item = item {
                setupCard(address: item)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCard(address: AddressDataModel) {
        nameLabel.text = address.label
        addressLabel.text = "\(address.fullAddress), \(address.village), \(address.districts), \(address.city), \(address.province)"
        
        cardView.layer.cornerRadius = 5
        cardView.layer.borderWidth = 1
        
        if address.isActive {
            mainAddressLabel.isHidden = false
            cardView.layer.backgroundColor = UIColor(red: 0.954, green: 0.982, blue: 1, alpha: 1).cgColor
            cardView.layer.borderColor = UIColor(red: 0.412, green: 0.6, blue: 0.722, alpha: 1).cgColor
        } else {
            mainAddressLabel.isHidden = true
            cardView.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        }
    }

    class func nib() -> UINib { UINib(nibName: "AddressViewCell", bundle: nil) }
}
