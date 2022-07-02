//
//  WeeksViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit
import SkeletonView

struct WeeksMenuData {
    var title: String
    var image: UIImage
}

typealias WeekMenuList = [WeeksMenuData]

var dataWeeks: WeekMenuList = WeekMenuList([
    WeeksMenuData(title: "Peralatan Dapur", image: UIImage(named: "img-menu.kitchenware.peralatan.dapur")!),
    WeeksMenuData(title: "Elektronik Dapur", image: UIImage(named: "img-menu.kitchenware.elektronik")!),
    WeeksMenuData(title: "Alat Makan & Minum", image: UIImage(named: "img-menu.kitchenware.alat.makan.minum")!),
    WeeksMenuData(title: "Menyimpanan Makanan", image: UIImage(named: "img-menu.kitchenware.penyimpanan.makanan")!),
])

final class WeeksViewCell: UITableViewCell {
    
    static let identifier = "WeeksViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var weeksCollectionView: UICollectionView!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    
    // MARK: - Data
    var weekMenus = dataWeeks
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension WeeksViewCell {
    private func setupUI() {
        selectionStyle = .none
        weeksCollectionView.delegate = self
        weeksCollectionView.dataSource = self
        weeksCollectionView.register(
            WeeksItemViewCell.nib(),
            forCellWithReuseIdentifier: WeeksItemViewCell.identifier
        )
        showShimmer()
    }
    
    class func nib() -> UINib {
        UINib(nibName: "WeeksViewCell", bundle: nil)
    }
}

// MARK: - Skeleton
extension WeeksViewCell : SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        weekMenus.count
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return WeeksItemViewCell.identifier
    }
}

// MARK: - CollectionView
extension WeeksViewCell:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.size.width - 50) / 2
        let height = 82 / 156 * width
        heightCollectionView.constant = 20 + (height*2)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        weekMenus.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeeksItemViewCell.identifier,
            for: indexPath
        ) as? WeeksItemViewCell
        cell?.menu = weekMenus[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}
