//
//  SearchViewController.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/06/22.
//

import UIKit
import RxSwift
import SkeletonView

enum SearchType {
    case normal, bestOffer, recommendation
}

final class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var sortFilterView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    // MARK: - Initialize
    private var query : String
    
    init(_ query : String) {
        self.query = query
        searchParams["Product name"] = query
        super.init(nibName: Constants.SearchVC, bundle: nil)
        self.hidesBottomBarWhenPushed = true
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
    private var pageNumber = 0
    private var brands = [String]()
    private var colors = [String]()
    private var isEmpty = false
    private var hasRecommendations = false
    private var shouldDisplayEmpty = false
    var searchParams : [String : Any] = [
        "Page size": 16,
        "Page number": 0,
    ]
    var type : SearchType = .normal
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(type: .backSearchAndCart)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.layoutIfNeeded()
        viewDidLayoutSubviews()
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        let vc = SortFilterSheetViewController(type: .filter)
        vc.modalPresentationStyle = .pageSheet
        products.forEach { [weak self] in
            guard let self = self else { return }
            self.brands.append($0.brand)
            self.colors.append($0.color)
        }
        vc.brands = Array(Set(brands.map { $0 }))
        vc.colors = colors
        self.present(vc, animated: true)
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        let vc = SortFilterSheetViewController(type: .sort)
        vc.sortDelegate = self
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
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
        collectionView.register(
            EmptySearchHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EmptySearchHeaderReusableView.identifier
        )
        
        sortFilterView.roundedCorner(with: 18)
        sortFilterView.dropShadow(with: 0.1, radius: 10, offset: CGSize(width: 0, height: 4))
        filterButton.imageView?.contentMode = .scaleAspectFit
        sortButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func search() {
        vm.search(params: searchParams, type: type)
        self.view.showShimmer()
    }
    
    private func checkDataIsEmpty() {
        isEmpty = products.isEmpty
        sortFilterView.isHidden = isEmpty
        
        if isEmpty {
            vm.search(params: [:], type: .recommendation)
            view.showShimmer()
            shouldDisplayEmpty = true
            hasRecommendations = true
        } else {
            if hasRecommendations {
                hasRecommendations = false
            } else {
                shouldDisplayEmpty = false
            }
        }
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let nameQuery = searchBar.text else { return }
        searchParams = [
            "Page size": 16,
            "Page number": pageNumber,
            "Product name": nameQuery,
        ]
        type = .normal
        search()
    }
}

// MARK: - Binding
extension SearchViewController {
    private func bindViewModel() {
        vm.successAllProducts.subscribe { [weak self] in
            self?.handleSuccessAllProducts($0.element)
        }.disposed(by: bag)
        vm.successProductsData.subscribe { [weak self] in
            self?.handleSuccessProductsData($0)
        }.disposed(by: bag)
        vm.error.subscribe { [weak self] in
            self?.handleError(msg: $0)
        }.disposed(by: bag)
        vm.isLoading.subscribe { [weak self] in
            self?.handleIsLoading($0)
        }.disposed(by: bag)
    }
    
    private func handleSuccessProductsData(
        _ products : [ProductDataModel]?
    ) {
        guard let products = products else { return }
        self.products = products
        checkDataIsEmpty()
        collectionView.reload()
    }
    
    private func handleSuccessAllProducts(_ products : AllProductsDataModel?) {
        guard let products = products else { return }
        self.products = products.products
        checkDataIsEmpty()
        collectionView.reload()
    }
    
    private func handleIsLoading(_ isLoading : Bool?) {
        guard let isLoading = isLoading else { return }
        if !isLoading {
            self.view.stopShimmer()
        }
    }
}

// MARK: - Interaction
extension SearchViewController : SortProductDelegate {
    func sort(by sort: SortState?) {
        if sort == nil { return }
        searchParams["sort"] = sort?.rawValue
        search()
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EmptySearchHeaderReusableView.identifier,
            for: indexPath
        ) as! EmptySearchHeaderReusableView
        header.configureCell()
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return isEmpty || shouldDisplayEmpty ?
            CGSize(width: collectionView.frame.size.width, height: 70) : CGSize.zero
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
