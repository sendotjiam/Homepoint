//
//  FilterColorViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class FilterColorViewCell: UITableViewCell {

    static let identifier = "FilterColorViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var colors = ["#FF0000", "#FFFFFF", "#FF0000", "#FFFFFF", "#FF0000", "#FFFFFF"]
    var selectedColors = [Bool]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
}


extension FilterColorViewCell {
    
    private func setupUI() {
        selectionStyle = .none
        colors.forEach { _ in
            selectedColors.append(false)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            ColorListViewCell.nib(),
            forCellWithReuseIdentifier: ColorListViewCell.identifier
        )
    }
    
    class func nib() -> UINib {
        UINib(nibName: "FilterColorViewCell", bundle: nil)
    }
}

// MARK: - Collection View
extension FilterColorViewCell :
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        colors.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorListViewCell.identifier,
            for: indexPath
        ) as? ColorListViewCell
        cell?.size = 40
        cell?.hexColor = colors[indexPath.row]
        cell?.isSelected = selectedColors[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        return CGSize(width: 40, height: 40)
//    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        selectedColors[indexPath.row].toggle()
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
}
