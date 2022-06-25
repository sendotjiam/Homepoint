//
//  BottomSheetViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/06/22.
//

import UIKit

enum BottomSheetType {
    case sort, filter
}

final class SortFilterSheetViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Initialize
    private let type : BottomSheetType
    init(type : BottomSheetType) {
        self.type = type
        super.init(nibName: "SortFilterSheetViewController", bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables
    private let sortStates : [SortState] = [.bestSeller, .latest, .cheapest, .expensive, .largestDiscount]
    private var selectedSort : SortState?
    var sortDelegate : SortProductDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        switch type {
        case .sort:
            guard let selectedSort = selectedSort else { return }
            sortDelegate?.sort(by: selectedSort)
        case .filter: break
        }
        dismiss(animated: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
    }
}

extension SortFilterSheetViewController {
    private func setupUI() {
        backgroundView.alpha = 0
        applyButton.roundedCorner(with: 8)
        contentView.roundedCorner(with: 16)
        tableView.delegate = self
        tableView.dataSource = self
        switch type {
        case .sort:
            tableView.register(
                SortItemViewCell.nib(),
                forCellReuseIdentifier: SortItemViewCell.identifier
            )
            tableViewHeight.constant = 5 * 50
        case .filter: break
//            //        tableView.register(
//            //            FilterItemViewCell.nib(),
//            //            forCellReuseIdentifier: FilterItemViewCell.identifier
//            //        )
        }
    }
}

// MARK: - TableView
extension SortFilterSheetViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch type {
        case .sort:
            return sortStates.count
        case .filter:
            return 4
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch type {
        case .sort:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SortItemViewCell.identifier,
                for: indexPath
            ) as? SortItemViewCell
            cell?.state = sortStates[indexPath.row].rawValue
            return cell ?? UITableViewCell()
        case .filter:
            return UITableViewCell()
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch type {
        case .sort:
            selectedSort = sortStates[indexPath.row]
        case .filter:
            break
        }
    }
    
}

