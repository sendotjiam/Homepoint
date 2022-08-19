//
//  BottomSheetViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import UIKit

protocol BottomSheetDelegate : AnyObject {
    func didSelectItem(type: SheetType, data : SheetItemCellModel)
}

enum SheetType {
    case shopLocations, paymentMethods
}

final class BottomSheetViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Variables
    var type : SheetType!
    weak var delegate : BottomSheetDelegate?
    
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
        case .paymentMethods:
            tableViewHeight.constant = (CGFloat(data.count * 20) + CGFloat(data.count * 32)) + 50
            titleLabel.text = "Pilih Metode Pembayaran"
        case .shopLocations:
            tableViewHeight.constant = (CGFloat(data.count * 20) + CGFloat(data.count * 32)) + 50
            titleLabel.text = "Pilih Lokasi Toko"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(type: type, data: data[indexPath.row])
        self.dismiss(animated: true)
    }
}
