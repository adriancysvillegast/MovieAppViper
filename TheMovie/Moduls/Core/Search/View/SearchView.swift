//
//  SearchView.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func updateView(model: [GenreSection])
    func didFailure(message: String)
}

class SearchView: UIViewController {

    // MARK: - Properties
    private let presenter: SearchPresentable
    private var genres: [GenreSection] = []
    
    private lazy var aSearchBar: UISearchController = {
        let aSearchBar = UISearchController()
        //UISearchController(searchResultsController: SearchResultView())
        aSearchBar.searchBar.placeholder = "Movies and Tv Shows"
        aSearchBar.searchBar.searchBarStyle = .minimal
        aSearchBar.definesPresentationContext = true
        aSearchBar.searchResultsUpdater = self
        aSearchBar.searchBar.delegate = self
        return aSearchBar
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let aCollection = UICollectionView(frame: .zero,
                                           collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            SearchView.createSectionLayout(with: section)
        }))
        aCollection.backgroundColor = .systemBackground
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        aCollection.register(HeaderTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTitleCollectionReusableView.identifier)
        aCollection.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: GenresCollectionViewCell.identifier)
        return aCollection
    }()
    
    // MARK: - Init
    
    init(presenter: SearchPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getGenres()
        setUpView()
//        debo hacer el collectionview para mostarr los generos y debo hacer la peticion para obtener los generos para tv shows
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
    }
    
    // MARK: - SetUpView
    private func setUpView() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = aSearchBar
        view.addSubview(aCollectionView)
    }
    // MARK: - Methods
    
}

// MARK: - SearchViewDelegate
extension SearchView: SearchViewDelegate{
    func updateView(model: [GenreSection]) {
        DispatchQueue.main.async {
            self.genres = model
            self.aCollectionView.reloadData()
        }
    }
    
 
    func didFailure(message: String) {
        DispatchQueue.main.async {
            AlertHelper.showAlert(message: message, navigation: self)
        }
    }
}


extension SearchView: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text
        presenter.getQuery(searchText: query)
    }
    
    
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = genres[section]
        switch section {
        case .movie(let model):
            return model.count
        case .tv(let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = genres[indexPath.section]
        switch section {
        case .movie(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GenresCollectionViewCell.identifier,
                for: indexPath) as? GenresCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            
            cell.configuration(model: model[indexPath.row])
            return cell
        case .tv(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GenresCollectionViewCell.identifier,
                for: indexPath) as? GenresCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            
            cell.configuration(model: model[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderTitleCollectionReusableView.identifier,
            for: indexPath) as? HeaderTitleCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.configure(with: genres[indexPath.section].title)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sections = genres[indexPath.section]
        
        switch sections {
        case .movie(let model):
            presenter.didTap(idGenre: model[indexPath.row].id, nameGenre: model[indexPath.row].name, type: .movie)
        case .tv(let model):
            presenter.didTap(idGenre: model[indexPath.row].id, nameGenre: model[indexPath.row].name, type: .tv)
        }
    }
    
    static func createSectionLayout(with section: Int) -> NSCollectionLayoutSection {
        
        let supplementaryView = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        
        switch section{
        case 0:
//            Genre Movie
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2, leading: 2,
                bottom: 2, trailing: 2
            )
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                ,subitem: item,
                count: 2
            )
            
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
            
            let groupVertical = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.98),
                    heightDimension: .absolute(300))
                ,subitem: groupHorizontal,
                count: 3
            )
            
            let section = NSCollectionLayoutSection(group: groupVertical)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 1:
//            Genre TV
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2, leading: 2,
                bottom: 2, trailing: 2
            )
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                ,subitem: item,
                count: 2
            )
            
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
            
            let groupVertical = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.98),
                    heightDimension: .absolute(300))
                ,subitem: groupHorizontal,
                count: 3
            )
            
            let section = NSCollectionLayoutSection(group: groupVertical)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        default :
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
            
            let groupVertical = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(400))
                ,subitem: item,
                count: 2
            )
            
            groupVertical.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(400)),
                subitem: groupVertical,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
    }
    
}
