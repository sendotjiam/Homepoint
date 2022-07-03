//
//  ReviewHeaderViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/06/22.
//

import UIKit

final class ReviewHeaderViewCell: UITableViewCell {

    static let identifier = "ReviewHeaderViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Data
    private var data = [
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 0),
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 1),
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 2),
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 3),
        ReviewPhotoListCellModel(imageUrl: "img_dummy", index: 4),
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension ReviewHeaderViewCell {
    private func setupUI() {
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
        UINib(nibName: "ReviewHeaderViewCell", bundle: nil)
    }
}

// MARK: - CollectionView
extension ReviewHeaderViewCell :
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


