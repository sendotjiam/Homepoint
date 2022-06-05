//
//  HistoryViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit

class HistoryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private enum SectionType {
        case orderFilter, orderList
    }
    
    private let sections : [SectionType] = [
        .orderFilter, .orderList
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndSearch)
    }

}

extension HistoryViewController {
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

extension HistoryViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .orderFilter:
            return 1
        case .orderList:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        switch sections[indexPath.section] {
        case .orderFilter:
            print("test")
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
            cell = cellList ?? UITableViewCell()
        }
        return cell
    }

}
