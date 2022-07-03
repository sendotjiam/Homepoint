//
//  BestOfferViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit
import SkeletonView

final class BestOfferViewCell: UITableViewCell {
    static let identifier = "BestOfferViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataList = [ProductDataModel]() {
        didSet {
            configureCell()
        }
    }
    var didSelectItem : ((_ id: String) -> ())? = nil
    var didViewMore : (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension BestOfferViewCell {
    private func setupUI() {
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.register(
            SmallProductCardViewCell.nib(),
            forCellWithReuseIdentifier: SmallProductCardViewCell.identifier
        )
        collectionView.register(
            ViewMoreProductViewCell.nib(),
            forCellWithReuseIdentifier: ViewMoreProductViewCell.identifier
        )
    }
    
    func configureCell() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    
    class func nib() -> UINib { UINib(nibName: "BestOfferViewCell", bundle: nil) }
}

// MARK: - Skeleton
extension BestOfferViewCell : SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        6
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return SmallProductCardViewCell.identifier
    }
}

// MARK: - Collection View
extension BestOfferViewCell:
    UICollectionViewDelegate,
    UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        dataList.count + 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.row {
        case dataList.count:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ViewMoreProductViewCell.identifier,
                for: indexPath
            ) as? ViewMoreProductViewCell
            return cell ?? UICollectionViewCell()
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SmallProductCardViewCell.identifier,
                for: indexPath
            ) as? SmallProductCardViewCell
            cell?.data = dataList[indexPath.row]
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if indexPath.row == dataList.count {
            self.didViewMore?()
        } else {
            self.didSelectItem?(dataList[indexPath.row].id)
        }
    }
}
