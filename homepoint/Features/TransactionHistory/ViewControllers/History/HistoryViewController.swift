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
    
    
    // MARK: - Variable
    private enum SegmentedType {
        case all, finished, failed
    }
    private let states : [SegmentedType] = [
        .all, .finished, .failed
    ]
    private var selectedState : SegmentedType = .all
    
    // MARK: - Life Cycle
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
        10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderListViewCell.identifier,
            for: indexPath
        ) as? OrderListViewCell
        return cell ?? UITableViewCell()
    }
}
