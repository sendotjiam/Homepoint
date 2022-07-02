//
//  RegisterViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 13/06/22.
//

import UIKit
import RxSwift

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var viewNameTextField: UIView!
    @IBOutlet weak var viewEmailTextField: UIView!
    @IBOutlet weak var viewPasswordTextField: UIView!
    @IBOutlet weak var nameClearBtn: UIButton!
    @IBOutlet weak var emailClearBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!

    var iconClick = false
    let imageIcon = UIImageView()
    
    // MARK: - Variables
    private let vm = RegisterViewModel()
    private let bag = DisposeBag()
    private var isNameError = true
    private var isEmailError = true
    private var isPasswordError = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHideKeyboardGesture()
        setupKeyboardObserver()
        setupUI()
        bindViewModel()

        nameError.isHidden = true
        emailError.isHidden = true
        passwordError.isHidden = true
        registerBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .back)
    }
    
    // MARK: - Button
    @IBAction func didTapRegister(_ sender: UIButton) {
        guard let email = emailTextField.text,
        let name = nameTextField.text,
            let password = passwordTextField.text
        else {return }
        
        vm.register(
            model: RegisterRequestModel(
                email: email,
                name: name,
                password: password
            )
        )
    }

    @IBAction func nameChanged(_ sender: Any) {
        if let name = nameTextField.text {
            if let errorMessage = invalidName(name)
            {
                isNameError = true
                nameError.text = errorMessage
                nameError.isHidden = false
            }
            else {
                isNameError = false
                nameError.isHidden = true
            }
        }
        checkValidForm()
    }

    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTextField.text {
            if let errorMessage = invalidEmail(email)
            {
                isEmailError = true
                emailError.text = errorMessage
                emailError.isHidden = false
            }
            else {
                isEmailError = false
                emailError.isHidden = true
            }
        }
        if emailTextField.text == "" {
            return emailError.isHidden = true
        }
        checkValidForm()
    }

    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTextField.text {
            if let errorMessage = invalidPassword(password)
            {
                isPasswordError = true
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }
            else {
                isPasswordError = false
                passwordError.isHidden = true
            }
            if passwordTextField.text == "" {
                return passwordError.isHidden = true
            }
        }
        checkValidForm()
    }

    @IBAction func didTapGoggle(_ sender: UIButton) {}


    @IBAction func didTapNameClearBtn(_ sender: UIButton) {
        nameTextField.text = ""
        nameClearBtn.isHidden = true
    }

    @IBAction func didTapEmailClearBtn(_ sender: UIButton) {
        emailTextField.text = ""
        emailClearBtn.isHidden = true
        emailError.isHidden = true
    }
}

extension RegisterViewController {
    private func setupUI() {
        togglePassword()
        setupTextField()
        setupPrivacyField()
        setupLoginLabel()
    }

    private func bindViewModel() {
        vm.successRegister
            .subscribe { self.handleSuccessRegister($0) }
            .disposed(by: bag)
        
        vm.error
            .subscribe { self.handleError(msg: $0) }
            .disposed(by: bag)
        
        vm.isLoading
            .subscribe { show in
                guard let show = show.element else { return }
                self.showLoadingIndicator(show)
            }
            .disposed(by: bag)
    }
    
    private func handleSuccessRegister(_ response: RegisterResponseModel) {
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    private func togglePassword() {
        imageIcon.image = UIImage(named: "ic_eye.close")
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 21, height: 14)
        imageIcon.frame = CGRect(x: -6, y: -5, width: 24, height: 24)
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }


    func invalidName(_ value: String) -> String? {
        if value.count == 0 {
            return "Nama harus diisi"
        }
        return nil
    }

    func invalidEmail(_ value: String) -> String? {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Format email tidak sesuai"
        }
        return nil
    }

    func checkValidForm(){
        if (isNameError || isEmailError || isPasswordError) {
            registerBtn.isEnabled = false
        } else {
            registerBtn.isEnabled = true
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
extension RegisterViewController {
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
            action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func showKeyboard(notification: NSNotification) {
        guard
            let info = notification.userInfo,
            let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
                .cgRectValue
                .size
        else { return }
        
        let contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: kbSize.height,
            right: 0
        )
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func hideKeyboard(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        
        if iconClick {
            iconClick = false
            tappedImage?.image = UIImage(named: "ic_eye")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage?.image = UIImage(named: "ic_eye.close")
            passwordTextField.isSecureTextEntry = true
        }
    }

    @objc func didTapLogin(recognizer: UITapGestureRecognizer){
        if recognizer.didTapAttributedTextInLabel(label: loginLabel, inRange: NSRange(location: 21, length: 5)) {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc func validateText(sender: UITextField) {
        if sender == emailTextField {
            if let email = emailTextField.text {
                emailClearBtn.isHidden = !(email.count > 0)
            }
        }
        if sender == nameTextField {
            if let name = nameTextField.text {
                nameClearBtn.isHidden = !(name.count > 0)
            }
        }
    }

    func setupTextField(){
        [nameTextField, emailTextField, passwordTextField ].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(validateText), for: .editingChanged)
        }
    }

    func setupLoginLabel() {
        let attributeString = NSMutableAttributedString(string: "Sudah memiliki akun? Masuk")

        attributeString.addAttributes([.font: UIFont.systemFont(ofSize: 14.0)], range: NSRange(location: 0, length: attributeString.length))

        attributeString.addAttributes([
            .font: UIFont.systemFont(ofSize: 16.0,weight: .semibold),
            .foregroundColor: ColorCollection.primaryColor.value
        ], range: NSRange(location: 21, length: 5))

        loginLabel.attributedText = attributeString
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLogin)))
    }

    func setupPrivacyField(){
        let attributedString = NSMutableAttributedString(string: "Dengan masuk, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi Homepoint")

        attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 14.0)], range: NSRange(location: 0, length: attributedString.length))

        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 14.0,weight: .semibold),
            .foregroundColor: ColorCollection.primaryColor.value
        ], range: NSRange(location: 30, length: 18))

        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 14.0,weight: .semibold),
            .foregroundColor: ColorCollection.primaryColor.value
        ], range: NSRange(location: 55, length: 17))

        privacyLabel.attributedText = attributedString
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
             viewNameTextField.backgroundColor = .white
             viewNameTextField.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        case emailTextField:
            viewEmailTextField.backgroundColor = .white
            viewEmailTextField.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        default :
            viewPasswordTextField.backgroundColor = .white
            viewPasswordTextField.addBorder(width: 1, color: ColorCollection.primaryColor.value)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            viewEmailTextField.backgroundColor = ColorCollection.lightGreyColor.value
            viewEmailTextField.addBorder(width: 0, color: ColorCollection.lightGreyColor.value)
        case nameTextField:
            viewNameTextField.backgroundColor = ColorCollection.lightGreyColor.value
            viewNameTextField.addBorder(width: 0, color: ColorCollection.lightGreyColor.value)
        default :
            viewPasswordTextField.backgroundColor = ColorCollection.lightGreyColor.value
            viewPasswordTextField.addBorder(width: 0, color: ColorCollection.lightGreyColor.value)
        }
    }
}
