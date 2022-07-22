//
//  OrderFilterViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit
import SkeletonView

final class OrderFilterViewCell: UITableViewCell {
    
    static let identifier = "OrderFilterViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [OrderFilterItemCellModel] = [
        OrderFilterItemCellModel(
            title: "Bayar",
            imageUrl: "ic_wallet",
            isSelected: true
        ),
        OrderFilterItemCellModel(
            title: "Dikemas",
            imageUrl: "ic_packed",
            isSelected: false
        ),
        OrderFilterItemCellModel(
            title: "Dikirim",
            imageUrl: "ic_deliver",
            isSelected: false
        ),
        OrderFilterItemCellModel(
            title: "Sampai",
            imageUrl: "ic_arrived",
            isSelected: false
        ),
        OrderFilterItemCellModel(
            title: "Penilaian",
            imageUrl: "ic_rating",
            isSelected: false
        ),
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension OrderFilterViewCell {
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            OrderFilterItemViewCell.nib(),
            forCellWithReuseIdentifier: OrderFilterItemViewCell.identifier
        )
        selectionStyle = .none
    }
    
    class func nib() -> UINib {
        UINib(nibName: "OrderFilterViewCell", bundle: nil)
    }
}

extension OrderFilterViewCell : SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        5
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        OrderFilterItemViewCell.identifier
    }
}

// MARK: - CollectionView
extension OrderFilterViewCell :
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
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OrderFilterItemViewCell.identifier,
            for: indexPath
        ) as? OrderFilterItemViewCell
        cell?.data = data[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.size.width - 40) / 6
        let height = 57 / 59 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        data.forEach { $0.isSelected = false }
        data[indexPath.row].isSelected = true
        collectionView.reload()
    }
}
