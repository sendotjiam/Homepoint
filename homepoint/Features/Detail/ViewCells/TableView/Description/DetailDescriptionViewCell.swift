//
//  DetailDescriptionViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit

class DetailDescriptionViewCell: UITableViewCell {

    static let identifier = "DetailDescriptionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var contentLabel: UILabel!
    
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
    
    class func nib() -> UINib {
        UINib(nibName: "DetailDescriptionViewCell", bundle: nil)
    }
}
