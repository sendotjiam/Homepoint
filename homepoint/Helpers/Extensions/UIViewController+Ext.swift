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
    case backTitleAndLike(title: String?, isFavorite: Bool = false)
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
}


extension UIViewController  {
    
    private func setDefaultNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = ColorCollection.blueColor.value
        navigationController?.navigationBar.tintColor = ColorCollection.whiteColor.value
        navigationController?.navigationBar.barTintColor = ColorCollection.blueColor.value
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = nil
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
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
            searchField.backgroundColor = ColorCollection.whiteColor.value
        }
        navigationItem.titleView = searchBar
    }
    
    private func addTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.font = UIFont.font(type: .semiBold, size: 16)
        label.textColor = ColorCollection.whiteColor.value
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

    private func addLikeButton(_ isFavorite: Bool) {
        let btn = UIButton(type: .custom)
        btn.setImage(
            isFavorite
            ? UIImage(named: "ic_heart.fill")
            : UIImage(named: "ic_heart"),
            for: .normal
        )
        btn.addTarget(self, action: #selector(likeTapped(sender:)), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
            addTitle(title ?? "")
        case .backTitleAndLike(let title, let isFavorite):
            addStatusBar(ColorCollection.blueColor.value)
            addLikeButton(isFavorite)
            addSearchBar()
            addTitle(title ?? "")
        case .backSearchAndCart:
            addStatusBar(ColorCollection.blueColor.value)
            addSearchBar()
            addRightBarButtonItems([.cart])
        default:
            addStatusBar(ColorCollection.blueColor.value)
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
}

extension UIViewController : UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
