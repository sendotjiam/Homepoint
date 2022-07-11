//
//  PaymentViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

final class PaymentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var voucherButton: UIButton!
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
    
    // MARK: - Variables
    let courierData : [CourierCellModel] = [
        CourierCellModel(title: "Kurir reguler", image: "ic_regular.courier", price: 25000),
        CourierCellModel(title: "Kurir homepoint", image: "ic_homepoint.courier", price: 0),
        CourierCellModel(title: "Ambil di tempat", image: "ic_pickup.shop", price: 0)
    ]
    var subtotalPrice = 0.0
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Pembayaran"))
    }

    @IBAction func changeAddressButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func paymentButtonTapped(_ sender: Any) {
    }
    
    @IBAction func voucherButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func selectShopLocationButtonTapped(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.type = .shopLocations
        vc.data = [
            SheetItemCellModel(title: "Homepoint Cabang Malang", image: "ic_homepoint"),
            SheetItemCellModel(title: "Homepoint Cabang Surabaya", image: "ic_homepoint"),
            SheetItemCellModel(title: "Homepoint Cabang Jakarta", image: "ic_homepoint")
        ]
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
    
    @IBAction func paymentMethodButtonTapped(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.type = .paymentMethods
        vc.data = [
            SheetItemCellModel(title: "Bank Negara Indonesia", image: "ic_BNI"),
            SheetItemCellModel(title: "Bank Rakyat Indonesia", image: "ic_BRI"),
            SheetItemCellModel(title: "Bank Central Asia", image: "ic_BCA"),
            SheetItemCellModel(title: "Bank Tabungan Negara", image: "ic_BTN"),
            SheetItemCellModel(title: "Bank Mandiri", image: "ic_MANDIRI")
        ]
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
}

extension PaymentViewController {
    private func setupUI() {
        addressView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        paymentMethodView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        voucherButton.addBorder(width: 1, color: .black)
        [addressView,
         voucherButton,
         shopLocationView,
         paymentMethodView,
         paymentButton].forEach {
            $0?.roundedCorner(with: 8)
        }
        calculateTableViewHeightAndSubtotalPrice()
        
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
}

extension PaymentViewController : PaymentOrderListProtocol {
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
        case .paymentMethods:
            paymentMethodImageView.isHidden = false
            paymentMethodImageView.image = UIImage(named: data.image)
            paymentMethodLabel.text = data.title
            paymentMethodLabel.textColor = .black
        }
    }
}

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
        3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CourierViewCell.identifier,
            for: indexPath
        ) as? CourierViewCell
        cell?.courier = courierData[indexPath.row]
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
        switch indexPath.row {
        case 2:
            selectShopLocationButton.isEnabled = true
            shopLocationView.backgroundColor = .white
            shopLocationView.addBorder(width: 1, color: ColorCollection.primaryColor.value)
            if selectShopLocationLabel.tag != 1 {
                selectShopLocationLabel.textColor = ColorCollection.primaryColor.value
            }
        default:
            shopLocationLabel.isHidden = true
            selectShopLocationButton.isEnabled = false
            selectShopLocationLabel.textColor = ColorCollection.darkTextColor.value
            selectShopLocationLabel.text = "Pilih Lokasi Toko"
            shopLocationView.backgroundColor = ColorCollection.ligthTextColor.value
            shopLocationView.addBorder(width: 0, color: ColorCollection.primaryColor.value)
        }
    }
}
