//
//  ForgetPassViewController.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 07/06/22.
//

import UIKit

class ForgetPassViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        addHideKeyboardGesture()
        setupKeyboardObserver()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .back)
    }
    
    @IBAction func didTapReset(_ sender: Any) {
        navigationController?
            .pushViewController(
                LastForgetPassViewController(),
                animated: true
            )
    }
}

extension ForgetPassViewController {
    private func setupUI() {
        
    }
    
    private func bindViewModel() {
        
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
}
