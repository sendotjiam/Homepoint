//
//  ReviewHeaderViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/06/22.
//

import UIKit

final class RatingViewCell: UITableViewCell {

    static let identifier = "ReviewHeaderViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var totalRatingLabel: UILabel!
    @IBOutlet weak var fiveStarsRateLabel: UILabel!
    @IBOutlet weak var fourStarsRateLabel: UILabel!
    @IBOutlet weak var threeStarsRateLabel: UILabel!
    @IBOutlet weak var twoStarsRateLabel: UILabel!
    
    // MARK: - Variables
    var data : ProductDataModel? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension RatingViewCell {
    private func setupUI() {
        selectionStyle = .none
        ratingView.roundedCorner(with: 8)
    }
    
    private func configureCell() {
        guard let data = data else { return }
        avgRatingLabel.text = "\(data.ratingAverage)"
        totalRatingLabel.text = "\(data.ratingCount) Penilaian"
    }
    
    class func nib() -> UINib {
        UINib(nibName: "RatingViewCell", bundle: nil)
    }
}
