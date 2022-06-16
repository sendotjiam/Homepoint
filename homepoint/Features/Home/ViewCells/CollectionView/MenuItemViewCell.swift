//
//  MenuItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class MenuItemViewCell: UICollectionViewCell {
    
    static let identifier = "MenuItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var menu: MenuData? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension MenuItemViewCell {
    private func setupUI() {
        uiView.backgroundColor = ColorCollection.blueColor.value
    }
    
    private func configureCell() {
        guard let menu = menu else { return }
        imageView.image = menu.image
        labelView.text = menu.title
    }
    
    class func nib() -> UINib { UINib(nibName: "MenuItemViewCell", bundle: nil) }
}
