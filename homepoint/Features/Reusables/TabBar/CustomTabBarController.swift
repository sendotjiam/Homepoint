//
//  CustomeTabBarController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let wishlistVC = WishlistViewController()
        let orderVC = OrderListViewController()
        let profileVC = ProfileViewController()
        
        let navHome = UINavigationController(rootViewController: homeVC)
        let navWishlist = UINavigationController(rootViewController: wishlistVC)
        let navOrder = UINavigationController(rootViewController: orderVC)
        let navProfile = UINavigationController(rootViewController: profileVC)
        
        let titles = [
            Constants.Home,
            Constants.Wishlist,
            Constants.Order,
            Constants.Profile,
        ]
        let images = [
            UIImage(named: Constants.HomeIcon),
            UIImage(named: Constants.WishlistIcon),
            UIImage(named: Constants.OrderIcon),
            UIImage(named: Constants.ProfileIcon)
        ]
        let selected = [
            UIImage(named: Constants.HomeIcon + ".fill"),
            UIImage(named: Constants.WishlistIcon + ".fill"),
            UIImage(named: Constants.OrderIcon + ".fill"),
            UIImage(named: Constants.ProfileIcon + ".fill")
        ]
        
        setupTabBar(
            [navHome, navWishlist, navOrder, navProfile],
            titles,
            images,
            selected
        )
    }
}

extension CustomTabBarController {
    private func setupTabBar(
        _ navControllers : [UINavigationController],
        _ titles: [String],
        _ images: [UIImage?],
        _ selected : [UIImage?]
    ) {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = ColorCollection.primaryColor.value
        tabBar.backgroundColor = .white
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        var idx = 0
        navControllers.forEach { nav in
            nav.tabBarItem = UITabBarItem(
                title: titles[idx],
                image: images[idx],
                selectedImage: selected[idx]
            )
            nav.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
            idx += 1
        }
        setViewControllers(
            navControllers,
            animated: false
        )
        self.selectedIndex = 0
    }
}
