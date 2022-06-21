//
//  HistoryViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit
import SkeletonView

class OrderListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    private enum SectionType {
        case orderFilter, orderList
    }
    private let sections : [SectionType] = [
        .orderFilter, .orderList
    ]
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .searchAndHistory)
    }
}

extension OrderListViewController {
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            OrderListViewCell.nib(),
            forCellReuseIdentifier: OrderListViewCell.identifier
        )
        tableView.register(
            OrderFilterViewCell.nib(),
            forCellReuseIdentifier: OrderFilterViewCell.identifier
        )
        tableView.sectionFooterHeight = 0.00001
    }
}

// MARK: - NavigationBar
extension OrderListViewController {
    override func historyTapped(sender: UIBarButtonItem) {
        navigationController?
            .pushViewController(
                HistoryViewController(),
                animated: true
            )
    }
}

// MARK: - TableView
extension OrderListViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sections[section] == .orderFilter ? 1 : orderListData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        switch sections[indexPath.section] {
        case .orderFilter:
            let cellFilter = tableView.dequeueReusableCell(
                withIdentifier: OrderFilterViewCell.identifier,
                for: indexPath
            ) as? OrderFilterViewCell
            cell = cellFilter ?? UITableViewCell()
        case .orderList:
            let cellList = tableView.dequeueReusableCell(
                withIdentifier: OrderListViewCell.identifier,
                for: indexPath
            ) as? OrderListViewCell
            cellList?.data = orderListData[indexPath.row]
            cell = cellList ?? UITableViewCell()
        }
        return cell
    }

}
