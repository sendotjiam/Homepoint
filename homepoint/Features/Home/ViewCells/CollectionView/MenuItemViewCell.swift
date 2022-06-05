//
//  MenuItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class MenuItemViewCell: UICollectionViewCell {
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var menu: MenuData? {
        didSet {
            if let menu = menu {
                setupItem(menu: menu)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        uiView.backgroundColor = ColorCollection.blueColor.value
    }
    
    func setupItem(menu: MenuData) {
        imageView.image = menu.image
        labelView.text = menu.title
    }

    class func nib() -> UINib { UINib(nibName: "MenuItemViewCell", bundle: nil) }
}
