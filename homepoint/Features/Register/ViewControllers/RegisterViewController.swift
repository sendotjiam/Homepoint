//
//  RegisterViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 13/06/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fullnameTextField: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var iconClick = false
    let imageIcon = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addHideKeyboardGesture()
        setupKeyboardObserver()
        togglePassword()
    }

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
      let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
      view.endEditing(true)
    }

    @objc func showKeyboard(notification: NSNotification) {
      guard
        let info = notification.userInfo,
        let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
      else { return }

      let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
      scrollView.contentInset = contentInset
      scrollView.scrollIndicatorInsets = contentInset
    }

    @objc func hideKeyboard(notification: NSNotification) {
      scrollView.contentInset = .zero
      scrollView.scrollIndicatorInsets = .zero
    }

    func togglePassword() {
        imageIcon.image = UIImage(named: "ic_closeeye")

        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 21, height: 14)
        imageIcon.frame = CGRect(x: -5, y: -5, width: 24, height: 24)
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as? UIImageView

        if iconClick {
            iconClick = false
            tappedImage?.image = UIImage(named: "ic_openeye")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage?.image = UIImage(named: "ic_closeeye")
            passwordTextField.isSecureTextEntry = true
        }
    }


    // MARK: - Button
    @IBAction func didTapRegister(_ sender: UIButton) {
        navigationController?.pushViewController(ForgetPassViewController(), animated: true)
    }

    @IBAction func didTapGoggle(_ sender: UIButton) {
    }
}