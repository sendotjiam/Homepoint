//
//  ConfirmPaymentViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 19/07/22.
//

import Alamofire
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
    @IBOutlet weak var copyAccButton: UIButton!
    @IBOutlet weak var copyTotalButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Variables
    var data: TransactionDataModel?
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
        deadlineLabel.text = data.paymentDeadline
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

// MARK: - Confirmation Alert
extension ConfirmPaymentViewController : ConfirmationAlertDelegate {
    func didTapConfirm() {
        guard let data = data else { return }
//        let urlString = Constants.BaseUrl + "api/v1/transaction/payment-confirmation/\(data.id)"
        guard let url = URL(string: Constants.BaseUrl + "api/v1/transaction/payment-confirmation/\(data.id)") else { return }
//        var urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        let headers : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        urlRequest.httpMethod = "PUT"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy-hh-mm-ss"
//        let dateString = dateFormatter.string(from: Date())
        if let data = mediaImageView.image?.jpegData(compressionQuality: 0.5) {
//            AF.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(Data("Coming from iPhone Sim".utf8), withName: "postBody")
//                multipartFormData.append(data, withName: "image", fileName: "uploads"+dateString+".png", mimeType: "image/jpg")
//            },to: urlString,
//                      method: .put,
//                      headers: headers
//            ) .uploadProgress(queue: .main, closure: { progress in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            }).responseJSON(completionHandler: { data in
//                print("upload finished: \(data)")
//            }).response { (response) in
//                switch response.result {
//                case .success(let resut):
//                    print("upload success result: \(String(describing: resut))")
//                case .failure(let err):
//                    print("upload err: \(err)")
//                }
//            }
            
            AF.upload(multipartFormData: { multiPart in
                multiPart.append(data, withName: "file", fileName: "file.png", mimeType: "image/png")
            }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                            print("Success!")
                            print(dictionary)
                        }
                        catch {
                            print("catch error")
                        }
                        break
                    case .failure(_):
                        print("failure")
                        break
                    }
                })

                      
//                      to: url as! URLConvertible, method: .put, headers: headers).responseJSON { resp in
//                print("resp is \(resp)")
//            }.resume()
//                      with: urlRequest).uploadProgress(queue: .main, closure: { progress in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            }).response { data in
//                print(data.data, "DAT")
//                switch data.result {
//                case .success(_):
//                    print("S")
//                case .failure(let err):
//                    print(err)
//                }
//                print(data.value, "VAL")
//                print(data.response, "RES")
//                print(data.error, "ERR")
//            }
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
