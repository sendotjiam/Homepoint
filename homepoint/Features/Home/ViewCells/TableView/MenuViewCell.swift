//
//  MenuViewCell.swift
//  homepoint
//
//  Created by Kartika on 03/06/22.
//

import UIKit

struct MenuData {
    var title: String
    var image: UIImage
}

typealias MenuList = [MenuData]

var dataMenu: MenuList = MenuList([
    MenuData(title: "Peralatan Dapur", image: UIImage(named: "img-menu.dapur")!),
    MenuData(title: "Peralatan Kebersihan", image: UIImage(named: "img-menu.kebersihan")!),
    MenuData(title: "Interior/ Furniture", image: UIImage(named: "img-menu.interior")!),
    MenuData(title: "Elektronik", image: UIImage(named: "img-menu.elektronik")!),
])

class MenuViewCell: UITableViewCell {
    static let identifier = "MenuViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    // MARK: - Data
    var menus = dataMenu
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension MenuViewCell {
    func setupUI() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(
            MenuItemViewCell.nib(),
            forCellWithReuseIdentifier: MenuItemViewCell.identifier
        )
    }
    
    class func nib() -> UINib { UINib(nibName: "MenuViewCell", bundle: nil) }
}

extension MenuViewCell:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.size.width - 34) / 4
        let height = 92 / 68 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        menus.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuItemViewCell.identifier,
            for: indexPath
        ) as? MenuItemViewCell
        cell.menu = menus[indexPath.row]
        return cell
    }
}
