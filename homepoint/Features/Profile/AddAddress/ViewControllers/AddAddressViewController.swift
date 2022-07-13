//
//  AddAddressViewController.swift
//  homepoint
//
//  Created by Kartika on 11/06/22.
//

import UIKit

enum AddressList {
    case provinsi, kabupaten, kecamatan, kelurahan, kodePos
}

class AddAddressViewController: UIViewController {
    @IBOutlet weak var checkButton: UIButton!
    var isChecked: Bool = false
    
    // Provinsi
    @IBOutlet weak var provinsiView: UIView!
    @IBOutlet weak var provinsiLabel: UILabel!
    @IBOutlet weak var provinsiIcon: UIImageView!
    
    // Kabubaten/Kota
    @IBOutlet weak var kabupatenView: UIView!
    @IBOutlet weak var kabupatenLabel: UILabel!
    @IBOutlet weak var kabupatenIcon: UIImageView!
    
    // Kecamatan
    @IBOutlet weak var kecamatanView: UIView!
    @IBOutlet weak var kecamatanLabel: UILabel!
    @IBOutlet weak var kecamatanIcon: UIImageView!
    
    // Kelurahan
    @IBOutlet weak var kelurahanView: UIView!
    @IBOutlet weak var kelurahanLabel: UILabel!
    @IBOutlet weak var kelurahanIcon: UIImageView!
    
    // Kode Pos
    @IBOutlet weak var kodePosView: UIView!
    @IBOutlet weak var kodePosLabel: UILabel!
    @IBOutlet weak var kodePosIcon: UIImageView!
    
    static let identifier = "AddAddressViewController"
    
    init() {
        super.init(nibName: Constants.AddAddressVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Tambah Alamat"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let provinsiTap = UITapGestureRecognizer(target: self, action: #selector(provinsiTapped))
        provinsiView.isUserInteractionEnabled = true
        provinsiView.addGestureRecognizer(provinsiTap)
        
        let kabupatenTap = UITapGestureRecognizer(target: self, action: #selector(kabupatenTapped))
        kabupatenView.isUserInteractionEnabled = true
        kabupatenView.addGestureRecognizer(kabupatenTap)
        
        let kecamatanTap = UITapGestureRecognizer(target: self, action: #selector(kecamatanTapped))
        kecamatanView.isUserInteractionEnabled = true
        kecamatanView.addGestureRecognizer(kecamatanTap)
        
        let kelurahanTap = UITapGestureRecognizer(target: self, action: #selector(kelurahanTapped))
        kelurahanView.isUserInteractionEnabled = true
        kelurahanView.addGestureRecognizer(kelurahanTap)
        
        let kodePosTap = UITapGestureRecognizer(target: self, action: #selector(kodePosTapped))
        kodePosView.isUserInteractionEnabled = true
        kodePosView.addGestureRecognizer(kodePosTap)
    }
    
    @objc func provinsiTapped() {
        let vc = DropdownViewController(type: AddressList.provinsi, delegate: self)
        vc.data = ["Jakut", "Jaksel", "Jakpus", "Jaktim", "Jakbar", "Bekasi", "Banten", "Bogor"]
        let navigationVC: UINavigationController = UINavigationController(rootViewController: vc)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func kabupatenTapped() {
        let vc = DropdownViewController(type: AddressList.kabupaten, delegate: self)
        vc.data = ["Jakut", "Jaksel", "Jakpus", "Jaktim", "Jakbar", "Bekasi", "Banten", "Bogor"]
        let navigationVC: UINavigationController = UINavigationController(rootViewController: vc)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func kecamatanTapped() {
        let vc = DropdownViewController(type: AddressList.kecamatan, delegate: self)
        vc.data = ["Jakut", "Jaksel", "Jakpus", "Jaktim", "Jakbar", "Bekasi", "Banten", "Bogor"]
        let navigationVC: UINavigationController = UINavigationController(rootViewController: vc)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func kelurahanTapped() {
        let vc = DropdownViewController(type: AddressList.kelurahan, delegate: self)
        vc.data = ["Jakut", "Jaksel", "Jakpus", "Jaktim", "Jakbar", "Bekasi", "Banten", "Bogor"]
        let navigationVC: UINavigationController = UINavigationController(rootViewController: vc)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func kodePosTapped() {
        let vc = DropdownViewController(type: AddressList.kodePos, delegate: self)
        vc.data = ["Jakut", "Jaksel", "Jakpus", "Jaktim", "Jakbar", "Bekasi", "Banten", "Bogor"]
        let navigationVC: UINavigationController = UINavigationController(rootViewController: vc)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @IBAction func checkedDidTap(_ sender: Any) {
        if !isChecked {
            checkButton.isSelected = true
            isChecked = true
        } else {
            checkButton.isSelected = false
            isChecked = false
        }
    }
}

extension AddAddressViewController: DropdownViewControllerDelegate {
    func selectedValue(type: AddressList, value: String) {
        switch type {
        case .provinsi:
            provinsiLabel.text = value
        case .kabupaten:
            kabupatenLabel.text = value
        case .kecamatan:
            kecamatanLabel.text = value
        case .kelurahan:
            kelurahanLabel.text = value
        case .kodePos:
            kodePosLabel.text = value
        }
    }
}
