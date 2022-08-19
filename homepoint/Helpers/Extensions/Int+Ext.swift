//
//  Int+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 16/06/22.
//

import Foundation

extension Int {
    func separateInt(with separator : String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = separator
        guard let value = formatter.string(from: NSNumber(value: self))
        else { return "" }
        return value
    }
}
