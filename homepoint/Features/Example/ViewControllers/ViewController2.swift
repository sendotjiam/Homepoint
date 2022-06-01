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
        setNavigationBar(type: .backAndTitle(title: "Keranjang"))
        if #available(iOS 11.0, *) {
            navigationController?.view.layoutSubviews()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
