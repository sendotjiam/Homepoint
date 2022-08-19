//
//  NotLoginView.swift
//  homepoint
//
//  Created by Sendo Tjiam on 16/07/22.
//

import UIKit

protocol NotLoginViewProtocol: AnyObject {
    func navigateToLogin()
}

final class NotLoginView : UIView {
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_not.login")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kamu belum masuk nih!"
        label.textColor = ColorCollection.primaryColor.value
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var descLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Silahkan masuk/daftar terlebih dahulu untuk dapat berbelanja dan menikmati layanan kami."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundedCorner(with: 8)
        button.setTitle("Masuk", for: .normal)
        button.setTitleColor(ColorCollection.blueDarkColor.value, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = ColorCollection.yellowColor.value
        return button
    }()
    
    weak var delegate : NotLoginViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
    
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        self.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalToConstant: 242),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 68),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            loginButton.widthAnchor.constraint(equalToConstant: 112),
            loginButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    @objc private func loginButtonTapped() {
        delegate?.navigateToLogin()
    }
    
}
