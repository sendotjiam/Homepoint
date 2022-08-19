//
//  SortHelper.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/06/22.
//

import Foundation

enum SortState : String {
    case bestSeller = "Produk Terlaris"
    case latest = "Produk Terbaru"
    case cheapest = "Harga Termurah"
    case expensive = "Harga Termahal"
    case largestDiscount = "Diskon Terbesar"
}

enum FilterSection {
    case price, brand, color, rating
}

protocol SortProductDelegate {
    func sort(by sort: SortState?)
}
