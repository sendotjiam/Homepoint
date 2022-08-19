//
//  ColorListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

final class ColorListViewCell: UICollectionViewCell {

    static let identifier = "ColorListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    
    // MARK: - Data
    var colorModel : ColorCellModel? {
        didSet { configureCell() }
    }
    var size : CGFloat = 0 {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension ColorListViewCell {
    private func setupUI() {
        
    }
    
    private func configureCell() {
        containerView.roundedCorner(
            with: size/2
        )
        guard let colorModel = colorModel else { return }
        containerView.addBorder(
            width: colorModel.hexColor == "#FFFFFF" ? 1 : 0,
            color: ColorCollection.primaryColor.value
        )
        containerView.backgroundColor = colorModel
            .hexColor
            .hexStringToUIColor()
        
        if colorModel.isSelected {
            checkImageView.isHidden = false
            checkImageView.tintColor = colorModel.hexColor == "#FFFFFF" ? .black : .white
        } else {
            checkImageView.isHidden = true
        }
        checkImageView.isHidden = colorModel.isSelected ? false : true
    }
    
    private func showSelected() {
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ColorListViewCell", bundle: nil)
    }
}
