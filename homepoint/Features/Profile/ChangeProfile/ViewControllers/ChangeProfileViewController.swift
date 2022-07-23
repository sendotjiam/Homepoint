//
//  ChangeProfileViewController.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit

final class ChangeProfileViewController: UIViewController {
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    var gender: String? = nil
    
    var userData: UserDataModel?
    
    init(_ userData : UserDataModel) {
        self.userData = userData
        super.init(nibName: Constants.ChangeProfileVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Edit Profil"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        guard let userData = userData else {
            return
        }
        
        nameField.text = userData.name
        birthField.text = userData.birthDate
        emailField.text = userData.email
        phoneNumberField.text = userData.phoneNumber
        gender = userData.gender
        if (gender == "f") {
            femaleButton.isSelected = true
        } else if (gender == "m") {
            maleButton.isSelected = true
        }
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
