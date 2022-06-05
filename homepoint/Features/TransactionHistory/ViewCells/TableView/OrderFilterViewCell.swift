//
//  OrderFilterViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit

final class OrderFilterViewCell: UITableViewCell {
    
    static let identifier = "OrderFilterViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [OrderFilterItemCellModel] = [
        OrderFilterItemCellModel(
            "Pembayaran",
            "ic_wallet",
            true
        ),
        OrderFilterItemCellModel(
            "Dikemas",
            "ic_packed",
            false
        ),
        OrderFilterItemCellModel(
            "Dikirim",
            "ic_deliver",
            false
        ),
        OrderFilterItemCellModel(
            "Sampai",
            "ic_arrived",
            false
        ),
        OrderFilterItemCellModel(
            "Penilaian",
            "ic_rating",
            false
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
        let height = 59 / 57 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        data.forEach { $0.isSelected = false }
        data[indexPath.row].isSelected = true
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
}
