//
//  ViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .defaultNav)
    }
    
    @IBAction func tap(_ sender: UIButton) {
        navigationController?.pushViewController(
            ViewController2(),
            animated: true
        )
    }
}
