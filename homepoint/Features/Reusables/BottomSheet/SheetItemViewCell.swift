//
//  SheetItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit
import SDWebImage

final class SheetItemCellModel {
    let title: String
    let image: String
    let imageFromUrl: Bool
    
    init(title: String, image: String, imageFromUrl : Bool = true) {
        self.title = title
        self.image = image
        self.imageFromUrl = imageFromUrl
    }
}

final class SheetItemViewCell: UITableViewCell {

    static let identifier = "SheetItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var data : SheetItemCellModel? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            containerView.backgroundColor = ColorCollection.lightBlueColor.value
            titleLabel.font = .boldSystemFont(ofSize: 14)
        } else {
            containerView.backgroundColor = .white
            titleLabel.font = .systemFont(ofSize: 14, weight: .light)
        }
    }
    
}

extension SheetItemViewCell {
    private func setupUI() {
        selectionStyle = .none
        containerView.roundedCorner(with: 8)
    }
    
    private func configureCell() {
        guard let data = data else { return }
        titleLabel.text = data.title
        switch data.imageFromUrl {
        case true:
            let imageUrl = URL(string: data.image)
            iconImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_placeholder.small"))
        case false:
            iconImageView.image = UIImage(named: data.image)
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "SheetItemViewCell", bundle: nil)
    }
}
