//
//  SearchViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/06/22.
//

import UIKit
import RxSwift
import SkeletonView

final class SearchViewController: UIViewController {

    // MARK: - Initialize
    private var query : String
    
    init(_ query : String) {
        self.query = query
        vm.search(query: query)
        super.init(nibName: Constants.SearchVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.view.showShimmer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Variables
    private var vm = SearchViewModel()
    private var bag = DisposeBag()
    private var products = [ProductDataModel]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
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
    
    private func bindViewModel() {
        vm.successSearch.subscribe { [weak self] in
            self?.handleSuccessSearch($0.element)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError(msg: $0.element)
        }
        vm.isLoading.subscribe { [weak self] in
            self?.handleIsLoading($0.element)
        }.disposed(by: bag)
    }
    
    private func handleSuccessSearch(_ products : [ProductDataModel]?) {
        self.products = products ?? []
        print(products)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func handleIsLoading(_ isLoading : Bool?) {
        guard let isLoading = isLoading else { return }
        if !isLoading { self.view.stopShimmer() }
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        vm.search(query: query)
        self.view.showShimmer()
    }
}

// MARK: - Skeleton
extension SearchViewController : SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return LargeProductCardViewCell.identifier
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
        products.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LargeProductCardViewCell.identifier,
            for: indexPath
        ) as? LargeProductCardViewCell
        cell?.data = products[indexPath.row]
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
        let vc = DetailViewController(products[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
