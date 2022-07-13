//
//  ImageFieldViewCell.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit

class ImageFieldViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func nib() -> UINib { UINib(nibName: "ImageFieldViewCell", bundle: nil) }
}
