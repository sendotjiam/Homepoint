//
//  UIViewController+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 01/06/22.
//

import UIKit

var globalLoadingIndicator : UIView?

extension UIViewController  {
    /// Alert with only one action
    func createSimpleAlert(
        _ title : String,
        _ message: String,
        _ actionTitle : String
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: actionTitle,
            style: .cancel,
            handler: nil
        )
        alert.addAction(action)
        return alert
    }
    
    func handleError(msg: String) {
        let alert = createSimpleAlert("Failed", msg, "Try Again")
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
            DispatchQueue.main.async { [weak self] in
                globalLoadingIndicator?.removeFromSuperview()
                globalLoadingIndicator = nil
            }
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
