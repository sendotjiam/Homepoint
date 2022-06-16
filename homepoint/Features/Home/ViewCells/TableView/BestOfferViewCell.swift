//
//  BestOfferViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class BestOfferViewCell: UITableViewCell {
    static let identifier = "BestOfferViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

extension BestOfferViewCell {
    func setupUI() {
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
    
    class func nib() -> UINib { UINib(nibName: "BestOfferViewCell", bundle: nil) }
}

// MARK: - Collection View
extension BestOfferViewCell:
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
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SmallProductCardViewCell",
                for: indexPath
            ) as? SmallProductCardViewCell
            return cell ?? UICollectionViewCell()
        }
    }
}
