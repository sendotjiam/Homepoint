//
//  ColorListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

class ColorListViewCell: UICollectionViewCell {

    static let identifier = "ColorListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Data
    var hexColor : String = "" {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension ColorListViewCell {
    private func setupUI() {
        containerView.roundedCorner(
            with: containerView.frame.width/2
        )
    }
    
    private func configureCell() {
        containerView.backgroundColor = hexColor.hexStringToUIColor()
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ColorListViewCell", bundle: nil)
    }
}
