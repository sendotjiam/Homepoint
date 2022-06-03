//
//  UIViewController+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 01/06/22.
//

import UIKit

enum NavigationBarType {
    case defaultNav
    case hidden
    case backSearchAndCart
    case backAndTitle(title: String?)
    case backTitleAndLike(title: String?)
}

enum NavigationBarRightItemType {
    case cart
    case notification
    case like
}

protocol NavigationItemHandler {
    func cartTapped(sender: UIBarButtonItem)
    func notificationTapped(sender: UIBarButtonItem)
    func likeTapped(sender: UIBarButtonItem)
    func backTapped(sender: UIBarButtonItem)
}

extension UIViewController {
    private func setDefaultNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = nil

//        navigationController?.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.font:
//        ]
    }
    
    private func addStatusBar(_ color: UIColor) {
        if #available(iOS 13, *) {
            let statusBar = UIView()
            statusBar.frame = UIApplication.shared.statusBarFrame
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
    }
    
    private func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
            searchField.backgroundColor = .white
        }
        navigationItem.titleView = searchBar
    }
    
    private func addTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.textColor = .white
        navigationItem.titleView = label
    }
    
    private func addRightBarButtonItems(_ types: [NavigationBarRightItemType]) {
        var buttons = [UIButton]()
        types.forEach { type in
            var image : UIImage?
            var action : Selector?
            switch type {
            case .cart:
                image = UIImage(named: "ic_cart")
                action = #selector(cartTapped(sender:))
            case .notification:
                image = UIImage(named: "ic_notification")
                action = #selector(notificationTapped(sender:))
            case .like:
                image = UIImage(named: "ic_cart")
                action = #selector(cartTapped(sender:))
            }
            guard let action = action else {return}
            let btn = UIButton(type: .custom)
            btn.setImage(image, for: .normal)
            btn.addTarget(self, action: action, for: .touchUpInside)
            btn.widthAnchor.constraint(equalToConstant: 22).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 22).isActive = true
            buttons.append(btn)
        }
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.spacing = 26
        stack.distribution = .equalSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 0
        )
        let items = UIBarButtonItem(customView: stack)
        navigationItem.setRightBarButtonItems([items], animated: false)
    }
    
    private func addBackButton() {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_left.arrow"), for: .normal)
        btn.addTarget(self, action: #selector(backTapped(sender:)), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 22).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 18).isActive = true
        let item = UIBarButtonItem(customView: btn)
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    private func addLikeButton() {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_left.arrow"), for: .normal)
        btn.addTarget(self, action: #selector(likeTapped(sender:)), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 22).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 22).isActive = true
        let item = UIBarButtonItem(customView: btn)
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    func setNavigationBar(type: NavigationBarType) {
        setDefaultNavigationBar()
        switch type {
        case .hidden:
            navigationController?
                .setNavigationBarHidden(true, animated: false)
        case .backAndTitle(let title):
            addStatusBar(.blue)
            addBackButton()
            addTitle(title ?? "")
        case .backTitleAndLike(let title):
            addStatusBar(.blue)
            addBackButton()
            addLikeButton()
            addSearchBar()
            addTitle(title ?? "")
        case .backSearchAndCart:
            addStatusBar(.blue)
            addBackButton()
            addSearchBar()
            addRightBarButtonItems([.cart])
        default:
            addStatusBar(.blue)
            addSearchBar()
            addRightBarButtonItems([.cart, .notification])
        }
    }
}

extension UIViewController : NavigationItemHandler {
    @objc func cartTapped(sender: UIBarButtonItem) {
        print("CART")
    }
    @objc func notificationTapped(sender: UIBarButtonItem) {
        print("NOTIF")
    }
    @objc func likeTapped(sender: UIBarButtonItem) {
        print("LIKED")
    }
    @objc func backTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController : UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
