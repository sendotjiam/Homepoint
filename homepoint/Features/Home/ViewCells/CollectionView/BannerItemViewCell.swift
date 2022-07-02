//
//  BannerItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 07/06/22.
//

import UIKit

final class BannerItemViewCell: UICollectionViewCell {
    static let identifier = "BannerItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    
    var img: UIImage? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension BannerItemViewCell {
    private func setupUI() {
        heightImageView.constant = (UIScreen.main.bounds.width - 40) * 145/335
    }
    
    private func configureCell() {
        guard let img = img else { return }
        imageView.image = img
    }
    
    class func nib() -> UINib { UINib(nibName: "BannerItemViewCell", bundle: nil) }
}
