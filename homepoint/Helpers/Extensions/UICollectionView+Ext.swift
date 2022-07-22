//
//  UICollectionView+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 22/07/22.
//

import UIKit

extension UICollectionView {
    func reload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
