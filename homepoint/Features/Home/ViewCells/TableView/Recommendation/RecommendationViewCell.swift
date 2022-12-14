//
//  RecommendationViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit
import SkeletonView

final class RecommendationViewCell: UITableViewCell {
    
    static let identifier = "RecommendationViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    // MARK: - Variables
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
    
    class func nib() -> UINib { UINib(nibName: "RecommendationViewCell", bundle: nil) }
}

extension RecommendationViewCell {
    func setupUI() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        
        recommendationCollectionView.register(
            SmallProductCardViewCell.nib(),
            forCellWithReuseIdentifier: SmallProductCardViewCell.identifier
        )
        recommendationCollectionView.register(
            ViewMoreProductViewCell.nib(),
            forCellWithReuseIdentifier: ViewMoreProductViewCell.identifier
        )
    }
    
    func configureCell() {
        recommendationCollectionView.reload()
    }
}

// MARK: - Skeleton
extension RecommendationViewCell : SkeletonCollectionViewDataSource {
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
extension RecommendationViewCell:
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
            let cell =  collectionView.dequeueReusableCell(
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
