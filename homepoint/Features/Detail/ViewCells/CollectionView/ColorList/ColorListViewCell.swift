//
//  ColorListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

final class ColorCellModel {
    let hexColor : String
    var isSelected : Bool
    
    init(_ hexColor: String, _ isSelected: Bool) {
        self.hexColor = hexColor
        self.isSelected = isSelected
    }
}

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
        if colorModel.hexColor == "#FFFFFF" {
            containerView.addBorder(
                width: 1,
                color: ColorCollection.primaryColor.value
            )
        }
        containerView.backgroundColor = colorModel
            .hexColor
            .hexStringToUIColor()
        
        checkImageView.isHidden = colorModel.isSelected ? false : true
    }
    
    private func showSelected() {
        
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ColorListViewCell", bundle: nil)
    }
}
