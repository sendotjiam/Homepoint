//
//  DropdownViewController.swift
//  homepoint
//
//  Created by Kartika on 26/06/22.
//

import UIKit

protocol DropdownViewControllerDelegate {
    func selectedValue(type: AddressList, value: String)
}

class DropdownViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneLabel: UILabel!
    
    var delegate: DropdownViewControllerDelegate?
    var data: [String]?
    var type: AddressList
    var value: String = "Tidak ada data terpilih"
    
    init(type: AddressList, delegate: DropdownViewControllerDelegate) {
        self.type = type
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DropdownViewCell.nib(), forCellReuseIdentifier: "DropdownViewCell")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        doneLabel.isUserInteractionEnabled = true
        doneLabel.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        delegate?.selectedValue(type: type, value: value)
        self.dismiss(animated: true)
    }
}

extension DropdownViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.value = data?[indexPath.row] ?? "Data tidak ditemukan"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownViewCell", for: indexPath) as? DropdownViewCell
        cell?.value = data?[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
