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
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance
            
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        
        self.delegate = self
        
        let ex1 = ExViewController1()
        let ex2 = ExViewController2()
        let vc = ViewController()
        let ex3 = ExViewController2()
        let ex4 = ExViewController2()
        
        let navEx1 = UINavigationController(rootViewController: ex1)
        let navEx2 = UINavigationController(rootViewController: ex2)
        let navVC = UINavigationController(rootViewController: vc)
        let navEx3 = UINavigationController(rootViewController: ex3)
        let navEx4 = UINavigationController(rootViewController: ex4)
        
        var idx = 0
        let titles = [
            "Beranda",
            "Beranda",
            nil,
            "Profil",
            "Beranda",
        ]
        
        let images = [
            UIImage(named: "ic_profile"),
            UIImage(named: "ic_profile"),
            nil,
            UIImage(named: "ic_profile"),
            UIImage(named: "ic_profile")
        ]
        [navEx1, navEx3, navVC, navEx4, navEx2].forEach { nav in
            if idx == 2 {
                nav.tabBarItem = UITabBarItem(
                    title: nil,
                    image: nil,
                    selectedImage: nil
                )
                nav.tabBarItem.isEnabled = false
            } else {
                nav.tabBarItem = UITabBarItem(
                    title: titles[idx],
                    image: images[idx],
                    selectedImage: images[idx]
                )
            }
            idx += 1
        }
        setViewControllers(
            [navEx1, navEx2, navVC, navEx3, navEx4],
            animated: false
        )
        
        self.hidesBottomBarWhenPushed = true
    
        let tabBar = self.tabBar as! CustomTabBar
//        tabBar.didTapButton = {
//            print("TESTET")
//        }
    }
    
//    func setupMiddleBtn() {
//        let btnSize : CGFloat = 70
//        let btn = UIButton(
//            frame: CGRect(
//                x: (self.view.bounds.width / 2) - (btnSize / 2),
//                y: -30,
//                width: btnSize,
//                height: btnSize
//            )
//        )
//        btn.layer.masksToBounds = true
//        btn.setBackgroundImage(UIImage(named: "ic_barcode"), for: .normal)
//        btn.addTarget(self, action: #selector(scanBtnTapped), for: .touchUpInside)
//        btn.layer.zPosition = 1
//        self.view.layoutIfNeeded()
//        self.tabBar.addSubview(btn)
//    }
//
//    @objc func scanBtnTapped(sender: UIButton) {
//        print("TesT")
//        self.present(ViewController(), animated: true)
//    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if self.isHidden {
//            return super.hitTest(point, with: event)
//        }
//
//        let from = point
//        let to = middleButton.center
//
//        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? middleButton : super.hitTest(point, with: event)
//    }
}

// MARK: - UITabBarController Delegate
extension CustomTabBarController: UITabBarControllerDelegate {

}
