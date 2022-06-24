//
//  SortViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 23/06/22.
//

import UIKit

enum SortState : String {
    case bestSeller = "Produk Terlaris"
    case latest = "Produk Terbaru"
    case cheapest = "Harga Termurah"
    case expensive = "Harga Termahal"
}

protocol SortProductDelegate {
    func sort(by sort: SortState)
}

final class SortViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    // MARK: - Variables
    private let sortStates : [SortState] = [.bestSeller, .latest, .cheapest, .expensive]
    private var selectedState : SortState?
    var delegate : SortProductDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func applyButtonTapped(_ sender: Any) {
        guard let selectedState = selectedState else { return }
        delegate?.sort(by: selectedState)
        self.dismiss(animated: true)
    }
}

extension SortViewController {
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            SortItemViewCell.nib(),
            forCellReuseIdentifier: SortItemViewCell.identifier
        )
        applyButton.roundedCorner(with: 8)
    }
}

// MARK: - TableView
extension SortViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sortStates.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SortItemViewCell.identifier,
            for: indexPath
        ) as? SortItemViewCell
        cell?.state = sortStates[indexPath.row].rawValue
        return cell ?? UITableViewCell()
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        selectedState = sortStates[indexPath.row]
    }
    
    func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath
    ) {
        
    }
    
}
