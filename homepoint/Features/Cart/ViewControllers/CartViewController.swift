//
//  CartViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/07/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView
import SkeletonView

final class CartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    private let refreshControl = UIRefreshControl()
    
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
    private enum SectionType {
        case items, purchase
    }
    private let sections : [SectionType] = [.items, .purchase]
    private var quantity = 0
    private let vm = CartViewModel()
    private let bag = DisposeBag()
    private var carts : [CartDataModel] = []
    private var userId = ""
    private var selectedId = [String]()
    private var wishlistId = ""
    
    init() {
        super.init(nibName: Constants.CartVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        vm.getCarts(userId: userId)
        view.showShimmer()
        
        self.addNotificationCenter(
            label: "reload_cart",
            selector: #selector(reloadView)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backTitleAndLike(title: "Keranjang", isFavorite: true))
    }
    
    deinit {
        self.removeNotificationCenter()
    }
    
    @IBAction func purchaseButtonTapped(_ sender: Any) {
        let vc = PaymentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CartViewController {
    private func setupUI() {
        purchaseButton.roundedCorner(with: 8)
        checkButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CartItemViewCell.nib(),
            forCellReuseIdentifier: CartItemViewCell.identifier
        )
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        checkDataIsEmpty()
        self.userId = getUserId() ?? ""
    }

    @objc func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        vm.getCarts(userId: userId)
        view.showShimmer()
    }
    
    private func checkButton() {
        if selectedId.isEmpty {
            purchaseButton.isEnabled = false
            purchaseButton.alpha = 0.5
        } else {
            purchaseButton.isEnabled = true
            purchaseButton.alpha = 1
        }
        purchaseButton.setTitle("Beli (\(selectedId.count))", for: .normal)
    }
    
    private func checkDataIsEmpty() {
        emptyView.isHidden = carts.isEmpty ? false : true
    }
    
    @objc func reloadView() {
        vm.getCarts(userId: getUserId() ?? "")
        view.showShimmer()
    }
}

// MARK: - Binding
extension CartViewController {
    func bindViewModel() {
        vm.error.subscribe { [weak self] in
            self?.handleError($0)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0)
        }.disposed(by: bag)
        vm.successFetchCarts.subscribe { [weak self] in
            self?.handleSuccessFetchCarts($0)
        }.disposed(by: bag)
        vm.successDeleteCart.subscribe { [weak self] in
            self?.handleSuccessDeleteCart($0)
        }.disposed(by: bag)
    }
    
    private func handleSuccessDeleteCart(_ deleted: [CartDataModel]?) {
        guard let deleted = deleted?.first else { return }
        let newData = self.carts.filter {
            return $0.id != deleted.id
        }
        self.carts = newData
        vm.getCarts(userId: userId)
        view.showShimmer()
    }
    
    private func handleSuccessFetchCarts(_ carts: [CartDataModel]?) {
        guard let carts = carts else { return }
        self.carts = carts
        checkDataIsEmpty()
        tableView.reload()
    }
    
    private func handleError(_ error: String?) {
        guard let error = error else { return }
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let loading = isLoading
        else { return }
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            if !loading { self.view.stopShimmer() }
        }
    }
    
    private func handleIsWishlist(_ wishlistId: String?) {
        self.wishlistId = wishlistId ?? ""
        tableView.reload()
    }
    
    private func handleDeleteWishlist() {
        self.wishlistId = ""
        tableView.reload()
        let alert = self.createSimpleAlert(
            "Berhasil",
            "Berhasil menghapus produk dalam wishlist",
            "OK"
        )
        self.present(alert, animated: true)

        self.postNotificationCenter(label: "reload_wishlist")
    }
    
    private func handleSuccessAddWishlist(_ wishlist: WishlistDataModel?) {
        self.wishlistId = wishlist?.id ?? ""
        let alert = self.createSimpleAlert(
            "Berhasil",
            "Berhasil menambahkan produk sebagai wishlist",
            "OK"
        )
        self.present(alert, animated: true)
        self.postNotificationCenter(label: "reload_wishlist")
    }
}

// MARK: - Interaction
extension CartViewController : CartItemInteraction {
    func didSelect(_ id: String) {
        if selectedId.contains(id) {
            selectedId = selectedId.filter { $0 != id }
        } else { selectedId.append(id) }
        checkButton()
    }
    
    func didLikeTapped(_ id: String) {
        
    }
    
    func didRemoveTapped(_ id: String) {
        let alert = self.createConfirmationAlert(
            "Konfirmasi",
            "Apakah kamu yakin ingin menghapus barang ini dari keranjang?"
        ) { [weak self] _ in
            self?.vm.deleteCartItem(id: id)
            self?.tableView.reload()
        }
        self.present(alert, animated: true)
    }
}

// MARK: - TableView
extension CartViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        carts.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CartItemViewCell.identifier,
            for: indexPath
        ) as? CartItemViewCell
        cell?.delegate = self
        cell?.data = carts[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

// MARK: - Skeleton
extension CartViewController : SkeletonTableViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        4
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        CartItemViewCell.identifier
    }
}
