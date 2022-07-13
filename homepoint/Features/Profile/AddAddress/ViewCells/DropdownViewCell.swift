//
//  DropdownViewCell.swift
//  homepoint
//
//  Created by Kartika on 28/06/22.
//

import UIKit

class DropdownViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    var value: String? {
        didSet {
            if let value = value {
                label.text = value
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func nib() -> UINib { UINib(nibName: "DropdownViewCell", bundle: nil) }
}
