//
//  LastForgetPassViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 14/06/22.
//

import UIKit

class LastForgetPassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapLogin(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
