//
//  MovieView.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import UIKit

// MARK: - BrowserViewDelegate
protocol MovieViewDelegate: AnyObject {
    //    Properties
    
    //    Methods
    func updateView(model: [MovieType])
    func showError(message: String)
}

class MovieView: UIViewController {

    // MARK: - Properties
    private let presenter: MoviePresentable
    private var dataBrowser: [MovieType] = []
    
    private lazy var aCollectionView: UICollectionView = {
        let aCollection = UICollectionView(frame: .zero,
                                           collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sections, _ in
            return MovieView.createSectionLayout(with: sections)
        }))
        aCollection.backgroundColor = .systemBackground
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.isHidden = true
        aCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        aCollection.register(HeaderTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTitleCollectionReusableView.identifier)
        aCollection.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        return aCollection
    }()
    
    // MARK: - Init
    
    init(presenter: MoviePresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Movies"
        setUpView()
        presenter.fetchAllMovieEndPoints()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
    }
    
    // MARK: - SetUpView
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(aCollectionView)
    }

}

// MARK: - MovieViewDelegate
extension MovieView: MovieViewDelegate {
    func updateView(model: [MovieType]) {
        DispatchQueue.main.async {
            self.dataBrowser = self.presenter.dataMovies
            self.aCollectionView.isHidden = false
            self.aCollectionView.reloadData()
        }
        
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            AlertHelper.showAlert(message: message, navigation: self)
        }
    }
    
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataBrowser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = dataBrowser[section]
        switch section {
        case .nowPlaying(let model):
            return model.count
        case .topRate(let model):
            return model.count
        case .upComing(let model):
            return model.count
        case .popularMovies(let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = dataBrowser[indexPath.section]
        switch section {
        case .upComing(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as? BasicCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: model[indexPath.row])
            return cell
        case .popularMovies(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as? BasicCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: model[indexPath.row])
            return cell
        case .nowPlaying(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as? BasicCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: model[indexPath.row])
            return cell
        case .topRate(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as? BasicCollectionViewCell else {
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
        header.configure(with: dataBrowser[indexPath.section].title)
        return header
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = dataBrowser[indexPath.section]
        switch section {
        case .upComing(let model):
            presenter.onTapMovie(movieID: model[indexPath.row].id)
        case .popularMovies(let model):
            presenter.onTapMovie(movieID: model[indexPath.row].id)
        case .nowPlaying(let model):
            presenter.onTapMovie(movieID: model[indexPath.row].id)
        case .topRate(let model):
            presenter.onTapMovie(movieID: model[indexPath.row].id)
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
//            Popular
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 5, leading: 2,
                bottom: 5, trailing: 2
            )
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.98),
                    heightDimension: .absolute(300))
                ,subitem: item,
                count: 2
            )
            
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 1:
//            Now Playing
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.98),
                    heightDimension: .absolute(300))
                ,subitem: item,
                count: 2
            )
            
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 2:
            //            Top Rate
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(520))
                ,subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
        case 3:
//            Up Coming
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.98),
                    heightDimension: .absolute(300))
                ,subitem: item,
                count: 2
            )
            
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
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
