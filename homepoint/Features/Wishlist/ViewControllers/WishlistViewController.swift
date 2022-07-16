//
//  WishlistViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 29/06/22.
//

import UIKit
import RxSwift
import SkeletonView

enum WishlistPageType {
    case normal, edit
}

final class WishlistViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var notLoginView: NotLoginView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var allCheckbox: Checkbox!
    @IBOutlet weak var itemAmount: UILabel!
    private let refreshControl = UIRefreshControl()

    
    // MARK: - Variables
    var pageType : WishlistPageType = .normal
    private var vm = WishlistViewModel()
    private let bag = DisposeBag()
    var data = [WishlistDataModel]()
    private var isAllSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        vm.getWishlists(userId: "")
        view.showShimmer()
        
        self.addNotificationCenter(
            label: "reload_view",
            selector: #selector(reloadView)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDataIsEmpty()
        setNavigationBar(type: .defaultNav)
    }
    
    deinit {
        removeNotificationCenter()
    }
    
    @IBAction func cleanButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        togglePageType()
    }
}

extension WishlistViewController {
    private func setupUI() {
        allCheckbox.isHidden = true
        allCheckbox.delegate = self
        cleanButton.roundedCorner(with: 8)
        bottomContainerView.dropShadow(
            with: 0.1,
            radius: 4,
            offset: CGSize(width: 0, height: -4)
        )
        checkDataIsEmpty()
        setupTableView()
        
        notLoginView.delegate = self
        notLoginView.isHidden = (UserDefaults.standard.value(forKey: "user_token") != nil) ? true : false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            WishlistItemViewCell.nib(),
            forCellReuseIdentifier: WishlistItemViewCell.identifier
        )
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        vm.getWishlists(userId: "")
        view.showShimmer()
    }
    
    @objc func reloadView() {
        notLoginView.isHidden = true
        
        vm.getWishlists(userId: "")
        view.showShimmer()
    }
    
    private func checkDataIsEmpty() {
        emptyView.isHidden = data.isEmpty ? false : true
    }
    
    private func togglePageType() {
        switch pageType {
        case .normal:
            pageType = .edit
            editButton.setTitle("Batal", for: .normal)
            editButton.setTitleColor(ColorCollection.grayTextColor.value, for: .normal)
            allCheckbox.isHidden = false
            itemAmount.text = "Pilih semua \(data.count)"
        case .edit:
            pageType = .normal
            editButton.setTitle("Atur", for: .normal)
            editButton.setTitleColor(ColorCollection.primaryColor.value, for: .normal)
            allCheckbox.isHidden = true
            itemAmount.text = "\(data.count) Produk"
        }
        reloadTableView()
    }
    
    override func searchTapped(sender: UIBarButtonItem) {
        
    }
}

// MARK: - Binding
extension WishlistViewController {
    private func bindViewModel() {
        vm.successGetWishlists.subscribe { [weak self] in
            self?.handleSuccessGetWishlists($0)
        }.disposed(by: bag)
        vm.successDeleteWishlist.subscribe { [weak self] in
            self?.handleSuccessDeleteWishlist($0)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0.element)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError($0.element)
        }.disposed(by: bag)
    }
    
    private func handleSuccessDeleteWishlist(_ deleted: WishlistDataModel?) {
        guard let deleted = deleted else { return }
        let newData = data.filter {
            return $0.id != deleted.id
        }
        data = newData
        itemAmount.text = self.pageType == .edit ? "Pilih semua \(data.count)" : "\(data.count) Produk"
        checkDataIsEmpty()
        reloadTableView()
    }
    
    private func handleSuccessGetWishlists(_ data : [WishlistDataModel]?) {
        guard let data = data else { return }
        self.data = data
        checkDataIsEmpty()
        view.stopShimmer()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.itemAmount.text = self.pageType == .edit ? "Pilih semua \(data.count)" : "\(data.count) Produk"
            self.tableView.reloadData()
        }
    }
    
    private func handleError(_ error : String?) {
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let isLoading = isLoading else { return }
        if !isLoading {
            refreshControl.endRefreshing()
            reloadTableView()
            DispatchQueue.main.async {
                self.view.stopShimmer()
            }
        }
    }
}

// MARK: - Interaction
extension WishlistViewController : WishlistItemInteraction {
    func didRemoveTapped(_ id: String) {
        let alert = self.createConfirmationAlert(
            "Konfirmasi",
            "Apakah kamu yakin ingin menghapus wishlist ini?"
        ) { [weak self] _ in
            self?.vm.deleteWishlist(id: id)
            self?.reloadTableView()
        }
        self.present(alert, animated: true)
    }
    
    func didAddToCartTapped(_ id: String) {
        
    }
}
extension WishlistViewController : CheckboxClickable {
    func didTap(_ isSelected: Bool) {
        isAllSelected = isSelected
        reloadTableView()
    }
}
extension WishlistViewController : LoginProtocol, NotLoginViewProtocol {
    func successLogin() {
        reloadView()
    }
    
    func navigateToLogin() {
        let vc = LoginViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TableView
extension WishlistViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WishlistItemViewCell.identifier,
            for: indexPath
        ) as? WishlistItemViewCell
        cell?.state = pageType
        cell?.data = data[indexPath.row]
        cell?.delegate = self
        cell?.shouldChecked = isAllSelected
        return cell ?? UITableViewCell()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Skeleton
extension WishlistViewController : SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        WishlistItemViewCell.identifier
    }
}
