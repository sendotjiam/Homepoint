//
//  ConfirmPaymentViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 19/07/22.
//

import UIKit

final class ConfirmPaymentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var deadlineStackView: UIStackView!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var accountInformationView: UIView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    @IBOutlet weak var reuploadButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Konfirmasi Pembayaran"))
    }
    
    @IBAction func reuploadButtonTapped(_ sender: Any) {
        print("REUPLOAD")
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        print("UPLOAD")
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let vc = InformationAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
}

extension ConfirmPaymentViewController {
    private func setupUI() {
        deadlineStackView.roundedCorner(with: 8)
        confirmButton.roundedCorner(with: 8)
        accountInformationView.addBorder(width: 1, color: ColorCollection.blueLigthColor.value)
            
        if uploadButton.image(for: .normal) == nil {
            reuploadButton.isHidden = true
//            confirmButton.isEnabled = false
//            confirmButton.backgroundColor = ColorCollection.grayTextColor.value
        }
    }
}
