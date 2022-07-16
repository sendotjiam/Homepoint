//
//  SortFilterSheetViewController.swift
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
    private let sortStates : [SortState] = [
        .bestSeller, .latest, .cheapest, .expensive, .largestDiscount
    ]
    private var selectedSort : SortState?
    var sortDelegate : SortProductDelegate?
    
    private let filterSections : [FilterSection] = [
        .price, .rating, .brand, .color
    ]
    private let defaults = UserDefaults.standard
    var brands = [String]()
    var colors = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        switch type {
        case .sort:
            if selectedSort == nil {
                dismiss(animated: true)
            }
            sortDelegate?.sort(by: selectedSort)
        case .filter: break
        }
        dismiss(animated: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        switch type {
        case .sort:
            sortDelegate?.sort(by: nil)
            resetSortData()
        case .filter:
            break
        }
        dismiss(animated: true)
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
            titleLabel.text = "Urutkan"
            tableView.register(
                SortItemViewCell.nib(),
                forCellReuseIdentifier: SortItemViewCell.identifier
            )
            tableViewHeight.constant = 5 * 50
        case .filter:
            titleLabel.text = "Filter"
            tableView.register(
                FilterPriceViewCell.nib(),
                forCellReuseIdentifier: FilterPriceViewCell.identifier
            )
            tableView.register(
                FilterRatingViewCell.nib(),
                forCellReuseIdentifier: FilterRatingViewCell.identifier
            )
            tableView.register(
                FilterBrandHeaderViewCell.nib(),
                forCellReuseIdentifier: FilterBrandHeaderViewCell.identifier
            )
            tableView.register(
                FilterBrandListViewCell.nib(),
                forCellReuseIdentifier: FilterBrandListViewCell.identifier
            )
            tableView.register(
                FilterColorViewCell.nib(),
                forCellReuseIdentifier: FilterColorViewCell.identifier
            )
        }
    }

    private func resetSortData() {
        
    }
}

// MARK: - TableView
extension SortFilterSheetViewController :
    UITableViewDelegate,
    UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch type {
        case .sort: return 1
        case .filter: return filterSections.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch type {
        case .sort:
            return sortStates.count
        case .filter:
            return filterSections[section] == .brand ? 2 : 1
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
            var cell : 
            UITableViewCell?
            switch filterSections[indexPath.section] {
            case .price:
                cell = generateCell(FilterPriceViewCell.identifier, indexPath)
            case .brand:
                switch indexPath.row {
                case 0:
                    cell = generateCell(FilterBrandHeaderViewCell.identifier, indexPath)
                default:
                    cell = generateCell(FilterBrandListViewCell.identifier, indexPath)
                }
            case .color:
                cell = generateCell(FilterColorViewCell.identifier, indexPath)
            case .rating:
                cell = generateCell(FilterRatingViewCell.identifier, indexPath)
            default:
                return UITableViewCell()
            }
            return cell ?? UITableViewCell()
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
 
    private func generateCell<T : UITableViewCell>(
        _ id: String,
        _ indexPath: IndexPath
    ) -> T? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: id,
            for: indexPath
        ) as? T
        switch filterSections[indexPath.section] {
        case .brand:
            if indexPath.row != 0 {
                guard let cell = cell as? FilterBrandListViewCell
                else { return nil }
                cell.brands = brands
                return cell as? T
            } else { return cell }
        case .color:
            guard let cell = cell as? FilterColorViewCell
            else { return nil }
            var cleanColors = Set(colors.map { $0 })
            cell.colors = cleanColors
            return cell as? T
        default: return cell
        }
        return cell
    }
}

