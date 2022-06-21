//
//  Double+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 21/06/22.
//

import Foundation

extension Double {
    func convertToCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}
