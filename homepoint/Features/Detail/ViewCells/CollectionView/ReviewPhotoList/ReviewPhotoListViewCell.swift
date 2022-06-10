//
//  ReviewPhotoListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/06/22.
//

import UIKit

final class ReviewPhotoListCellModel {
    let imageUrl : String
    let index : Int
    
    init(imageUrl: String, index: Int) {
        self.imageUrl = imageUrl
        self.index = index
    }
}

final class ReviewPhotoListViewCell: UICollectionViewCell {

    static let identifier = "ReviewPhotoListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var photoImageView : UIImageView!
    @IBOutlet weak var overlayView : UIView!
    @IBOutlet weak var qtyLabel : UILabel!
    
    // MARK: - Data
    var data : ReviewPhotoListCellModel? {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}


extension ReviewPhotoListViewCell {
    private func setupUI() {
        photoImageView.clipsToBounds = true
        photoImageView.roundedCorner(with: 6)
        overlayView.roundedCorner(with: 6)
        overlayView.isHidden = true
        qtyLabel.isHidden = true
    }
    
    private func configureCell() {
        guard let data = data else { return }
        photoImageView.image = UIImage(named: data.imageUrl)
        if data.index == 4 {
            overlayView.isHidden = false
            qtyLabel.isHidden = false
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ReviewPhotoListViewCell", bundle: nil)
    }
}
