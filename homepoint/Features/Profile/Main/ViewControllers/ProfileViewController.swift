//
//  ProfileViewController.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

final class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var notLoginView: NotLoginView!
    @IBOutlet weak var overlayView: NotLoginView!
    
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
    
    // MARK: - Variables
    var userData: UserDataModel?
    
    private enum section {
        case changeProfile, address, changePassword, policy, help, chatAdmin, logout
    }
    private var sections: [section] = [.changeProfile, .address, .changePassword, .policy, .help, .chatAdmin, .logout]
    private let vm = ProfileViewModel()
    private let bag = DisposeBag()
    private var userId = ""
    
    init() {
        super.init(nibName: Constants.ProfileVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        vm.getUserData(userId: userId)
        
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
        
        notLoginView.isHidden = isUserLoggedIn()
        userId = getUserId() ?? ""
    }
    
    @objc func reloadView() {
        notLoginView.isHidden = true
        // call API
        vm.getUserData(userId: userId)
        bindViewModel()
    }
}

extension ProfileViewController : LoginDelegate {
    func successLogin() {
        reloadView()
    }
}

extension ProfileViewController {
    private func bindViewModel() {
        vm.successGetUserData.subscribe { [weak self] in
            self?.handleSuccessGetUserData($0.element)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError(msg: $0.element)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0.element)
        }.disposed(by: bag)
    }
    
    private func handleSuccessGetUserData(_ user : UserDataModel?) {
        guard let data = user else { return }
        
        self.userData = data
        profileTableView.reload()
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
            cell.name = userData?.name
            cell.number = userData?.phoneNumber
            cell.selectionStyle = .none
            cell.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .logout:
            UserDefaults.standard.set(nil, forKey: "user_id")
            UserDefaults.standard.set(nil, forKey: "user_token")
            notLoginView.isHidden = isUserLoggedIn()
        default:
            break
        }
    }
}

extension ProfileViewController : ChangeProfileFieldDelegate {
    func didTap() {
        guard let userData = userData else { return }
        let vc = ChangeProfileViewController(userData)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(
                vc,
                animated: true
            )
        }
    }
}
