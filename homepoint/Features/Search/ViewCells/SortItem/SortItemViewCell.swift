//
//  SortItemViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 23/06/22.
//

import UIKit

final class SortItemViewCell: UITableViewCell {

    static let identifier = "SortItemViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Data
    var state : String = "" {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            containerView.backgroundColor = ColorCollection.lightTealColor.value
            titleLabel.textColor = .white
            titleLabel.font = .boldSystemFont(ofSize: 14)
        } else {
            containerView.backgroundColor = .white
            titleLabel.textColor = .black
            titleLabel.font = .systemFont(ofSize: 14)
        }
    }
}

extension SortItemViewCell {
    private func setupUI() {
        selectionStyle = .none
        containerView.roundedCorner(with: 4)
    }
    
    private func configureCell() {
        titleLabel.text = state
    }
    
    class func nib() -> UINib {
        UINib(nibName: "SortItemViewCell", bundle: nil)
    }
}
