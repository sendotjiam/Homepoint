//
//  ChangeProfileViewController.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit

class ChangeProfileViewController: UIViewController {
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    var gender: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
    }
    
    @IBAction func femaleDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            maleButton.isSelected = true
            gender = "f"
        } else {
            sender.isSelected = true
            maleButton.isSelected = false
        }
    }
    
    @IBAction func maleDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            femaleButton.isSelected = true
            gender = "m"
        } else {
            sender.isSelected = true
            femaleButton.isSelected = false
        }
    }
}
