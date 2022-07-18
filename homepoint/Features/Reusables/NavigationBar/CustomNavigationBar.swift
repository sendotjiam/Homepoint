//
//  CustomSearchBar.swift
//  homepoint
//
//  Created by Sendo Tjiam on 04/06/22.
//

import UIKit

var isNavbarTransparent = false

enum NavigationBarType {
    case defaultNav
    case hidden
    case back
    case backAndSearch
    case backSearchAndCart(isTransparent: Bool = false)
    case backAndTitle(title: String?)
    case backTitleAndLike(title: String?, isFavorite: Bool = false)
    case titleAndHistory(title: String?)
    case title(title: String?)
}

enum NavigationBarRightItemType {
    case cart
    case notification
    case like
    case history
    case search
}

protocol NavigationItemHandler {
    func cartTapped(sender: UIBarButtonItem)
    func notificationTapped(sender: UIBarButtonItem)
    func likeTapped(sender: UIBarButtonItem)
    func backTapped(sender: UIBarButtonItem)
    func historyTapped(sender: UIBarButtonItem)
    func searchTapped(sender: UIBarButtonItem)
}

extension UIViewController  {
    private func setDefaultNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = ColorCollection.blueColor.value
        navigationController?.navigationBar.tintColor = ColorCollection.whiteColor.value
        navigationController?.navigationBar.barTintColor = ColorCollection.blueColor.value
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = nil
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    func setStatusBar(
        _ color: UIColor = ColorCollection.blueColor.value,
        _ isTransparent : Bool = false
    ) {
        if isTransparent { return }
        if #available(iOS 13, *) {
            let statusBar = UIView()
            statusBar.frame = UIApplication.shared.statusBarFrame
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
    }
    
    private func resetNavbarBackground() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = ColorCollection.blueDarkColor.value
        navigationController?.navigationBar.barTintColor = .clear
    }
    
    private func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        if let searchField = searchBar
            .value(forKey: "searchField") as? UITextField {
            searchField.backgroundColor = ColorCollection.whiteColor.value
            searchField.autocorrectionType = .no
        }
        searchBar.inputAccessoryView = toolbar()
        navigationItem.titleView = searchBar
    }
    
    private func addTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.font = UIFont.font(type: .semiBold, size: 16)
        label.textColor = ColorCollection.whiteColor.value
        navigationItem.titleView = label
    }
    
    private func addRightBarButtonItems(
        _ types: [NavigationBarRightItemType],
        _ isTransparent : Bool = false
    ) {
        var buttons = [UIButton]()
        types.forEach { type in
            var image : UIImage?
            var action : Selector?
            let extendedImageName = isTransparent ? ".transparent" : ""
            switch type {
            case .cart:
                image = UIImage(named: "ic_cart" + extendedImageName)
                action = #selector(cartTapped(sender:))
            case .notification:
                image = UIImage(named: "ic_notification" + extendedImageName)
                action = #selector(notificationTapped(sender:))
            case .like:
                image = UIImage(named: "ic_cart" + extendedImageName)
                action = #selector(cartTapped(sender:))
            case .history:
                image = UIImage(named: "ic_history" + extendedImageName)
                action = #selector(historyTapped(sender:))
            case .search:
                image = UIImage(named: "ic_search" + extendedImageName)
                action = #selector(searchTapped(sender:))
            }
            guard let action = action else {return}
            let btn = UIButton(type: .custom)
            btn.setImage(image, for: .normal)
            btn.addTarget(self, action: action, for: .touchUpInside)
            btn.widthAnchor.constraint(equalToConstant: isTransparent ? 32 : 22).isActive = true
            btn.heightAnchor.constraint(equalToConstant: isTransparent ? 32 : 22).isActive = true
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
        btn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 28).isActive = true
        let item = UIBarButtonItem(customView: btn)
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    private func addBackButton(_ isTransparent : Bool = false) {
        let btn = UIButton(type: .custom)
        let extendedImageName = isTransparent ? ".transparent" : ""
        let size : CGFloat = isTransparent ? 32 : 22
        btn.setImage(UIImage(named: "ic_left.arrow" + extendedImageName), for: .normal)
        btn.addTarget(self, action: #selector(backTapped(sender:)), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: size).isActive = true
        btn.heightAnchor.constraint(equalToConstant: size).isActive = true
        let item = UIBarButtonItem(customView: btn)
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    func setNavigationBar(type: NavigationBarType) {
        setDefaultNavigationBar()
        switch type {
        case .hidden:
            navigationController?
                .setNavigationBarHidden(true, animated: false)
        case let .title(title):
            addTitle(title ?? "")
        case let .backAndTitle(title):
            addBackButton()
            addTitle(title ?? "")
        case let .backTitleAndLike(title, isFavorite):
            addLikeButton(isFavorite)
            addBackButton()
            addSearchBar()
            addTitle(title ?? "")
        case let .backSearchAndCart(isTransparent):
            addBackButton(isTransparent)
            if isTransparent {
                resetNavbarBackground()
                addRightBarButtonItems([.search, .cart], isTransparent)
            } else {
                addSearchBar()
                addRightBarButtonItems([.cart])
            }
        case .backAndSearch:
            addBackButton()
            addSearchBar()
        case let .titleAndHistory(title):
            addTitle(title ?? "")
            addRightBarButtonItems([.history])
        case .back:
            addBackButton()
            resetNavbarBackground()
        default:
            addSearchBar()
            addRightBarButtonItems([.cart, .notification])
        }
    }
}


// MARK: - NavigationItem
extension UIViewController : NavigationItemHandler {
    @objc func cartTapped(sender: UIBarButtonItem) {
        if isUserLoggedIn() {
            let vc = CartViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showNotLoginAlert()
        }
    }
    @objc func notificationTapped(sender: UIBarButtonItem) {
        if (UserDefaults.standard.value(forKey: "user_token") != nil) {}
        else {
            showNotLoginAlert()
        }
    }
    @objc func likeTapped(sender: UIBarButtonItem) {
        let vc = WishlistViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func historyTapped(sender: UIBarButtonItem) {}
    @objc func searchTapped(sender: UIBarButtonItem) {}
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Login
extension UIViewController : NotLoginViewProtocol {
    func navigateToLogin() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - SearchBar
extension UIViewController : UISearchBarDelegate{
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        let searchVC = SearchViewController(query)
        searchVC.search()
        self.navigationController?
            .pushViewController(
                searchVC, animated: true
            )
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {}
    public func cancelSearch() {
        navigationItem.titleView?.resignFirstResponder()
        navigationItem.titleView?.endEditing(true)
    }
}
