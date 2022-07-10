//
//  SheetItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

final class SheetItemCellModel {
    let title: String
    let image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
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
        iconImageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
    }
    
    class func nib() -> UINib {
        UINib(nibName: "SheetItemViewCell", bundle: nil)
    }
}
