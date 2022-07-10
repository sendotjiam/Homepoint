//
//  BottomSheetViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

enum SheetType {
    case shopLocations, paymentMethods
}

enum PaymentMethodType {
    case BTN, BNI, BRI, BCA, MANDIRI
}

final class BottomSheetViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Variables
    var type : SheetType!
    
    /// Data with title and images/icons
    var data = [SheetItemCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BottomSheetViewController {
    private func setupUI() {
        containerView.roundedCorner(with: 8)
        
        switch type {
        case .paymentMethods, .shopLocations:
            tableViewHeight.constant = (CGFloat(data.count * 20) + CGFloat(data.count * 32)) + 50
        default:
            break
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            SheetItemViewCell.nib(),
            forCellReuseIdentifier: SheetItemViewCell.identifier
        )
    }
}

extension BottomSheetViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .shopLocations, .paymentMethods:
            return data.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .shopLocations, .paymentMethods:
            let cell = tableView.dequeueReusableCell(withIdentifier: SheetItemViewCell.identifier, for: indexPath) as? SheetItemViewCell
            cell?.data = data[indexPath.row]
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
