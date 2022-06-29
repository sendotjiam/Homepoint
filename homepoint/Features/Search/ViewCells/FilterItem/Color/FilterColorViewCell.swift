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
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    var colors = [String]() {
        didSet { configureCell() }
    }
    private var colorsModel = [ColorCellModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
}


extension FilterColorViewCell {
    
    private func setupUI() {
        selectionStyle = .none
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            ColorListViewCell.nib(),
            forCellWithReuseIdentifier: ColorListViewCell.identifier
        )
    }
    
    private func calculateCollectionLines() {
        let width : CGFloat = collectionView.frame.width
        var temp : CGFloat = 0
        var lines : CGFloat = 1
        colors.forEach { color in
            temp += 40
            colorsModel.append(
                ColorCellModel(
                    color,
                    false
                )
            )
            if temp > width {
                lines += 1
                temp = 0
            }
        }
        let height : CGFloat = lines * 60
        collectionViewHeight.constant = height
    }
    
    private func configureCell() {
        calculateCollectionLines()
        reloadCollectionView()
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
        cell?.colorModel = colorsModel[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        colorsModel[indexPath.row].isSelected.toggle()
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
