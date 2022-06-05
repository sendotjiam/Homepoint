//
//  WeeksItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class WeeksItemViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uiView: UIView!
    
    var menu: WeeksMenuData? {
        didSet {
            if let menu = menu {
                setupItem(menu: menu)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupItem(menu: WeeksMenuData) {
        imageView.image = menu.image
        imageView.layer.cornerRadius = 8
        label.text = menu.title
        
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
          UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
          UIColor(red: 0.933, green: 0.9, blue: 0.9, alpha: 0).cgColor,
          UIColor(red: 0.25, green: 0.241, blue: 0.241, alpha: 0.72).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 0.61).cgColor
        ]

        gradientLayer.locations = [0.05, 0.18, 0.73, 0.93]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = uiView.bounds.insetBy(dx: -0.5*uiView.bounds.size.width, dy: -0.5*uiView.bounds.size.height)
        gradientLayer.position = uiView.center
        gradientLayer.frame = CGRect(x: 0, y: 0, width: uiView.bounds.width, height: uiView.bounds.height)
        uiView.layer.addSublayer(gradientLayer)
        uiView.layer.cornerRadius = 8
    }
    
    class func nib() -> UINib { UINib(nibName: "WeeksItemViewCell", bundle: nil) }
}
