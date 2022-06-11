//
//  BestOfferViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class BestOfferViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "BestOfferViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        collectionView.delegate =  self
        collectionView.dataSource = self
        
        collectionView.register(SmallProductCardViewCell.nib(), forCellWithReuseIdentifier: "SmallProductCardViewCell")
        collectionView.register(ViewMoreProductViewCell.nib(), forCellWithReuseIdentifier: "ViewMoreProductViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func nib() -> UINib { UINib(nibName: "BestOfferViewCell", bundle: nil) }
}

extension BestOfferViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewMoreProductViewCell.identifier, for: indexPath) as? ViewMoreProductViewCell
            return cell ?? UICollectionViewCell()
        default:
            let cell: SmallProductCardViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "SmallProductCardViewCell", for: indexPath) as! SmallProductCardViewCell
            return cell
        }
    }
}
