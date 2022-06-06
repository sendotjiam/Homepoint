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
        
        let ex1 = A()
        let ex2 = B()
        let vc = C()
        let ex3 = D()
        let ex4 = E()
        
        let navEx1 = UINavigationController(rootViewController: ex1)
        let navEx2 = UINavigationController(rootViewController: ex2)
        let navVC = UINavigationController(rootViewController: vc)
        let navEx3 = UINavigationController(rootViewController: ex3)
        let navEx4 = UINavigationController(rootViewController: ex4)
        
        let titles = [
            "Beranda",
            "Wishlist",
            "Scan",
            "Pesanan",
            "Profil",
        ]
        let images = [
            UIImage(named: "ic_home.selected"),
            UIImage(named: "ic_heart"),
            UIImage(named: "ic_scan"),
            UIImage(named: "ic_notes"),
            UIImage(named: "ic_profile")
        ]
        let selectedImages = [
            UIImage(named: "ic_home.selected"),
            UIImage(named: "ic_heart.selected"),
            UIImage(named: "ic_scan.selected"),
            UIImage(named: "ic_notes.selected"),
            UIImage(named: "ic_profile.selected")
        ]
        setupTabBar(
            [navEx1, navEx3, navVC, navEx4, navEx2],
            titles,
            images,
            selectedImages
        )
    }
}

extension CustomTabBarController {
    private func setupTabBar(
        _ navControllers : [UINavigationController],
        _ titles: [String],
        _ images: [UIImage?],
        _ selectedImages : [UIImage?]
    ) {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = ColorCollection.primaryColor.value
        tabBar.barTintColor = ColorCollection.primaryColor.value
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        var idx = 0
        navControllers.forEach { nav in
            nav.tabBarItem = UITabBarItem(
                title: titles[idx],
                image: images[idx],
                selectedImage: selectedImages[idx]
            )
            idx += 1
        }
        setViewControllers(
            navControllers,
            animated: false
        )
        self.selectedIndex = 0
        hidesBottomBarWhenPushed = true
    }
}

class A : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar(type: .defaultNav)
    }
}

class B : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class C : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class D : UIViewController {
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
