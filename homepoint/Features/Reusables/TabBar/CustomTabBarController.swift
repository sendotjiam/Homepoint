//
//  CustomeTabBarController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let ex2 = B()
        let ex3 = C()
        let orderVC = OrderListViewController()
        let ex4 = E()
        
        let navHome = UINavigationController(rootViewController: homeVC)
        let navEx2 = UINavigationController(rootViewController: ex2)
        let navEx3 = UINavigationController(rootViewController: ex3)
        let navOrder = UINavigationController(rootViewController: orderVC)
        let navEx4 = UINavigationController(rootViewController: ex4)
        
        let titles = [
            Constants.Home,
            Constants.Wishlist,
            Constants.Scan,
            Constants.Order,
            Constants.Profile,
        ]
        let images = [
            UIImage(named: Constants.HomeIcon),
            UIImage(named: Constants.WishlistIcon),
            UIImage(named: Constants.ScanIcon),
            UIImage(named: Constants.OrderIcon),
            UIImage(named: Constants.ProfileIcon)
        ]
        
        setupTabBar(
            [navHome, navEx2, navEx3, navOrder, navEx4],
            titles,
            images
        )
    }
}

extension CustomTabBarController {
    private func setupTabBar(
        _ navControllers : [UINavigationController],
        _ titles: [String],
        _ images: [UIImage?]
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
                tag: 1
            )
            idx += 1
        }
        setViewControllers(
            navControllers,
            animated: false
        )
        self.selectedIndex = 0
    }
}

class B : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class C : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class E : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
