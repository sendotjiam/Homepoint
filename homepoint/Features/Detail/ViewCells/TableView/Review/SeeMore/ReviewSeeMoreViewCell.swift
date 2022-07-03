//
//  ReviewSeeMoreViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 16/06/22.
//

import UIKit

final class ReviewSeeMoreViewCell: UITableViewCell {

    static let identifier = "ReviewSeeMoreViewCell"
    
    var didTapSeeMoreButton : (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func seeMoreTapped(_ sender: Any) {
        didTapSeeMoreButton?()
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ReviewSeeMoreViewCell", bundle: nil)
    }
}
