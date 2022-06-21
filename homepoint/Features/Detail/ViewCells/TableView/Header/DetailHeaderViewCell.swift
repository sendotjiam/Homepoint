//
//  DetailHeaderViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit
import NVActivityIndicatorView

final class DetailHeaderViewCell: UITableViewCell {

    static let identifier = "DetailHeaderViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var soldNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var brandContainerView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var compareButtonView: UIStackView!
    @IBOutlet weak var colorListCollectionView: UICollectionView!

    // MARK: - Data
    var data : ProductDataModel? {
        didSet { configureCell() }
    }
    var colors = [String]() {
        didSet { configureCell() }
    }
    var price = 100000
    var discountedPrice = 50000
    
    var didTapCompareButton : (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func compareButtonTapped(_ sender: Any) {
        didTapCompareButton?()
    }
}


extension DetailHeaderViewCell {
    private func setupUI() {
        compareButtonView.roundedCorner(with: 8)
        brandContainerView.roundedCorner(with: 8)
        selectionStyle = .none
        colorListCollectionView.delegate = self
        colorListCollectionView.dataSource = self
        colorListCollectionView.register(
            ColorListViewCell.nib(),
            forCellWithReuseIdentifier: ColorListViewCell.identifier
        )
    }
    
    private func configureCell() {
        guard let data = data else { return }
        let imageUrl = URL(string: data.productImages[0].image)
        let priceStr = data.price.convertToCurrency()
        let discountedStr = (data.price - data.discount).convertToCurrency()
        let attributedPrice = "\(priceStr) \(discountedStr)"
        priceLabel.attributedText = attributedPrice.strikethroughText(range: NSRange(
            location: 0, length: priceStr.count
        ))
        productImageView?.sd_setImage(with: imageUrl, completed: nil)
        productNameLabel.text = data.name
        soldNumberLabel.text = "Terjual \(data.amountSold)"
        ratingLabel.text = "\(data.ratingAverage)"
        brandLabel.text = data.brand
        DispatchQueue.main.async { [weak self] in
            self?.colorListCollectionView.reloadData()
        }
    }
    
    class func nib() -> UINib {
        UINib(nibName: "DetailHeaderViewCell", bundle: nil)
    }
}

extension DetailHeaderViewCell :
    UICollectionViewDelegate,
    UICollectionViewDataSource {
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
        cell?.hexColor = colors[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}
