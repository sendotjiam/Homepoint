//
//  BannerItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 07/06/22.
//

import UIKit

class BannerItemViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    static let identifier = "BannerItemViewCell"
    
    var img: UIImage? {
        didSet {
            if let img = img {
                imageView.image = img
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heightImageView.constant = (UIScreen.main.bounds.width - 40) * 145/335
    }

    class func nib() -> UINib { UINib(nibName: "BannerItemViewCell", bundle: nil) }
}
