//
//  DetailViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/06/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

final class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
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
    
    
    // MARK: - Section
    private enum SectionType {
        case header, description, review, others, shipping
    }
    private let sections : [SectionType] = [
        .header, .description, .shipping, .review, .others
    ]
    private var reviewList : Int = 10
    private var userId = ""
    
    // MARK: - Variable
    private var qty = 1.0
    private var discountValue = 0.0
    private var discountedPrice = 0.0
    private var originalPrice = 0.0
    private var finalPrice = 0.0
    private var productData : ProductDataModel?
    private var otherProducts = [ProductDataModel]()
    private var wishlistId = ""
    
    private let vm = DetailViewModel()
    private let bag = DisposeBag()
    
    // MARK: - Life Cycle
    init(_ id: String) {
        super.init(nibName: Constants.DetailVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        vm.getProductAndOtherProducts(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backSearchAndCart(isTransparent: true))
    }
    
    deinit {
        self.removeNotificationCenter()
    }
    
    // MARK: - Actions
    @IBAction func plusButtonTapped(_ sender: Any) {
        qty += 1
        countTotalPrice()
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if qty <= 1 { return }
        qty -= 1
        countTotalPrice()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        if isUserLoggedIn() {
            guard let data = productData
            else { return }
            vm.addToCart(userId: userId, productId: data.id, qty: Int(qty))
        } else {
            showNotLoginAlert()
        }
    }
}

extension DetailViewController {
    private func setupUI() {
        overlayView.alpha = 1
        countTotalPrice()
        bottomContainerView.dropShadow(
            with: 0.1,
            radius: 4,
            offset: CGSize(width: 0, height: -4)
        )
        plusButton.roundedCorner(with: 4)
        minusButton.addBorder(width: 1, color: .lightGray)
        minusButton.roundedCorner(with: 4)
        addToCartButton.roundedCorner(with: 8)
        setupTableView()
        
        if #available(iOS 11.0, *) {
             tableView.contentInsetAdjustmentBehavior = .never
        }
        
        self.userId = getUserId() ?? ""
    }
    
    private func countTotalPrice() {
        discountedPrice = finalPrice * qty
        qtyLabel.text = "\(Int(qty))"
        totalPriceLabel.text = "\(discountedPrice.convertToCurrency())"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell([
            DetailHeaderViewCell.nib(),
            DetailDescriptionViewCell.nib(),
            ShippingOptionsViewCell.nib(),
            ReviewHeaderViewCell.nib(),
            ReviewListViewCell.nib(),
            ReviewSeeMoreViewCell.nib(),
            OtherViewCell.nib()
        ], [
            DetailHeaderViewCell.identifier,
            DetailDescriptionViewCell.identifier,
            ShippingOptionsViewCell.identifier,
            ReviewHeaderViewCell.identifier,
            ReviewListViewCell.identifier,
            ReviewSeeMoreViewCell.identifier,
            OtherViewCell.identifier
        ])
    }
    
    private func registerTableViewCell(
        _ nibs : [UINib],
        _ identifiers : [String]
    ) {
        for idx in 0..<nibs.count{
            tableView.register(
                nibs[idx],
                forCellReuseIdentifier: identifiers[idx]
            )
        }
    }
}

// MARK: - Binding
extension DetailViewController {
    private func bindViewModel() {
        vm.error.subscribe { [weak self] in
            self?.handleError($0.element)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0.element)
        }.disposed(by: bag)
        vm.successGetProduct.subscribe { [weak self] in
            self?.handleSuccessGetProduct($0.element)
        }.disposed(by: bag)
        vm.successAddWishlist.subscribe { [weak self] in
            self?.handleSuccessAddWishlist($0.element)
        }.disposed(by: bag)
        vm.successGetOthersProducts.subscribe { [weak self] in
            self?.handleSuccessGetOtherProducts($0.element)
        }.disposed(by: bag)
        vm.successIsWishlist.subscribe { [weak self] in
            self?.handleIsWishlist($0.element)
        }.disposed(by: bag)
        vm.successDeleteWishlist.subscribe { [weak self] _ in
            self?.handleDeleteWishlist()
        }.disposed(by: bag)
        vm.successAddToCart.subscribe { [weak self] _ in
            self?.handleSuccessAddToCart()
        }.disposed(by: bag)
    }
    
    private func handleSuccessAddToCart() {
        let alert = self.createSimpleAlert(
            "Berhasil",
            "Berhasil menambahkan produk ke dalam keranjang",
            "OK"
        )
        self.present(alert, animated: true)
    }
    
    private func handleError(_ error: String?) {
        guard let error = error else { return }
        self.handleError(msg: error)
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
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let loading = isLoading
        else { return }
        DispatchQueue.main.async {
            self.showLoader(self.loaderView, self.loader, loading)
            self.overlayView.isHidden = loading ? false : true
        }
    }
    
    private func handleSuccessGetProduct(
        _ product : ProductDataModel?
    ) {
        guard let data = product else { return }
        
        originalPrice = data.price
        discountValue = (data.price * (data.discount / 100))
        finalPrice = originalPrice - discountValue
        
        countTotalPrice()
        
        self.productData = data
        vm.checkProductIsWishlist(userId: userId, productId: productData?.id ?? "")
        tableView.reload()
    }
    
    private func handleSuccessGetOtherProducts(
        _ products : [ProductDataModel]?
    ) {
        self.otherProducts = products ?? []
        tableView.reload()
    }
}

// MARK: - Navigation Bar
extension DetailViewController {
    override func searchTapped(sender: UIBarButtonItem) {
        let vc = SearchViewController("")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Delegation
extension DetailViewController : DetailHeaderProtocol {
    func didTapLikeButton(id: String) {
        if isUserLoggedIn() {
            wishlistId != "" ? vm.deleteWishlist(id: wishlistId) : vm.addWishlist(userId: userId,productId: id)
            overlayView.alpha = 0.2
        } else {
            showNotLoginAlert()
        }
    }
    func didTapShareButton() { return }
    func didTapMessageButton() {return}
    func didTapCompareButton() {return}
}

// MARK: - TableView
extension DetailViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch sections[section] {
        case .description : return productData?.description == "" ? 0 : 1
        case .review: return reviewList + 2
        case .others : return otherProducts.isEmpty ? 0 : 1
        default: return 1
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        var cell : UITableViewCell?
        switch sections[indexPath.section] {
        case .header:
            cell = generateCell(DetailHeaderViewCell.identifier, indexPath)
        case .description:
            cell = generateCell(DetailDescriptionViewCell.identifier, indexPath)
        case .shipping:
            cell = generateCell(ShippingOptionsViewCell.identifier, indexPath)
        case .review:
            switch indexPath.row {
            case 0:
                cell = generateCell(ReviewHeaderViewCell.identifier, indexPath)
            case reviewList + 1:
                cell = generateCell(ReviewSeeMoreViewCell.identifier, indexPath)
            default:
                cell = generateCell(ReviewListViewCell.identifier, indexPath)
            }
        case .others:
            cell = generateCell(OtherViewCell.identifier, indexPath)
        }
        return cell ?? UITableViewCell()
    }
    
    private func generateCell<T : UITableViewCell>(
        _ id: String,
        _ indexPath: IndexPath
    ) -> T? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: id,
            for: indexPath
        ) as? T
        switch sections[indexPath.section] {
        case .header:
            guard let cellHeader = cell as? DetailHeaderViewCell
            else { return nil }
            cellHeader.data = productData
            cellHeader.delegate = self
            cellHeader.isWishlist = wishlistId == "" ? false : true
            return cellHeader as? T
        case .description:
            guard let cellDescription = cell as? DetailDescriptionViewCell
            else { return nil }
            cellDescription.content = productData?.description
            cellDescription.didTapSeeMoreButton = { return }
            return cellDescription as? T
        case .review:
            switch indexPath.row {
            case 0:
                guard let cellHeader = cell as? ReviewHeaderViewCell
                else { return nil }
                return cellHeader as? T
            case reviewList + 1:
                guard let cellSeeMore = cell as? ReviewSeeMoreViewCell
                else { return nil }
                cellSeeMore.didTapSeeMoreButton = { return }
                return cellSeeMore as? T
            default:
                guard let cellList = cell as? ReviewListViewCell
                else { return nil }
                return cellList as? T
            }
        case .others:
            guard let cell = cell as? OtherViewCell
            else { return nil }
            cell.products = otherProducts
            cell.didSelectItem = { [weak self] in
                let vc = DetailViewController($0)
                self?.navigationController?
                    .pushViewController(
                        vc,
                        animated: true
                    )
            }
            return cell as? T
        default: return cell
        }
    }
}
