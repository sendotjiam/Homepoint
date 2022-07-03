//
//  MenuViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit
import SkeletonView

final class MenuViewCell: UITableViewCell {
    static let identifier = "MenuViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    // MARK: - Variables
    var subCategories = [ProductSubCategoryModel]() {
        didSet { configureCell() }
    }
    var didSelectItem : ((_ id: String) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension MenuViewCell {
    private func setupUI() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(
            MenuItemViewCell.nib(),
            forCellWithReuseIdentifier: MenuItemViewCell.identifier
        )
    }
    
    private func configureCell() {
        
    }
    
    class func nib() -> UINib { UINib(nibName: "MenuViewCell", bundle: nil) }
}

// MARK: - Collection View
extension MenuViewCell:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        subCategories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuItemViewCell.identifier,
            for: indexPath
        ) as? MenuItemViewCell
        cell?.subCategory = subCategories[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didSelectItem?(subCategories[indexPath.row].id)
    }
}

// MARK: - Skeleton
extension MenuViewCell : SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        8
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return MenuItemViewCell.identifier
    }
}
