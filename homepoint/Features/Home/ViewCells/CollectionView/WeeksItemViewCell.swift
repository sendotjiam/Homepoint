//
//  WeeksItemViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

final class WeeksItemViewCell: UICollectionViewCell {
    
    static let identifier = "WeeksItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Variables
    var data: WeeksMenuData? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension WeeksItemViewCell {
    
    private func configureCell() {
        guard let data = data else { return }
        imageView.image = data.image
        imageView.layer.cornerRadius = 8
        label.text = data.title
    }
    
    class func nib() -> UINib { UINib(nibName: "WeeksItemViewCell", bundle: nil) }
}
