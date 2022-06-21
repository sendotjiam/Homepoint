//
//  SearchViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/06/22.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Initialize
    private let query : String
    
    init(_ query : String) {
        self.query = query
        super.init(nibName: Constants.SearchVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backSearchAndCart())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.layoutIfNeeded()
        viewDidLayoutSubviews()
    }
}

extension SearchViewController {
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            LargeProductCardViewCell.nib(),
            forCellWithReuseIdentifier: LargeProductCardViewCell.identifier
        )
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("test")
    }
}

// MARK: - CollectionView
extension SearchViewController :
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LargeProductCardViewCell.identifier,
            for: indexPath
        ) as? LargeProductCardViewCell
        return cell ?? UICollectionViewCell()
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.size.width - 50) / 2
        let height = 256 / 160 * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
//        let vc = DetailViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
}
