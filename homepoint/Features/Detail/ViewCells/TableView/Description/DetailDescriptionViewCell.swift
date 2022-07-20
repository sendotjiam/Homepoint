//
//  DetailDescriptionViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

final class DetailDescriptionViewCell: UITableViewCell {

    static let identifier = "DetailDescriptionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Data
    var content : String? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension DetailDescriptionViewCell {
    private func setupUI() {
        selectionStyle = .none
    }
    
    private func configureCell() {
        guard let content = content else { return }
        contentLabel.attributedText = content.htmlAttributedString()
        contentLabel.font = .systemFont(ofSize: 14)
    }
    
    class func nib() -> UINib {
        UINib(nibName: "DetailDescriptionViewCell", bundle: nil)
    }
}
