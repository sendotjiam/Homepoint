//
//  UIViewController+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 01/06/22.
//

import UIKit

extension UIViewController  {
    
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
