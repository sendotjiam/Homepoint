//
//  LastForgetPassViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 14/06/22.
//

import UIKit

final class LastForgetPassViewController: UIViewController {
    @IBOutlet weak var resendLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .back)
    }

    @IBAction func didTapLogin(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

extension LastForgetPassViewController {
    private func setupUI() {
        setupResendLabel()
    }

    @objc func didTapResend(recognizer: UITapGestureRecognizer){
        if recognizer.didTapAttributedTextInLabel(label: resendLabel, inRange: NSRange(location: 22, length: 11)) {
            // resend reset password
        }
}

    func setupResendLabel(){
        let attributeString = NSMutableAttributedString(string: "Belum mendapat email? Kirim ulang")

        attributeString.addAttributes([.font: UIFont.systemFont(ofSize: 14.0)], range: NSRange(location: 0, length: attributeString.length))

        attributeString.addAttributes([
            .font: UIFont.systemFont(ofSize: 16.0,weight: .semibold),
            .foregroundColor: ColorCollection.primaryColor.value
        ], range: NSRange(location: 22, length: 11))

        resendLabel.attributedText = attributeString
        resendLabel.isUserInteractionEnabled = true
        resendLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResend)))
    }
}


