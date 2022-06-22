//
//  HomeViewController.swift
//  homepoint
//
//  Created by Kartika on 02/06/22.
//

import UIKit
import RxSwift
import SkeletonView

class HomeViewController: UIViewController {
    
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
    
    private var latestProducts = [ProductDataModel]()
    private var discountProducts = [ProductDataModel]()
    
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
        
        homeTableView.sectionHeaderHeight = 0.00001
        homeTableView.sectionFooterHeight = 0.00001

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        floatingView.addGestureRecognizer(gesture)
        floatingView.layer.shadowOffset = CGSize(width: 1,
                                          height: 1)
        floatingView.layer.shadowRadius = 5
        floatingView.layer.shadowOpacity = 0.5
    }
    
    private func bindViewModel() {
        vm.successAllProducts.subscribe {
            self.handleSucccessAllProducts($0.element)
        }.disposed(by: bag)
        vm.successDiscountProducts.subscribe {
            self.handleSucccessDiscountProducts($0.element)
        }.disposed(by: bag)
        vm.successLatestProducts.subscribe {
            self.handleSucccessLatestProducts($0.element)
        }.disposed(by: bag)
        vm.isLoading.subscribe { self.handleLoading($0.element) }.disposed(by: bag)
        vm.error.subscribe { print($0.element!) }.disposed(by: bag)
    }
    
    private func handleSucccessDiscountProducts(
        _ products : [ProductDataModel]?
    ) {
        guard let products = products else { return }
        discountProducts = products
        reloadTableView()
    }
    
    private func handleSucccessLatestProducts(
        _ products : [ProductDataModel]?
    ) {
        guard let products = products else { return }
        latestProducts = products
        reloadTableView()
    }
    
    private func handleSucccessAllProducts(
        _ products : [ProductDataModel]?
    ) {
    }
    
    private func handleError() {
        
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let isLoading = isLoading else { return }
        if !isLoading {
            DispatchQueue.main.async {
                self.view.stopShimmer()
            }
        }
    }
}

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

    @objc private func didTapView() {
        let urlWhats = "whatsapp://send?phone=6282114742197&text=Halo%20Homepoint%F0%9F%99%8C%F0%9F%8F%BB%0AAda%20yang%20ingin%20Saya%20tanyakan%2C%20nih!%0A%0A(Tuliskan%20pertanyaanmu%20disini%20ya!)"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL) {
                        UIApplication.shared.open(whatsappURL)
                    } else {
                        if let url = URL(string: "https://api.whatsapp.com/send?phone=6282114742197&text=Halo%20Homepoint%F0%9F%99%8C%F0%9F%8F%BB%0AAda%20yang%20ingin%20Saya%20tanyakan%2C%20nih!%0A%0A(Tuliskan%20pertanyaanmu%20disini%20ya!)") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
       }
}

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
        case .recommendation:
            guard let cellRecommendation = cell as? RecommendationViewCell
            else { return nil }
            cellRecommendation.dataList = latestProducts
            cellRecommendation.didSelectItem = { [weak self] in
                let vc = DetailViewController($0)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellRecommendation as? T
        case .bestOffer:
            guard let cellOffer = cell as? BestOfferViewCell
            else { return nil }
            cellOffer.dataList = discountProducts
            cellOffer.didSelectItem = { [weak self] in
                let vc = DetailViewController($0)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellOffer as? T
        default: return cell
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.homeTableView.reloadData()
        }
    }
}
