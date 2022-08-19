//
//  DiscussHeaderViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 17/06/22.
//

import UIKit

final class DiscussHeaderViewCell: UITableViewCell {

    static let identifier = "ReviewDiscussViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var questionButton: UIButton!
    
    var didTapQuestionButton : (() -> ())? = nil
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func questionButtonTapped(_ sender: Any) {
        didTapQuestionButton?()
    }
}

extension DiscussHeaderViewCell {
    private func setupUI() {
        questionButton.addBorder(
            width: 1,
            color: ColorCollection.blueColor.value
        )
        questionButton.roundedCorner(with: 8)
    }
    
    class func nib() -> UINib {
        UINib(nibName: "DiscussHeaderViewCell", bundle: nil)
    }
}
