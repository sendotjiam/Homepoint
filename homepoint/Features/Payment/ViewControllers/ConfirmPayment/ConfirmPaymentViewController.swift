//
//  ConfirmPaymentViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 19/07/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

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
    @IBOutlet weak var copyAccButton: UIButton!
    @IBOutlet weak var copyTotalButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    private lazy var loaderView : UIView = {
        let view = UIView()
        view.roundedCorner(with: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private let loader = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: ColorCollection.primaryColor.value,
        padding: 0
    )
    
    // MARK: - Variables
    var data: TransactionDataModel?
    private var hasUploaded = false
    private let vm = ConfirmTransactionViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
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
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    
    @IBAction func copyAccButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = accountNumberLabel.text
    }
    
    @IBAction func copyTotalButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = totalPaymentLabel.text
    }
}

extension ConfirmPaymentViewController {
    private func setupUI() {
        deadlineStackView.roundedCorner(with: 8)
        confirmButton.roundedCorner(with: 8)
        accountInformationView.addBorder(width: 1, color: ColorCollection.blueLigthColor.value)
        confirmButton.isEnabled = false
        confirmButton.alpha = 0.5
        imagePicker.delegate = self
        reuploadButton.isHidden = true
        
        copyAccButton.roundedCorner(with: 6)
        copyTotalButton.roundedCorner(with: 6)
        copyAccButton.addBorder(width: 1, color: ColorCollection.yellowColor.value)
        copyTotalButton.addBorder(width: 1, color: ColorCollection.yellowColor.value)
        
        guard let data = data else { return }
        deadlineLabel.text = data.paymentDeadline.getDateTimeFromTimestamp()
        bankNameLabel.text = data.bank.bankName
        accountNumberLabel.text = data.bank.accountNumber
        accountNameLabel.text = data.bank.holderName
        totalPaymentLabel.text = Double(data.totalPrice).convertToCurrency()
    }
    
    private func setupAfterUpload() {
        confirmButton.alpha = 1
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

// MARK: - Binding
extension ConfirmPaymentViewController {
    private func bindViewModel() {
        vm.successUploadProof.subscribe { [weak self] in
            self?.handleSuccessUploadProof($0)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError($0)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleLoading($0)
        }.disposed(by: bag)
    }
    
    private func handleSuccessUploadProof(_ data : TransactionDataModel?) {
        let alert = createSimpleAlert("Sukses", "Sukses mengirimkan bukti pembayaran, mohon menunggu dalam waktu 1x24 jam", "OK") { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        present(alert, animated: true)
    }
    
    private func handleError(_ error : String?) {
        self.handleError(msg: error)
    }
    
    private func handleLoading(_ isLoading: Bool?) {
        guard let loading = isLoading
        else { return }
        DispatchQueue.main.async {
            self.showLoader(self.loaderView, self.loader, loading)
        }
    }
}

// MARK: - Confirmation Alert
extension ConfirmPaymentViewController : ConfirmationAlertDelegate {
    func didTapConfirm() {
        guard let id = data?.id else { return }
        if let data = mediaImageView.image?.jpegData(compressionQuality: 0.5) {
            if data.count >= 3000000 {
                let alert = createSimpleAlert("Gagal", "File melebihi ukuran upload", "Coba lagi")
                return
            }
            vm.uploadPaymentProof(id: id, imageData: data).disposed(by: bag)
        }
    }
}

// MARK: - Image Picker
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
