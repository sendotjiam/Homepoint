//
//  ViewMoreProductViewCell.swift
//  homepoint
//
//  Created by Kartika on 07/06/22.
//

import UIKit

class ViewMoreProductViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    static let identifier = "ViewMoreProductViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension ViewMoreProductViewCell {
    private func setupUI() {
        containerView.addBorder(
            width: 1,
            color: ColorCollection.ligthTextColor.value
        )
        containerView.roundedCorner(with: 8)
        containerView.dropShadow(
            with: 0.05,
            radius: 2,
            offset: CGSize(width: 0, height: 1)
        )
        containerView.clipsToBounds = true
    }
    
    private func configureCell() {
        
    }
    
    class func nib() -> UINib { UINib(nibName: "ViewMoreProductViewCell", bundle: nil) }
}
