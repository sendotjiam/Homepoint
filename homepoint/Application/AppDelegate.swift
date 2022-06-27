//
//  AppDelegate.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = UINavigationController(rootViewController: CustomTabBarController())
//        vc.setNavigationBarHidden(true, animated: false)
        let vc = UINavigationController(rootViewController: SearchViewController(""))
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

