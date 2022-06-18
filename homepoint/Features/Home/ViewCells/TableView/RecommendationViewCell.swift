//
//  RecommendationViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class RecommendationViewCell: UITableViewCell {
    
    static let identifier = "RecommendationViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    var didSelectItem : ((_ id: Int) -> ())? = nil
    
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
}

// MARK: - Collection View
extension RecommendationViewCell:
    UICollectionViewDelegate,
        UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        7
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.row {
        case 6:
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
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        /// supposed to be product id
        self.didSelectItem?(indexPath.row)
    }
}
