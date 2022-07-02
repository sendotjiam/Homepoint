//
//  Constants.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import Foundation

struct Constants {
    static let BaseUrl = "https://homepoint-server-staging.herokuapp.com/"
    
    // MARK: - Helpers
    static let UrlWhatsappApp = "whatsapp://send?phone=6282114742197&text=Halo%20Homepoint%F0%9F%99%8C%F0%9F%8F%BB%0AAda%20yang%20ingin%20Saya%20tanyakan%2C%20nih!%0A%0A(Tuliskan%20pertanyaanmu%20disini%20ya!)"
    static let UrlWhatsappWeb = "https://api.whatsapp.com/send?phone=6282114742197&text=Halo%20Homepoint%F0%9F%99%8C%F0%9F%8F%BB%0AAda%20yang%20ingin%20Saya%20tanyakan%2C%20nih!%0A%0A(Tuliskan%20pertanyaanmu%20disini%20ya!)"
    
    
    // MARK: - CustomTabBar
    static let Home = "Beranda"
    static let HomeIcon = "ic_home"
    static let Wishlist = "Wishlist"
    static let WishlistIcon = "ic_wishlist"
    static let Scan = "Scan"
    static let ScanIcon = "ic_scan"
    static let Order = "Pesanan"
    static let OrderIcon = "ic_notes"
    static let Profile = "Profil"
    static let ProfileIcon = "ic_profile"
    
    // MARK: - VC
    static let HomeVC = "HomeViewController"
    static let DetailVC = "DetailViewController"
    static let SearchVC = "SearchViewController"
    static let HistoryVC = "HistoryViewController"
    static let OrderListVC = "OrderListViewController"
}
