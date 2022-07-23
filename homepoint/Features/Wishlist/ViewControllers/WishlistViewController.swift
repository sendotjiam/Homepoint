//
//  WishlistViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 29/06/22.
//

import UIKit
import RxSwift
import SkeletonView

final class WishlistViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var notLoginView: NotLoginView!
    
    private let refreshControl = UIRefreshControl()

    
    // MARK: - Variables
    private var vm = WishlistViewModel()
    private let bag = DisposeBag()
    var data = [WishlistDataModel]()
    private var userId = ""
    private var selectedId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        vm.getWishlists(userId: getUserId() ?? "")
        view.showShimmer()
        
        self.addNotificationCenter(
            label: "reload_view",
            selector: #selector(reloadView)
        )
        self.addNotificationCenter(
            label: "reload_wishlist",
            selector: #selector(reloadView)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .defaultNav)
    }
    
    deinit {
        removeNotificationCenter()
    }
    
    @IBAction func cleanButtonTapped(_ sender: Any) {
        handleBulkDeleteWishlists()
    }
}

extension WishlistViewController {
    private func handleBulkDeleteWishlists() {
        let alert = self.createConfirmationAlert(
            "Konfirmasi",
            "Apakah kamu yakin ingin menghapus wishlist ini?"
        ) { [weak self] _ in
            guard let self = self else { return }
            self.vm.bulkDeleteWishlists(ids: self.selectedId)
            self.tableView.reload()
        }
        self.present(alert, animated: true)
    }
    
    private func setupUI() {
        cleanButton.roundedCorner(with: 8)
        bottomContainerView.dropShadow(
            with: 0.1,
            radius: 4,
            offset: CGSize(width: 0, height: -4)
        )
        checkDataIsEmpty()
        setupTableView()
        checkButton()
        
        notLoginView.delegate = self
        notLoginView.isHidden = isUserLoggedIn()
        
        self.userId = getUserId() ?? ""
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
        vm.getWishlists(userId: getUserId() ?? "")
        view.showShimmer()
    }
    
    @objc func reloadView() {
        notLoginView.isHidden = true
        
        vm.getWishlists(userId: getUserId() ?? "")
        view.showShimmer()
    }
    
    private func checkDataIsEmpty() {
        emptyView.isHidden = data.isEmpty ? false : true
    }
    
    private func checkButton() {
        if selectedId.isEmpty {
            cleanButton.isEnabled = false
            cleanButton.alpha = 0.5
        } else {
            cleanButton.isEnabled = true
            cleanButton.alpha = 1
        }
    }
    
    override func cartTapped(sender: UIBarButtonItem) {
        if isUserLoggedIn() {
            let vc = CartViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func notificationTapped(sender: UIBarButtonItem) {
        if isUserLoggedIn() {
        }
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
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
            self?.handleLoading($0)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError($0)
        }.disposed(by: bag)
        vm.successAddToCart.subscribe { [weak self] in
            self?.handleSuccessAddToCart($0)
        }.disposed(by: bag)
        vm.successBulkDeleteWishlists.subscribe { [weak self] _ in
            self?.handleSuccessBulkDeleteWishlists()
        }.disposed(by: bag)
    }
    
    private func handleSuccessBulkDeleteWishlists() {
        selectedId = []
        vm.getWishlists(userId: userId)
    }
    
    private func handleSuccessAddToCart(_ data : CartDataModel?) {
        guard let data = data else { return }
        let newData = self.data.filter {
            return $0.products.id != data.products.id
        }
        self.data = newData
        checkDataIsEmpty()
        tableView.reload()
        let alert = self.createSimpleAlert(
            "Berhasil",
            "Berhasil menambahkan produk ke dalam keranjang",
            "OK"
        )
        self.present(alert, animated: true)
        
        self.postNotificationCenter(label: "reload_cart")
    }
    
    private func handleSuccessDeleteWishlist(_ deleted: WishlistDataModel?) {
        guard let deleted = deleted else { return }
        let newData = data.filter {
            return $0.id != deleted.id
        }
        data = newData
        checkDataIsEmpty()
        tableView.reload()
    }
    
    private func handleSuccessGetWishlists(_ data : [WishlistDataModel]?) {
        guard let data = data else { return }
        self.data = data
        checkDataIsEmpty()
        view.stopShimmer()
        tableView.reload()
    }
    
    private func handleError(_ error : String?) {
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let isLoading = isLoading else { return }
        if !isLoading {
            refreshControl.endRefreshing()
            tableView.reload()
            DispatchQueue.main.async {
                self.view.stopShimmer()
            }
        }
    }
}

// MARK: - Interaction
extension WishlistViewController : WishlistItemInteraction {
    func didSelect(_ id: String) {
        if selectedId.contains(id) {
            selectedId = selectedId.filter { $0 != id }
        } else { selectedId.append(id) }
        checkButton()
    }
    
    func didRemoveTapped(_ id: String) {
        let alert = self.createConfirmationAlert(
            "Konfirmasi",
            "Apakah kamu yakin ingin menghapus wishlist ini?"
        ) { [weak self] _ in
            self?.vm.deleteWishlist(id: id)
            self?.tableView.reload()
        }
        self.present(alert, animated: true)
    }
    
    func didAddToCartTapped(_ id: String) {
        vm.addToCart(userId: userId, productId: id, qty: 1)
    }
}

extension WishlistViewController : LoginDelegate {
    func successLogin() {
        reloadView()
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
        cell?.data = data[indexPath.row]
        cell?.delegate = self
        return cell ?? UITableViewCell()
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
