//
//  ForgetPassViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 07/06/22.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

final class ForgetPassViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var viewEmailTextField: UIView!
    @IBOutlet weak var emailClearBtn: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var requestBtn: UIButton!

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

    // MARK: - Variables
    private let vm : ForgetViewModel = ForgetViewModel()
    private let bag = DisposeBag()
    private var isEmailError = true

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        addHideKeyboardGesture()
        setupKeyboardObserver()

        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .back)
    }

    @IBAction func didTapForget(_ sender: Any) {
        guard let email = emailTextField.text
        else { return }
        vm.forget(
            model: ForgetRequestModel(
                email: email
            )
        )
    }

    @IBAction func didTapEmailClearBtn(_ sender: UIButton) {
        emailTextField.text = ""
        emailClearBtn.isHidden = true
        emailError.isHidden = true
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
}

extension ForgetPassViewController {
    private func setupUI() {
        requestBtn.roundedCorner(with: 8)
        setupTextField()

        emailError.isHidden = true
        requestBtn.isEnabled = false
    }
    private func bindViewModel() {
        vm.successForget
            .subscribe { [weak self] in self?.handleSuccessForget($0) }
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

    private func handleSuccessForget(_ response: ForgetResponseModel) {
        navigationController?.pushViewController(LastForgetPassViewController(), animated: true)
        print(response)

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
        if (isEmailError) {
            requestBtn.isEnabled = false
        } else {
            requestBtn.isEnabled = true
        }
    }

}

// MARK: - Objc Func & Keyboard
extension ForgetPassViewController {
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
                .cgRectValue.size
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

    @objc func validateText(sender: UITextField) {
        if sender == emailTextField {
            if let email = emailTextField.text {
                emailClearBtn.isHidden = !(email.count > 0)
            }
        }
    }

    func setupTextField(){
        [emailTextField].forEach {
            $0?.delegate = self
            $0?.addTarget(self, action: #selector(validateText), for: .editingChanged)
        }
    }
}

extension ForgetPassViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewEmailTextField.backgroundColor = .white
        viewEmailTextField.addBorder(width: 1, color: ColorCollection.primaryColor.value)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        viewEmailTextField.backgroundColor = ColorCollection.lightGreyColor.value
        viewEmailTextField.addBorder(width: 0, color: ColorCollection.primaryColor.value)
    }
}
