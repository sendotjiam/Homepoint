//
//  NotLoginAlertViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 16/07/22.
//

import UIKit

final class NotLoginAlertViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    var delegate : NotLoginViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.roundedCorner(with: 8)
        loginButton.roundedCorner(with: 8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.alpha = 0.5
        containerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.containerView.alpha = 1
            self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        dismiss(animated: false) { [weak self] in
            self?.delegate?.navigateToLogin()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: false)
    }
}
