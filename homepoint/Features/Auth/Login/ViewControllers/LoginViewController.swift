//
//  LoginViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 07/06/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

protocol LoginProtocol {
    func successLogin()
}

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var viewEmailTextField: UIView!
    @IBOutlet weak var viewPasswordTextField: UIView!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var loginBtn: UIButton!

    private lazy var loaderView : UIView = {
        let view = UIView()
        view.roundedCorner(with: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private let loader = NVActivityIndicatorView (
        frame: .zero,
        type: .circleStrokeSpin,
        color: ColorCollection.primaryColor.value,
        padding: 0
    )

    var iconClick = false
    let imageIcon = UIImageView()
    
    // MARK: - Variables
    private let vm : LoginViewModel = LoginViewModel()
    private let bag = DisposeBag()
    private var isEmailError = true
    private var isPasswordError = true

    var delegate : LoginProtocol?

    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHideKeyboardGesture()
        setupKeyboardObserver()
        
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .back)
    }
    
    // MARK: - Actions
    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        vm.login(
            model: LoginRequestModel(
                email: email,
                password: password
            )
        )
    }
    
    @IBAction func didTapForget(_ sender: UIButton) {
        navigationController?
            .pushViewController(
                ForgetPassViewController(),
                animated: true
        )
    }
    
    @IBAction func didTapGoogle (_ sender: UIButton) {

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
        }
        if passwordTextField.text == "" {
            return passwordError.isHidden = true
        }
        checkValidForm()
    }

    @IBAction func didTapClearBtn(_ sender: UIButton) {
        emailTextField.text = ""
        clearButton.isHidden = true
        emailError.isHidden = true
    }
}

extension LoginViewController {
    private func setupUI() {
        togglePassword()
        setupTextField()
        setupRegisterLabel()
        setupPrivacyLabel()

        emailError.isHidden = true
        passwordError.isHidden = true
        loginBtn.isEnabled = false
    }
    
    private func bindViewModel() {
        vm.successLogin
            .subscribe { [weak self] in self?.handleSuccessLogin($0) }
            .disposed(by: bag)
        
        vm.error
            .subscribe { [weak self] in self?.handleError(msg: $0) }
            .disposed(by: bag)
        
        vm.isLoading
            .subscribe { [weak self] in
                guard let self = self,
                      let show = $0.element
                else { return }
                self.showLoader(self.loaderView, self.loader, show)
            }
            .disposed(by: bag)
    }
    
    private func handleSuccessLogin(_ response: LoginResponseModel) {
        delegate?.successLogin()
        navigationController?.popViewController(animated: true)
        print(response)

        // masukin protocol
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
            action: #selector(imageTapped(tapGestureRecognizer:))
        )
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }

    func setupRegisterLabel() {
        let attributeString = NSMutableAttributedString(string: "Belum memiliki akun? Daftar")

        attributeString.addAttributes([.font: UIFont.systemFont(ofSize: 14.0)], range: NSRange(location: 0, length: attributeString.length))

        attributeString.addAttributes([
            .font: UIFont.systemFont(ofSize: 16.0,weight: .semibold),
            .foregroundColor: ColorCollection.primaryColor.value
        ], range: NSRange(location: 21, length: 6))

        registerLabel.attributedText = attributeString
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRegister)))
    }

    func setupPrivacyLabel(){
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

    func setupTextField(){
        [emailTextField, passwordTextField].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(validateText), for: .editingChanged)
        }
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
        if (isEmailError || isPasswordError) {
            loginBtn.isEnabled = false
        } else {
            loginBtn.isEnabled = true
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
extension LoginViewController {
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
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage?.image = UIImage(named: "ic_eye.close")
            passwordTextField.isSecureTextEntry = true
        }
    }

    @objc func didTapRegister(recognizer: UITapGestureRecognizer){
        if recognizer.didTapAttributedTextInLabel(label: registerLabel, inRange: NSRange(location: 21, length: 6)) {
            navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }

    @objc func validateText(sender: UITextField) {
        if sender == emailTextField {
            if let email = emailTextField.text {
                clearButton.isHidden = !(email.count > 0)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
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
        default :
            viewPasswordTextField.backgroundColor = ColorCollection.lightGreyColor.value
            viewPasswordTextField.addBorder(width: 0, color: ColorCollection.lightGreyColor.value)
        }
    }
}
