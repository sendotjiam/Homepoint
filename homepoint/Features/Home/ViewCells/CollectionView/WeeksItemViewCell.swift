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
        setupUI()
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
        overlayView.addGradientOverlay()
        overlayView.layer.cornerRadius = 8
        overlayView.clipsToBounds = true
        overlayView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    class func nib() -> UINib { UINib(nibName: "WeeksItemViewCell", bundle: nil) }
}
