//
//  Checkbox.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class Checkbox : UIButton {
    
    // Images
    let checkedImage = UIImage(named: "ic_checkbox.selected")
    let uncheckedImage = UIImage(named: "ic_checkbox")
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
