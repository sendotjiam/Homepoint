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
    @IBOutlet weak var checkImageView: UIImageView!
    
    // MARK: - Data
    var hexColor : String = "" {
        didSet { configureCell() }
    }
    var size : CGFloat = 0
    
    override var isSelected: Bool {
        didSet {
            checkImageView.isHidden = isSelected ? false : true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension ColorListViewCell {
    private func setupUI() {
//        NSLayoutConstraint.activate([
//            containerView.widthAnchor.constraint(equalToConstant: size),
//            containerView.heightAnchor.constraint(equalToConstant: size)
//        ])
        containerView.roundedCorner(
            with: containerView.frame.width/2
        )
    }
    
    private func configureCell() {
        containerView.backgroundColor = hexColor.hexStringToUIColor()
    }
    
    private func showSelected() {
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ColorListViewCell", bundle: nil)
    }
}
