//
//  ChangeProfileViewController.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

final class ChangeProfileViewController: UIViewController {
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var overlayView: UIView!
    
    private lazy var loaderView : UIView = {
        let view = UIView()
        view.roundedCorner(with: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private let loader = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: ColorCollection.primaryColor.value,
        padding: 0
    )
    
    var gender: String? = nil
    var borderColor = UIColor(red: 0.192, green: 0.376, blue: 0.576, alpha: 1).cgColor
    var userData: UserDataModel? = ProfileViewController.userData
    private let vm = ProfileViewModel()
    private let bag = DisposeBag()
    
    init() {
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
        bindViewModel()
    }
    
    func setupView() {
        nameField.layer.borderColor = borderColor
        birthField.layer.borderColor = borderColor
        emailField.layer.borderColor = borderColor
        phoneNumberField.layer.borderColor = borderColor
        
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
    
    @IBAction func submitDidTap(_ sender: Any) {
        let name = nameField.text
        let birth = birthField.text
        let email = emailField.text
        let phoneNumber = phoneNumberField.text
        
        var request = userData
        request?.name = name ?? ""
        request?.birthDate = birth ?? ""
        request?.gender = gender ?? ""
        request?.email = email ?? ""
        request?.phoneNumber = phoneNumber ?? ""
        
        guard let request = request else {
            return
        }
        
        vm.updateUserData(request: request)
    }
}

extension ChangeProfileViewController {
    func bindViewModel() {
        vm.error.subscribe { [weak self] in
            self?.handleError($0)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0)
        }.disposed(by: bag)
        vm.successGetUserData.subscribe { [weak self] in
            self?.handleSuccessUpdateUserData($0.element)
        }.disposed(by: bag)
    }
    
    private func handleError(_ error: String?) {
        guard let error = error else { return }
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let loading = isLoading
        else { return }
        DispatchQueue.main.async {
            self.showLoader(self.loaderView, self.loader, loading)
            self.overlayView.isHidden = loading ? false : true
        }
    }
    
    private func handleSuccessUpdateUserData(_ user : UserDataModel?) {
        guard let data = user else { return }
    }
}
