//
//  OtherViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 16/06/22.
//

import UIKit

class OtherViewCell: UITableViewCell {

    // MARK: - Outles
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
}

extension OtherViewCell {
    private func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            SmallProductCardViewCell.nib(),
            forCellWithReuseIdentifier: SmallProductCardViewCell.identifier
        )
    }
}

extension OtherViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(
            withReuseIdentifier: SmallProductCardViewCell.identifier,
            for: indexPath
        ) as? SmallProductCardViewCell
        return cell ?? UICollectionViewCell()
    }
}
