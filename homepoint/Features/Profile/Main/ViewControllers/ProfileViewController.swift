//
//  ProfileViewController.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var notLoginView: NotLoginView!
    
    // MARK: - Variables
    private enum section {
        case changeProfile, address, changePassword, policy, help, chatAdmin, logout
    }
    private var sections: [section] = [.changeProfile, .address, .changePassword, .policy, .help, .chatAdmin, .logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        self.addNotificationCenter(
            label: "reload_view",
            selector: #selector(reloadView)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .title(title: "Profil"))
    }
    
    deinit {
        removeNotificationCenter()
    }
    
    func setupView() {
        notLoginView.delegate = self
    
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ChangeProfileFieldViewCell.nib(), forCellReuseIdentifier: "ChangeProfileFieldViewCell")
        profileTableView.register(RightArrowFieldViewCell.nib(), forCellReuseIdentifier: "RightArrowFieldViewCell")
        profileTableView.register(ImageFieldViewCell.nib(), forCellReuseIdentifier: "ImageFieldViewCell")

        print(UserDefaults.standard.value(forKey: "user_token"), "TOKEN")
        notLoginView.isHidden = (UserDefaults.standard.value(forKey: "user_token") != nil) ? true : false
    }
    
    @objc func reloadView() {
        notLoginView.isHidden = true
        // call API
    }
}

extension ProfileViewController : LoginProtocol, NotLoginViewProtocol {
    func successLogin() {
        reloadView()
    }
    
    func navigateToLogin() {
        let vc = LoginViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .changePassword:
            return 16
        case .chatAdmin:
            return 16
        default:
            return 0.0001
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .changeProfile:
            let cell: ChangeProfileFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "ChangeProfileFieldViewCell", for: indexPath) as! ChangeProfileFieldViewCell
            let vc = ChangeProfileViewController()
            cell.tapHandler = {[weak self] in
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(
                        vc,
                        animated: true
                    )
                }
            }
            cell.selectionStyle = .none
            return cell
        case .address:
            let cell: RightArrowFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "RightArrowFieldViewCell", for: indexPath) as! RightArrowFieldViewCell
            cell.title = "Alamat"
            let vc = AddressViewController()
            cell.tapHandler = {[weak self] in
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(
                        vc,
                        animated: true
                    )
                }
            }
            cell.selectionStyle = .none
            return cell
        case .changePassword:
            let cell: RightArrowFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "RightArrowFieldViewCell", for: indexPath) as! RightArrowFieldViewCell
            cell.title = "Ubah Kata Sandi"
            cell.selectionStyle = .none
            return cell
        case .policy:
            let cell: RightArrowFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "RightArrowFieldViewCell", for: indexPath) as! RightArrowFieldViewCell
            cell.title = "Kebajikan Layanan & Privasi"
            cell.selectionStyle = .none
            return cell
        case .help:
            let cell: RightArrowFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "RightArrowFieldViewCell", for: indexPath) as! RightArrowFieldViewCell
            cell.title = "Bantuan"
            cell.selectionStyle = .none
            return cell
        case .chatAdmin:
            let cell: RightArrowFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "RightArrowFieldViewCell", for: indexPath) as! RightArrowFieldViewCell
            cell.title = "Chat Admin"
            cell.selectionStyle = .none
            return cell
        case .logout:
            let cell: ImageFieldViewCell = tableView.dequeueReusableCell(withIdentifier: "ImageFieldViewCell", for: indexPath) as! ImageFieldViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
}
