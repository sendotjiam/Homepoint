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
    @IBOutlet weak var seeMoreButton: UIButton!
    
    // MARK: - Data
    var content : String? {
        didSet { configureCell() }
    }
    var didTapSeeMoreButton : (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: Any) {
        didTapSeeMoreButton?()
    }
}

extension DetailDescriptionViewCell {
    private func setupUI() {
        selectionStyle = .none
    }
    
    private func configureCell() {
        contentLabel.text = content ?? ""
        seeMoreButton.isHidden = contentLabel.numberOfLines < 14 ? true : false
    }
    
    class func nib() -> UINib {
        UINib(nibName: "DetailDescriptionViewCell", bundle: nil)
    }
}
