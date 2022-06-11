//
//  RecommendationViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

class RecommendationViewCell: UITableViewCell {
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    static let identifier = "RecommendationViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        
        recommendationCollectionView.register(SmallProductCardViewCell.nib(), forCellWithReuseIdentifier: "SmallProductCardViewCell")
        recommendationCollectionView.register(ViewMoreProductViewCell.nib(), forCellWithReuseIdentifier: "ViewMoreProductViewCell")
    }
    
    class func nib() -> UINib { UINib(nibName: "RecommendationViewCell", bundle: nil) }
}

extension RecommendationViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
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
