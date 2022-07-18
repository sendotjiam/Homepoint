//
//  UITableView+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 18/07/22.
//

import UIKit

extension UITableView {
    func reload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}
