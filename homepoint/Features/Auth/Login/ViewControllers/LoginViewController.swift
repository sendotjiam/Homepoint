//
//  LoginViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 07/06/22.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    var iconClick = false
    let imageIcon = UIImageView()
    
    // MARK: - Variables
    private let vm : LoginViewModel = LoginViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHideKeyboardGesture()
        setupKeyboardObserver()
        
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .hidden)
    }
    
    // MARK: - Actions
    @IBAction func didTapLogin(_ sender: UIButton) {
#warning("Ganti pake data yang user input")
#warning("Validasi dlu datanya")
        vm.login(
            model: LoginRequestModel(
                email: "sendo@mail.com",
                password: "12345"
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
    
    @IBAction func didTapGoogle (_ sender: UIButton) {}
}

extension LoginViewController {
    private func setupUI() {
        togglePassword()
    }
    
    private func bindViewModel() {
        vm.successLogin
            .subscribe { self.handleSuccessLogin($0) }
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
    
    private func handleSuccessLogin(_ response: LoginResponseModel) {
        // Navigation move to home page
        print(response)
    }
    
    private func togglePassword() {
        imageIcon.image = UIImage(named: "ic_eye.close")
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 21, height: 14)
        imageIcon.frame = CGRect(x: -5, y: -5, width: 24, height: 24)
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:))
        )
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
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
}
