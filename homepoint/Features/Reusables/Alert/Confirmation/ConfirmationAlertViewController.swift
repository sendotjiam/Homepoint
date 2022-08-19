//
//  ConfirmationAlertViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 19/07/22.
//

import UIKit

protocol ConfirmationAlertDelegate : AnyObject {
    func didTapConfirm()
}

/// If want to reuse, send the data and set in configureCell
final class ConfirmationAlertViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var seeAgainButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Variabels
    weak var delegate : ConfirmationAlertDelegate?
    
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
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        delegate?.didTapConfirm()
        dismiss(animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension ConfirmationAlertViewController {
    private func setupUI() {
        containerView.roundedCorner(with: 8)
        confirmButton.roundedCorner(with: 8)
        seeAgainButton.roundedCorner(with: 8)
        seeAgainButton.addBorder(width: 1, color: ColorCollection.blueDarkColor.value)
        
    }
    
    private func configureCell() {
        
    }
}
