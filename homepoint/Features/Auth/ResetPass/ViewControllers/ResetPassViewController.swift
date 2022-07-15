//
//  ResetPassViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 14/07/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

final class ResetPassViewController: UIViewController {


    // MARK: - Outlets
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var errorPassLabel: UILabel!
    @IBOutlet weak var errorConfirmLabel: UILabel!
    @IBOutlet weak var viewPasswordTF: UIView!
    @IBOutlet weak var viewConfirmPassTF: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    var iconClick = false
    let imageIcon = UIImageView()

    // MARK: - Variables
//    private let vm :
//    private let bag = DisposeBag()
    private var isPasswordError = true
    private var isConfirmError = true

    private let loader = NVActivityIndicatorView (
        frame: .zero,
        type: .circleStrokeSpin,
        color: ColorCollection.primaryColor.value,
        padding: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        addHideKeyboardGesture()
        setupKeyboardObserver()

        setupUI()
        bindViewModel()
    }


    // MARK: - Actions
    @IBAction func didTapSaveBtn(_ sender: Any) {

    }

    @IBAction func passwordChanged(_ sender: Any) {

    }

    @IBAction func confirmChanged(_ sender: Any) {
    }


}

extension ResetPassViewController {
    private func setupUI() {
        togglePassword()
        setupTextField()

        errorPassLabel.isHidden = true
        errorConfirmLabel.isHidden = true
        saveBtn.isEnabled = false
    }

    private func bindViewModel() {

    }

    private func handleSuccessReset() {

    }

    private func togglePassword() {
        imageIcon.image = UIImage(named: "ic_eye.close")

        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 21, height: 14)
        imageIcon.frame = CGRect(x: -6, y: -5, width: 24, height: 24)
        passwordTF.rightView = contentView
        passwordTF.rightViewMode = .always
        confirmPasswordTF.rightView = contentView
        confirmPasswordTF.rightViewMode = .always

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:))
        )
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupTextField(){
        [passwordTF, confirmPasswordTF].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(validateText), for: .editingChanged)
        }
    }

    func checkValidForm(){
        if (isPasswordError || isConfirmError) {
            saveBtn.isEnabled = false
        } else {
            saveBtn.isEnabled = true
        }
    }

    func invalidPassword(_ value: String) -> String? {
        if containsUpperCase(value)
        {
            return "Password minimal ada 1 huruf kapital"
        }
        if containsLowerCase(value)
        {
        return "Password minimal ada 1 huruf kecil"
        }
        if containsDigit(value)
        {
            return "Password minimal ada 1 angka"
        }
        if value.count < 8 {
            return "Password minimal 8 karakter"
        }
        return nil
    }

    func containsDigit(_ value: String) -> Bool {
        let regularExpression = ".*[0-9].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }

    func containsLowerCase(_ value: String) -> Bool {
        let regularExpression = ".*[a-z].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }

    func containsUpperCase(_ value: String) -> Bool {
        let regularExpression = ".*[A-Z].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }

}

// MARK: - Objc Func & Keyboard
extension ResetPassViewController {
    func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showKeyboard(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideKeyboard(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func addHideKeyboardGesture() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func showKeyboard(notification: NSNotification) {
        guard
            let info = notification.userInfo,
            let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
                .cgRectValue
                .size
        else { return }

        let contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardSize.height,
            right: 0
        )
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc func hideKeyboard(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        if iconClick {
            iconClick = false
            tappedImage?.image = UIImage(named: "ic_eye")
            passwordTF.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage?.image = UIImage(named: "ic_eye.close")
            passwordTF.isSecureTextEntry = true
        }
    }

    @objc func validateText(sender: UITextField) {
//        if sender == emailTextField {
//            if let email = emailTextField.text {
//                clearButton.isHidden = !(email.count > 0)
//            }
//        }
    }

}
extension ResetPassViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case passwordTF:
            viewPasswordTF.backgroundColor = .white
            viewPasswordTF.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        default :
            viewConfirmPassTF.backgroundColor = .white
            viewConfirmPassTF.addBorder(width: 1, color: ColorCollection.primaryColor.value)

        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case passwordTF:
            viewPasswordTF.backgroundColor = ColorCollection.lightGreyColor.value
            viewPasswordTF.addBorder(width: 0, color: ColorCollection.lightGreyColor.value)
        default :
            viewConfirmPassTF.backgroundColor = ColorCollection.lightGreyColor.value
            viewConfirmPassTF.addBorder(width: 0, color: ColorCollection.lightGreyColor.value)
        }
    }
}
