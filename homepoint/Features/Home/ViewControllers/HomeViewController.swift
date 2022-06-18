//
//  HomeViewController.swift
//  homepoint
//
//  Created by Kartika on 02/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homeTableView: UITableView!
    
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
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: Constants.HomeVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    }
}

extension HomeViewController:
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let view = UIView()
        let label = UILabel(
            frame: CGRect(
                x: 16, y: 0,
                width: tableView.frame.width - 32,
                height: 20
            )
        )
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        switch sections[section] {
        case .weeks:
            label.text = "Kitchenware Weeks"
        case .bestOffer:
            label.text = "Best Offer By One Get One"
        case .recommendation:
            label.text = "Rekomendasi untukmu"
        default:
            label.text = ""
        }
        
        view.addSubview(label)
        view.backgroundColor = .white
        return view
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        switch sections[section] {
        case .weeks:
            return 30
        case .bestOffer:
            return 30
        case .recommendation:
            return 30
        default:
            return 0.0001
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        20
    }
    
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
            cellRecommendation.didSelectItem = { [weak self] id in
                let vc = DetailViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellRecommendation as? T
        case .bestOffer:
            guard let cellOffer = cell as? BestOfferViewCell
            else { return nil }
            cellOffer.didSelectItem = { [weak self] id in
                let vc = DetailViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cellOffer as? T
        default: return cell
        }
    }
}
