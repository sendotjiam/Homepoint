//
//  DiscussListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 17/06/22.
//

import UIKit

class DiscussListViewCell: UITableViewCell {

    static let identifier = "DiscussListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var senderlabel: UILabel!
    @IBOutlet weak var senderDate: UILabel!
    @IBOutlet weak var replyDate: UILabel!
    @IBOutlet weak var customerCareView: UIView!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
}

extension DiscussListViewCell {
    private func setupUI() {
        containerView.addBorder(
            width: 1,
            color: ColorCollection.blueColor.value
        )
        containerView.roundedCorner(with: 4)
        dotView.roundedCorner(with: (dotView.frame.width / 2))
        customerCareView.roundedCorner(with: 8)
        commentField.roundedCorner(with: 4)
        commentField.addBorder(
            width: 1,
            color: ColorCollection.blueColor.value
        )
        selectionStyle = .none
    }
    
    class func nib() -> UINib {
        UINib(nibName: "DiscussListViewCell", bundle: nil)
    }
}
