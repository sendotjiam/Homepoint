//
//  UIViewController+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 01/06/22.
//

import UIKit
import NVActivityIndicatorView

var globalLoadingIndicator : UIView?

extension UIViewController  {
    
    func getUserId() -> String? {
        return UserDefaults.standard.value(forKey: "user_id") as? String
    }
    
    func isUserLoggedIn() -> Bool {
        ((UserDefaults.standard.value(forKey: "user_token") != nil) || (UserDefaults.standard.value(forKey: "user_id") != nil))
    }
    
    func showNotLoginAlert() {
        let vc = NotLoginAlertViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    func addNotificationCenter(label: String, selector: Selector) {
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: Notification.Name(label),
            object: nil
        )
    }
    
    func postNotificationCenter(label: String) {
        NotificationCenter.default.post(
            name: Notification.Name(label),
            object: nil
        )
    }
    
    func removeNotificationCenter() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Alert with actions
    func createConfirmationAlert(
        _ title : String,
        _ message: String,
        _ yesHandler : ((UIAlertAction) -> Void)?
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let noAction = UIAlertAction(
            title: "No",
            style: .cancel,
            handler: nil
        )
        let yesAction = UIAlertAction(
            title: "Yes",
            style: .default,
            handler: yesHandler
        )
        alert.addAction(noAction)
        alert.addAction(yesAction)
        return alert
    }
    
    
    /// Alert with only one action
    func createSimpleAlert(
        _ title : String,
        _ message: String,
        _ actionTitle : String,
        _ callback : ((UIAlertAction) -> Void)? = nil
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        if let callback = callback {
            let action = UIAlertAction(
                title: actionTitle,
                style: .cancel,
                handler: callback
            )
            alert.addAction(action)
        } else {
            let action = UIAlertAction(
                title: actionTitle,
                style: .cancel,
                handler: nil
            )
            alert.addAction(action)
        }
        return alert
    }
    
    func handleError(msg: String?) {
        let alert = createSimpleAlert("Gagal", msg ?? "Gagal", "Coba lagi")
        present(alert, animated: true)
    }
    
    func showLoadingIndicator(_ show: Bool) {
        if show {
            let spinnerView = UIView.init(frame: view.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
            let loaderView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            loaderView.roundedCorner(with: 4)
            loaderView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
            let loader = UIActivityIndicatorView.init(style: .whiteLarge)
            loader.center = loaderView.center
            loaderView.addSubview(loader)
            loader.startAnimating()
            loaderView.center = spinnerView.center
            DispatchQueue.main.async { [weak self] in
                spinnerView.addSubview(loaderView)
                self?.view.addSubview(spinnerView)
            }
            globalLoadingIndicator = spinnerView
            view.isUserInteractionEnabled = false
        } else {
            view.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                globalLoadingIndicator?.removeFromSuperview()
                globalLoadingIndicator = nil
            }
        }
    }
    
    func showLoader(_ loaderView: UIView, _ loader: NVActivityIndicatorView, _ show : Bool) {
        if show {
            loader.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(loaderView)
            loaderView.addSubview(loader)
            NSLayoutConstraint.activate([
                loaderView.widthAnchor.constraint(equalToConstant: 60),
                loaderView.heightAnchor.constraint(equalToConstant: 60),
                loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                loader.widthAnchor.constraint(equalToConstant: 30),
                loader.heightAnchor.constraint(equalToConstant: 30),
                loader.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
                loader.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor)
            ])
            loader.startAnimating()
            loaderView.isHidden = false
            navigationController?.navigationBar.isUserInteractionEnabled = false
            view.isUserInteractionEnabled = false
        } else {
            loader.stopAnimating()
            loaderView.isHidden = true
            navigationController?.navigationBar.isUserInteractionEnabled = true
            view.isUserInteractionEnabled = true
        }
    }
    
    private func generateToolbarButton(
        _ title: String,
        _ style : UIBarButtonItem.Style,
        _ action: Selector,
        _ tintColor : UIColor
    ) -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: title,
            style: style,
            target: self,
            action: action
        )
        button.tintColor = tintColor
        return button
    }
    func toolbar() -> UIToolbar {
        let toolBar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 36)
        )
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = ColorCollection.blueColor.value
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = generateToolbarButton(
            "Done",
            .done,
            #selector(doneButtonTapped),
            ColorCollection.whiteColor.value
        )
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }
    @objc func doneButtonTapped(){
        /// declared on CustomSearchBar
        cancelSearch()
    }
}
