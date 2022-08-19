//
//  EmptySearchHeaderReusableView.swift
//  homepoint
//
//  Created by Sendo Tjiam on 21/07/22.
//

import UIKit

final class EmptySearchHeaderReusableView: UICollectionReusableView {

    static let identifier = "EmptySearchHeaderReusableView"
    
    // MARK: - Outlets
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Maaf, Kami tidak dapat menemukan apa yang Kamu cari!"
        label.textColor = ColorCollection.darkTextColor.value
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Berikut rekomendasi kami untuk produk yang mungkin Kamu suka, Ganti kata kunci untuk menemukan produk yang Kamu inginkan."
        label.textColor = ColorCollection.darkTextColor.value
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureCell() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    class func nib() -> UINib {
        UINib(nibName: "EmptySearchHeaderReusableView", bundle: nil)
    }
}
