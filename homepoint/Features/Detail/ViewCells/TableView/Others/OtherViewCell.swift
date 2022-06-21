//
//  OtherViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 16/06/22.
//

import UIKit

final class OtherViewCell: UITableViewCell {

    static let identifier = "OtherViewCell"
    
    // MARK: - Outles
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Data
    var products = [ProductDataModel]() {
        didSet { configureCell() }
    }
    var didSelectItem : ((_ id: String) -> ())? = nil

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
        selectionStyle = .none
    }
    
    private func configureCell() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "OtherViewCell", bundle: nil)
    }
}

extension OtherViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        products.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(
            withReuseIdentifier: SmallProductCardViewCell.identifier,
            for: indexPath
        ) as? SmallProductCardViewCell
        cell?.data = products[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didSelectItem?(products[indexPath.row].id)
    }
}
