//
//  InformationAlertViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 19/07/22.
//

import UIKit

/// If want to reuse, send the data and set in configureCell
final class InformationAlertViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.alpha = 0.0
        containerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension InformationAlertViewController {
    private func setupUI() {
        containerView.roundedCorner(with: 8)
    }
    
    private func configureCell() {
        
    }
}
