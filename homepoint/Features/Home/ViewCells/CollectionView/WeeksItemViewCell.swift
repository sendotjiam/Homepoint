//
//  WeeksItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class WeeksItemViewCell: UICollectionViewCell {
    
    static let identifier = "WeeksItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var overlayView: UIView!
    
    var menu: WeeksMenuData? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension WeeksItemViewCell {
    private func setupUI() {
        setupOverlay()
    }
    
    private func configureCell() {
        guard let menu = menu else { return }
        imageView.image = menu.image
        imageView.layer.cornerRadius = 8
        label.text = menu.title
    }
    
    #warning("Ini ada masalah di overlaynya, klo di aktivin, dia nutupin border bottom")
    private func setupOverlay() {
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
        gradientLayer.bounds = overlayView.bounds.insetBy(dx: -0.5*overlayView.bounds.size.width, dy: -0.5*overlayView.bounds.size.height)
        gradientLayer.position = overlayView.center
        gradientLayer.frame = CGRect(x: 0, y: 0, width: overlayView.bounds.width, height: overlayView.bounds.height)
        overlayView.layer.addSublayer(gradientLayer)
        overlayView.layer.cornerRadius = 8
    }
    class func nib() -> UINib { UINib(nibName: "WeeksItemViewCell", bundle: nil) }
}
