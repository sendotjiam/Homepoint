//
//  HomeViewController.swift
//  homepoint
//
//  Created by Kartika on 02/06/22.
//

import UIKit
import RxSwift
import SkeletonView

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var floatingView: UIView!

    // MARK: - Variables
    private enum SectionType {
        case menu, banner, weeks, bestOffer, recommendation
    }
    private var sections: [SectionType] = [
        .menu,
        .banner,
        .weeks,
        .bestOffer,
        .recommendation
    ]
    private let vm : HomeViewModel = HomeViewModel()
    private let bag = DisposeBag()
    
    private var subCategories = [ProductSubCategoryModel]()
    private var latestProducts = [ProductDataModel]()
    private var discountProducts = [ProductDataModel]()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: Constants.HomeVC, bundle: nil)
        vm.getProducts()
        view.showShimmer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .defaultNav)
    }
}


extension HomeViewController {
    func setupView() {
        homeTableView.layer.cornerRadius = 14
        homeTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        homeTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.register(
            MenuViewCell.nib(),
            forCellReuseIdentifier: MenuViewCell.identifier
        )
        homeTableView.register(
            BannerViewCell.nib(),
            forCellReuseIdentifier: BannerViewCell.identifier
        )
        homeTableView.register(
            WeeksViewCell.nib(),
            forCellReuseIdentifier: WeeksViewCell.identifier
        )
        homeTableView.register(
            BestOfferViewCell.nib(),
            forCellReuseIdentifier: BestOfferViewCell.identifier
        )
        homeTableView.register(
            RecommendationViewCell.nib(),
            forCellReuseIdentifier: RecommendationViewCell.identifier
        )
        
        homeTableView.sectionHeaderHeight = 0.000001
        homeTableView.sectionFooterHeight = 0.000001

        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapFloatingButton)
        )
        floatingView.addGestureRecognizer(gesture)
        floatingView.layer.shadowOffset = CGSize(width: 1,
                                          height: 1)
        floatingView.layer.shadowRadius = 5
        floatingView.layer.shadowOpacity = 0.5
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        homeTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        vm.getProducts()
        view.showShimmer()
    }
    
    @objc private func didTapFloatingButton() {
        let urlWhats = Constants.UrlWhatsappApp
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL)
                } else {
                    if let url = URL(string: Constants.UrlWhatsappWeb) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }
}

// MARK: - Binding VM
extension HomeViewController {
    private func bindViewModel() {
        vm.successSubCategories.subscribe { [weak self] in
            self?.handleSuccessSubCategories($0.element)
        }.disposed(by: bag)
        vm.successDiscountProducts.subscribe { [weak self] in
            self?.handleSucccessDiscountProducts($0.element)
        }.disposed(by: bag)
        vm.successLatestProducts.subscribe { [weak self] in
            self?.handleSucccessLatestProducts($0.element)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0.element)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError($0.element)
        }.disposed(by: bag)
    }
    
    private func handleSuccessSubCategories(
        _ subCategories : [ProductSubCategoryModel]?
    ) {
        guard let subCategories = subCategories else { return }
        self.subCategories = subCategories
    }
    
    private func handleSucccessDiscountProducts(
        _ products : [ProductDataModel]?
    ) {
        guard let products = products else { return }
        discountProducts = products
    }
    
    private func handleSucccessLatestProducts(
        _ products : [ProductDataModel]?
    ) {
        guard let products = products else { return }
        latestProducts = products
    }
    
    private func handleError(_ error : String?) {
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let isLoading = isLoading else { return }
        if !isLoading {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.homeTableView.reload()
                self.view.stopShimmer()
            }
        }
    }
}

// MARK: - TableView
extension HomeViewController:
    UITableViewDelegate,
    UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        var cell : UITableViewCell?
        switch sections[indexPath.section] {
        case .menu:
            cell = generateCell(MenuViewCell.identifier, indexPath)
        case .banner:
            cell = generateCell(BannerViewCell.identifier, indexPath)
        case .weeks:
            cell = generateCell(WeeksViewCell.identifier, indexPath)
        case .bestOffer:
            cell = generateCell(BestOfferViewCell.identifier, indexPath)
        case .recommendation:
            cell = generateCell(RecommendationViewCell.identifier, indexPath)
        }
        return cell ?? UITableViewCell()
    }
    
    private func generateCell<T : UITableViewCell>(
        _ id: String,
        _ indexPath: IndexPath
    ) -> T? {
        let cell = homeTableView.dequeueReusableCell(
            withIdentifier: id,
            for: indexPath
        ) as? T
        switch sections[indexPath.section] {
        case .menu:
            guard let cellMenu = cell as? MenuViewCell else { return nil }
            cellMenu.subCategories = subCategories
            cellMenu.didSelectItem = { [weak self] in
                let vc = SearchViewController("")
                vc.searchParams["Product subcategory"] = $0
                vc.search()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellMenu as? T
        case .weeks:
            guard let cellWeeks = cell as? WeeksViewCell else { return nil }
            cellWeeks.didSelectItem = { [weak self] in
                let vc = SearchViewController("")
                vc.searchParams["Description"] = $0
                vc.search()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellWeeks as? T
        case .recommendation:
            guard let cellRecommendation = cell as? RecommendationViewCell
            else { return nil }
            cellRecommendation.dataList = latestProducts
            cellRecommendation.didViewMore = { [weak self] in
                let vc = SearchViewController("")
                vc.type = .recommendation
                vc.search()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cellRecommendation.didSelectItem = { [weak self] in
                let vc = DetailViewController($0)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellRecommendation as? T
        case .bestOffer:
            guard let cellOffer = cell as? BestOfferViewCell
            else { return nil }
            cellOffer.dataList = discountProducts
            cellOffer.didViewMore = { [weak self] in
                let vc = SearchViewController("")
                vc.type = .bestOffer
                vc.search()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cellOffer.didSelectItem = { [weak self] in
                let vc = DetailViewController($0)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellOffer as? T
        default: return cell
        }
    }
}

// MARK: - Skeleton
extension HomeViewController : SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        sections.count
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch sections[indexPath.section] {
        case .menu:
            return MenuViewCell.identifier
        case .banner:
            return BannerViewCell.identifier
        case .weeks:
            return WeeksViewCell.identifier
        case .bestOffer:
            return BestOfferViewCell.identifier
        case .recommendation:
            return RecommendationViewCell.identifier
        }
    }
}
