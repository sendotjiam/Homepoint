//
//  ViewController2.swift
//  homepoint
//
//  Created by Sendo Tjiam on 01/06/22.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backTitleAndLike(title: "Keranjang", isFavorite: true))
        if #available(iOS 11.0, *) {
            navigationController?.view.layoutSubviews()
        }
    }
}
