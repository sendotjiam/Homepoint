//
//  PaymentViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView
import SDWebImage

final class PaymentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shopLocationLabel: UILabel!
    @IBOutlet weak var selectShopLocationLabel: UILabel!
    @IBOutlet weak var shopLocationView: UIView!
    @IBOutlet weak var selectShopLocationButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var totalSpendingLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var paymentMethodButton: UIButton!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountInfoStackView: UIStackView!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var paymentMethodView: UIView!
    @IBOutlet weak var paymentMethodImageView: UIImageView!
    @IBOutlet weak var paymentMethodLabel: UILabel!
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
    
    // MARK: - Variables
    private var couriers = [ShippingResponseModel]()
    private var banks = [BankResponseModel]()
    private var totalPrice = 0.0
    private var subtotalPrice = 0.0 {
        didSet {
            totalSpending = subtotalPrice
            totalSpendingLabel.text = totalSpending.convertToCurrency()
        }
    }
    private var totalSpending = 0.0 {
        didSet {
            totalPrice = totalSpending
            totalPaymentLabel.text = totalPrice.convertToCurrency()
        }
    }
    private var hasChoosePaymentMethod = false
    private var hasChooseCourier = false
    // Mock Data
    let ordersData : [PaymendOrderListCellModel] = [
        PaymendOrderListCellModel(
            title: "Penggorengan Elektronik tanpa minyak / Air Fryer 2.5 L / Microwave Ori Penggorengan Elektronik tanpa minyak / Air Fryer 2.5 L / Microwave Ori",
            quantity: 1,
            price: 529000,
            needInsurance: true
        ),
        PaymendOrderListCellModel(
            title: "Non-Stick Cookware Set",
            quantity: 1,
            price: 529000,
            needInsurance: true
        ),
        PaymendOrderListCellModel(
            title: "Gelas Mug Keramik 300ml Hitam Polos",
            quantity: 4,
            price: 529000,
            needInsurance: false
        )
    ]
    private let vm = TransactionViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        vm.getBanksAndShipping().disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Pembayaran"))
    }

    @IBAction func changeAddressButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func paymentButtonTapped(_ sender: Any) {
        let vc = ConfirmPaymentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectShopLocationButtonTapped(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.type = .shopLocations
        vc.data = [
            SheetItemCellModel(title: "Homepoint Cabang Malang", image: "ic_homepoint", imageFromUrl: false),
            SheetItemCellModel(title: "Homepoint Cabang Surabaya", image: "ic_homepoint", imageFromUrl: false),
            SheetItemCellModel(title: "Homepoint Cabang Jakarta", image: "ic_homepoint", imageFromUrl: false)
        ]
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
    
    @IBAction func paymentMethodButtonTapped(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.type = .paymentMethods
        vc.data = banks.map {
            SheetItemCellModel(title: $0.bankName, image: $0.bankLogo)
        }
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
}

extension PaymentViewController {
    private func setupUI() {
        addressView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        paymentMethodView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        [addressView,shopLocationView,paymentMethodView,paymentButton].forEach {
            $0?.roundedCorner(with: 8)
        }
        calculateTableViewHeightAndSubtotalPrice()
        
        paymentButton.isEnabled = false
         
        accountInfoStackView.isHidden = true
        paymentMethodImageView.isHidden = true
        
        setupTableView()
        setupCollectionView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            PaymentOrderListViewCell.nib(),
            forCellReuseIdentifier: PaymentOrderListViewCell.identifier
        )
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CourierViewCell.nib(),
            forCellWithReuseIdentifier: CourierViewCell.identifier
        )
    }
    
    func calculateTableViewHeightAndSubtotalPrice() {
        var height = 0.0
        ordersData.forEach {
            height += (50)
            if $0.needInsurance { height += 17 }
            subtotalPrice += $0.price
        }
        height += 34
        subtotalLabel.text = subtotalPrice.convertToCurrency()
        tableViewHeight.constant = height
    }
    
    private func checkAccount(title : String) -> BankResponseModel? {
        return banks.filter {
            $0.bankName == title
        }.first
    }
    
    private func checkButton() {
        paymentButton.isEnabled = (hasChooseCourier && hasChoosePaymentMethod) ? true : false
    }
}

// MARK: - Binding
extension PaymentViewController {
    func bindViewModel() {
        vm.successGetBanksAndShipping.subscribe { [weak self] in
            self?.handleSuccessGetBanksAndShipping($0, $1)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError($0.element)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0.element)
        }.disposed(by: bag)
    }
    
    private func handleSuccessGetBanksAndShipping(
        _ banks : [BankResponseModel],
        _ shipping : [ShippingResponseModel]
    ) {
        self.couriers = shipping
        self.banks = banks
        tableView.reload()
        collectionView.reload()
    }
    
    private func handleError(_ error : String?) {
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

// MARK: - Delegate
extension PaymentViewController : PaymentOrderListDelegate {
    func didTapInsurance(_ includeInsurance: Bool) {
        subtotalPrice += (includeInsurance ? 100000 : -100000)
        subtotalLabel.text = subtotalPrice.convertToCurrency()
    }
}

extension PaymentViewController : BottomSheetDelegate {
    func didSelectItem(type: SheetType, data: SheetItemCellModel) {
        switch type {
        case .shopLocations:
            shopLocationLabel.isHidden = false
            selectShopLocationLabel.text = data.title
            selectShopLocationLabel.textColor = .black
            selectShopLocationLabel.tag = 1
            hasChooseCourier = true
            checkButton()
        case .paymentMethods:
            let imageUrl = URL(string: data.image)
            paymentMethodImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_placeholder.small"))
            paymentMethodImageView.isHidden = false
            paymentMethodLabel.text = data.title
            paymentMethodLabel.textColor = .black
            accountInfoStackView.isHidden = false
            hasChoosePaymentMethod = true
            checkButton()
            guard let account = checkAccount(title: data.title) else { return }
            accountNameLabel.text = "a/n \(account.holderName)"
            accountNumberLabel.text = account.accountNumber
        }
    }
}

// MARK: - TableView
extension PaymentViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        ordersData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PaymentOrderListViewCell.identifier,
            for: indexPath
        ) as? PaymentOrderListViewCell
        cell?.delegate = self
        cell?.data = ordersData[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

extension PaymentViewController :
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        couriers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CourierViewCell.identifier,
            for: indexPath
        ) as? CourierViewCell
        cell?.courier = couriers[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.size.width - 20) / 3
        let height = 104 / 99 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        shopLocationLabel.isHidden = true
        selectShopLocationButton.isEnabled = false
        selectShopLocationLabel.text = "Pilih Lokasi Toko"
        selectShopLocationLabel.textColor = ColorCollection.darkTextColor.value
        shopLocationView.backgroundColor = ColorCollection.ligthTextColor.value
        shopLocationView.addBorder(width: 0, color: ColorCollection.primaryColor.value)
        switch indexPath.row {
        case 0:
            selectShopLocationLabel.text = "Homepoint Cabang Malang"
            shopLocationLabel.isHidden = false
            shopLocationView.backgroundColor = .white
            shopLocationView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
            selectShopLocationLabel.textColor = .black
            hasChooseCourier = true
        case 1:
            guard let address = addressLabel.text else { return }
            if (address.lowercased().contains("kota malang") || address.lowercased().contains("kota bandung") || address.lowercased().contains("kota jakarta")) {
                var city = ""
                if address.lowercased().contains("kota malang") { city = "Malang" }
                else if address.lowercased().contains("kota bandung") { city = "Bandung" }
                else { city = "Jakarta" }
                selectShopLocationLabel.text = "Homepoint Cabang \(city)"
                shopLocationLabel.isHidden = false
                shopLocationView.backgroundColor = .white
                shopLocationView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
                selectShopLocationLabel.textColor = .black
                hasChooseCourier = true
            } else { hasChooseCourier = false }
        case 2:
            hasChooseCourier = false
            selectShopLocationButton.isEnabled = true
            shopLocationView.backgroundColor = .white
            shopLocationView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
            if selectShopLocationLabel.tag != 1 {
                selectShopLocationLabel.textColor = ColorCollection.primaryColor.value
            }
        default:
            break
        }
        checkButton()
    }
}
