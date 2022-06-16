//
//  ReviewListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/06/22.
//

import UIKit

class ReviewListViewCell: UITableViewCell {

    static let identifier = "ReviewListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Data
    private var data = [
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 0),
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 1)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension ReviewListViewCell {
    private func setupUI() {
        containerView.roundedCorner(with: 8)
        containerView.addBorder(
            width: 1,
            color: ColorCollection.blueColor.value
        )
        selectionStyle = .none
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            ReviewPhotoListViewCell.nib(),
            forCellWithReuseIdentifier: ReviewPhotoListViewCell.identifier
        )
    }
    
    class func nib() -> UINib {
        UINib(nibName: "ReviewListViewCell", bundle: nil)
    }
}

extension ReviewListViewCell :
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: ReviewPhotoListViewCell.identifier,
                for: indexPath
            ) as? ReviewPhotoListViewCell
        cell?.data = data[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 62, height: 62)
    }
}
