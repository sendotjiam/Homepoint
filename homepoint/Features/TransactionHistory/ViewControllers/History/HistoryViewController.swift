//
//  HistoryViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 07/06/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!{
        didSet{
            segmentedControl.setButtonTitles(
                buttonTitles: ["Semua","Selesai","Gagal"]
            )
            segmentedControl.selectorViewColor = ColorCollection.primaryColor.value
            segmentedControl.selectorTextColor = ColorCollection.primaryColor.value
        }
    }
    
    // MARK: - Data
    /// Mock Data
    private let orderListData = [
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .finished, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .failed, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .unconfirm, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .unpaid, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .rated, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .sent, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .packed, amount: 3, price: 90000),
        OrderListItemCellModel(title: "Barang Mantap", imageUrl: "", date: "20 Januari 2022", status: .arrived, amount: 3, price: 90000)
    ]
    
    // MARK: - Variable
    private enum SegmentedType {
        case all, finished, failed
    }
    private let states : [SegmentedType] = [
        .all, .finished, .failed
    ]
    private var selectedState : SegmentedType = .all
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: Constants.HistoryVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Riwayat Pesanan"))
    }

}

extension HistoryViewController {
    private func setupUI() {
        segmentedControl.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            OrderListViewCell.nib(),
            forCellReuseIdentifier: OrderListViewCell.identifier
        )
    }
}

// MARK: - CustomSegmentedControl
extension HistoryViewController :
    CustomSegmentedControlDelegate {
    func change(to index: Int) {
        if selectedState != states[index] {
            selectedState = states[index]
        }
        // FILTER THE DATA
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension HistoryViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        orderListData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderListViewCell.identifier,
            for: indexPath
        ) as? OrderListViewCell
        cell?.data = orderListData[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
