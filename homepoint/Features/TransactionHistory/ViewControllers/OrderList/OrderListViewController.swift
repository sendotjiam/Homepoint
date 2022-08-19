//
//  HistoryViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit
import SkeletonView
import RxSwift

final class OrderListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notLoginView: NotLoginView!
    @IBOutlet weak var emptyView: UIView!
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Data
    private enum SectionType {
        case orderFilter, orderList
    }
    private let sections : [SectionType] = [
        .orderFilter, .orderList
    ]
    private var orderListData = [OrderListItemCellModel]()
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: Constants.OrderListVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables
    private let vm = OrderListViewModel()
    private let bag = DisposeBag()
    private var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        
        if userId != "" {
            vm.getAllTransactions(userId: userId).disposed(by: bag)
        }
        
        self.addNotificationCenter(
            label: "reload_view",
            selector: #selector(reloadView)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .titleAndHistory(title: "Daftar Pesanan Aktif"))
    }
    
    deinit {
        removeNotificationCenter()
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
        
        notLoginView.delegate = self
        notLoginView.isHidden = isUserLoggedIn()
        emptyView.isHidden = true
        
        userId = getUserId() ?? ""
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        vm.getAllTransactions(userId: userId).disposed(by: bag)
        view.showShimmer()
    }
    
    @objc func reloadView() {
        notLoginView.isHidden = true
        // call API
    }
}

// MARK: - Binding
extension OrderListViewController {
    private func bindViewModel() {
        vm.successGetAllTransactions.subscribe { [weak self] in
            self?.handleSuccessGetAllTransactions($0)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError($0.element)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0.element)
        }.disposed(by: bag)
    }
    
    private func handleSuccessGetAllTransactions(_ data: [TransactionDataModel]?) {
        guard let data = data else { return }
        var orders = [OrderListItemCellModel]()
        data.forEach {
            let firstProduct = $0.transactionItems.first?.products.first
            if let firstProduct = firstProduct,
               let images = firstProduct.productImages.first {
                let order = OrderListItemCellModel(
                    title: firstProduct.name,
                    imageUrl: images.image,
                    date: $0.createdAt,
                    status: .unconfirm,
                    amount: $0.transactionItems.count,
                    price: $0.totalPrice
                )
                orders.append(order)
            }
        }
        self.orderListData = orders
        tableView.reload()
    }
    
    private func handleError(_ error : String?) {
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let loading = isLoading
        else { return }
        DispatchQueue.main.async {
            if !loading {
                self.refreshControl.endRefreshing()
                self.view.stopShimmer()
            }
        }
    }
}

extension OrderListViewController : LoginDelegate {
    func successLogin() {
        reloadView()
    }
}

// MARK: - NavigationBar
extension OrderListViewController {
    override func historyTapped(sender: UIBarButtonItem) {
        if isUserLoggedIn() {
            navigationController?
                .pushViewController(
                    HistoryViewController(),
                    animated: true
                )
        }
    }
}

extension OrderListViewController : SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        sections.count
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return sections[section] == .orderFilter ? 1 : 6
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        switch sections[indexPath.section] {
        case .orderFilter:
            return OrderFilterViewCell.identifier
        case .orderList:
            return OrderListViewCell.identifier
        }
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
