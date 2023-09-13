//
//  DetailMovieView.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import UIKit

protocol DetailMovieViewDelegate: AnyObject {
    //    Properties
    
    //    Methods
    func updateView(model: [DetailSections], title: String)
    func showError(message: String)
}

class DetailMovieView: UIViewController {
    // MARK: - Properties
    private let presenter : DetailMoviePresentable
    private var detail: [DetailSections] = []
    
    private lazy var aCollectionView: UICollectionView = {
        let aCollection = UICollectionView(frame: .zero,
                                           collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            DetailMovieView.createSectionLayout(with: section)
        }))
        aCollection.backgroundColor = .systemBackground
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        aCollection.register(CoverCollectionViewCell.self, forCellWithReuseIdentifier: CoverCollectionViewCell.identifier)
        aCollection.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: TextCollectionViewCell.identifier)
        aCollection.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        aCollection.register(HeaderTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTitleCollectionReusableView.identifier)
        return aCollection
    }()
    
    // MARK: - Init
    init(presenter: DetailMoviePresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchDetails()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aCollectionView.frame = view.bounds
    }
    
    // MARK: - SetUpView
    
    private func setUpView() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        view.addSubview(aCollectionView)
    }
    
    // MARK: - Methods
    
    
}

// MARK: - DetailMovieViewDelegate
extension DetailMovieView: DetailMovieViewDelegate {
    func updateView(model: [DetailSections], title: String) {
        DispatchQueue.main.async {
            self.detail = model
            self.title = title
            
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

extension DetailMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = detail[section]
        switch section{
        case .artWork:
            return 1
        case .description:
            return 1
        case .genre:
            return 1
        case .language:
            return 1
        case .popularity:
            return 1
        case .prodCompanies(let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = detail[indexPath.section]
        switch section {
        case .artWork(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCollectionViewCell.identifier, for: indexPath) as? CoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(artWork: model )
            return cell
        case .description(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCollectionViewCell.identifier,
                for: indexPath) as? TextCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(overview: model)
            return cell
        case .genre(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCollectionViewCell.identifier,
                for: indexPath) as? TextCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(overview: model)
            return cell
        case .language(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCollectionViewCell.identifier,
                for: indexPath) as? TextCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(overview: model)
            return cell
        case .popularity(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCollectionViewCell.identifier,
                for: indexPath) as? TextCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(overview: model)
            return cell
        case .prodCompanies(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCollectionViewCell.identifier, for: indexPath) as? CoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(artWork: model[indexPath.row] )
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
        header.configure(with: detail[indexPath.section].title)
        return header
        
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
//            Cover
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 0,
                bottom: 0, trailing: 0
            )
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(450))
                ,subitem: item,
                count: 1
            )
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
//            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 1:
//            Description
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.98),
                    heightDimension: .absolute(190) )
                ,subitem: item,
                count: 1
            )
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 2:
            //            Genre
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
                    heightDimension: .absolute(40) )
                ,subitem: item,
                count: 1
            )
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
        case 3:
//            Lenguage
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
                    heightDimension: .absolute(40) )
                ,subitem: item,
                count: 1
            )
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
        case 4:
//            Popularity
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
                    heightDimension: .absolute(40) )
                ,subitem: item,
                count: 1
            )
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
            let section = NSCollectionLayoutSection(group: groupHorizontal)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
        case 5:
//            Production Companies
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
            
            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(150) )
                ,subitem: item,
                count: 3
            )
            groupHorizontal.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
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
