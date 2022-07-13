//
//  AddressViewController.swift
//  homepoint
//
//  Created by Kartika on 11/06/22.
//

import UIKit

struct Address {
    var title: String
    var detail: String
    var isMain: Bool
}

class AddressViewController: UIViewController {
    @IBOutlet weak var noAddressView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAddressBtn: UIButton!
    
//    var dataAddress: [Address]? = nil
    
    var addressData: [Address]? = [
        Address(title: "Rumah", detail: "Jl. Jend. Sudriman no. 72, Jakarta Pusat Cisauk, Tanggerang Selatan, Banten", isMain: true),
        Address(title: "Alamat Kos", detail: "Jl. Jend. Sudriman no. 72, Jakarta Pusat Cisauk, Tanggerang Selatan, Banten", isMain: false)
    ]
    
    init() {
        super.init(nibName: Constants.AddressVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Alamat"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        if addressData == nil {
            noAddressView.isHidden = false
            tableView.isHidden = true
        } else {
            noAddressView.isHidden = true
            tableView.isHidden = false
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        tableView.register(AddressViewCell.nib(), forCellReuseIdentifier: "AddressViewCell")
        
        addAddressBtn.layer.cornerRadius = 8
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1).cgColor
    }
    
    @IBAction func didTapAddAddressButton(_ sender: Any) {
        let vc = AddAddressViewController()
        navigationController?.pushViewController(
            vc,
            animated: false
        )
    }
}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressViewCell", for: indexPath) as? AddressViewCell
        cell?.item = addressData?[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
