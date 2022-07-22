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
    @IBOutlet weak var mediaImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Variables
    private var hasUploaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backAndTitle(title: "Konfirmasi Pembayaran"))
    }
    
    @IBAction func reuploadButtonTapped(_ sender: Any) {
        showImagePickerOptions()
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        showImagePickerOptions()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let vc = ConfirmationAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
}

extension ConfirmPaymentViewController {
    private func setupUI() {
        deadlineStackView.roundedCorner(with: 8)
        confirmButton.roundedCorner(with: 8)
        accountInformationView.addBorder(width: 1, color: ColorCollection.blueLigthColor.value)
        imagePicker.delegate = self
        confirmButton.isEnabled = false
    }
    
    private func setupAfterUpload() {
        if !hasUploaded { hasUploaded = true }
        if hasUploaded {
            // Disable upload button
            uploadButton.isHidden = true
            uploadButton.isEnabled = false
            
            reuploadButton.isHidden = false
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = ColorCollection.yellowColor.value
        } else {
            confirmButton.isEnabled = false
            confirmButton.backgroundColor = ColorCollection.grayTextColor.value
        }
    }
    
    private func showImagePickerOptions() {
        let alert = UIAlertController(
            title: "Pilih Foto",
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(
            UIAlertAction(
                title: "Library",
                style: .default,
                handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true)
                }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { [weak self] _ in
                    self?.dismiss(animated: true)
                }
            )
        )
        self.present(alert, animated: true)
    }
}

extension ConfirmPaymentViewController :
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let pickedImage = info[.originalImage] as? UIImage {
            mediaImageView.contentMode = .scaleAspectFit
            mediaImageView.image = pickedImage
            mediaImageView.backgroundColor = .clear
        }
        setupAfterUpload()
        dismiss(animated: true)
    }
}
