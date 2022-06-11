//
//  BannerItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 07/06/22.
//

import UIKit

class BannerItemViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
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
    }

    class func nib() -> UINib { UINib(nibName: "BannerItemViewCell", bundle: nil) }
}
