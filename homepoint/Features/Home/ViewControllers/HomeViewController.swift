//
//  HomeViewController.swift
//  homepoint
//
//  Created by Kartika on 02/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .defaultNav)
    }
    
    func setupView() {
//        homeTableView.roundedCorner(with: 8)
        homeTableView.layer.cornerRadius = 10
        homeTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.register(MenuViewCell.nib(), forCellReuseIdentifier: MenuViewCell.identifier)
        homeTableView.register(BannerViewCell.nib(), forCellReuseIdentifier: BannerViewCell.identifier)
        homeTableView.register(WeeksViewCell.nib(), forCellReuseIdentifier: WeeksViewCell.identifier)
        homeTableView.register(BestOfferViewCell.nib(), forCellReuseIdentifier: BestOfferViewCell.identifier)
        homeTableView.register(RecommendationViewCell.nib(), forCellReuseIdentifier: RecommendationViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .menu:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuViewCell.identifier, for: indexPath) as? MenuViewCell
            return cell ?? UITableViewCell()
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerViewCell.identifier, for: indexPath) as? BannerViewCell
            return cell ?? UITableViewCell()
        case .weeks:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeeksViewCell.identifier, for: indexPath) as? WeeksViewCell
            return cell ?? UITableViewCell()
        case .bestOffer:
            let cell = tableView.dequeueReusableCell(withIdentifier: BestOfferViewCell.identifier, for: indexPath) as? BestOfferViewCell
            return cell ?? UITableViewCell()
        case .recommendation:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationViewCell.identifier, for: indexPath) as? RecommendationViewCell
            return cell ?? UITableViewCell()
        }
    }
}
