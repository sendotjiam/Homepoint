//
//  LastForgetPassViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 14/06/22.
//

import UIKit

final class LastForgetPassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .back)
    }

    @IBAction func didTapLogin(_ sender: UIButton) {
        navigationController?.viewControllers = [self, LoginViewController()]
        navigationController?.popViewController(animated: true)
    }
}

extension LastForgetPassViewController {
    private func setupUI() {

    }
}

