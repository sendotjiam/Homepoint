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
    
    func setupView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.register(MenuViewCell.nib(), forCellReuseIdentifier: "MenuViewCell")
        homeTableView.register(WeeksViewCell.nib(), forCellReuseIdentifier: "WeeksViewCell")
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
            return 20
        case .bestOffer:
            return 20
        case .recommendation:
            return 20
        default:
            return 0.0001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0001
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
#warning("Ini jangan di pakein force cast !, pake ? aja")
#warning("Kalo pake ! bahaya, bisa force close")
#warning("Caranya kaya yg di case weeks")
        case .menu:
            let cell: MenuViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
            cell.selectionStyle = .none
            return cell
            
            #warning("cell.selectionstyle jangan di set di view controller, setnya di viewcellnya aja. Untuk ngebikin UI viewcell itu bukan kerjaannya view controller")
        case .banner:
            let cell: MenuViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
            cell.selectionStyle = .none
            return cell
        case .weeks:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeeksViewCell.identifier, for: indexPath) as? WeeksViewCell
            return cell ?? UITableViewCell()
        case .bestOffer:
            let cell: MenuViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
            cell.selectionStyle = .none
            return cell
        case .recommendation:
            let cell: MenuViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
}
