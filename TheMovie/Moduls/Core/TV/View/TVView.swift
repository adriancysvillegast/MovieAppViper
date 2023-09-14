//
//  TVView.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import UIKit
// MARK: - TVViewDelegate
protocol TVViewDelegate: AnyObject {
    func showTvShows(model: [TVShowType])
    func showError(message: String)
}

// MARK: - TVView
class TVView: UIViewController {

    // MARK: - Properties
    private let presenter: TVPresentable
    private var tvShows: [TVShowType] = []
    
    private lazy var aCollectionView: UICollectionView = {
        let aCollection = UICollectionView(frame: .zero,
                                           collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sections, _ in
            return TVView.createSectionLayout(with: sections)
        }))
        aCollection.backgroundColor = .systemBackground
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        aCollection.register(HeaderTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderTitleCollectionReusableView.identifier)
        aCollection.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        return aCollection
    }()
    
    // MARK: - Init
    
    init(presenter: TVPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchTvShows()
        setUpView()
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

    // MARK: - Methods
    

}
// MARK: - TVViewDelegate
extension TVView: TVViewDelegate {
    func showTvShows(model: [TVShowType]) {
        DispatchQueue.main.async {
            self.tvShows = model
            self.aCollectionView.reloadData()
        }
    }
    
    func showError(message: String) {
        AlertHelper.showAlert(message: message, navigation: self)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TVView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = tvShows[section]
        switch section {
        case .airToday(let model):
            return model.count
        case .onAir(let model):
            return model.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = tvShows[indexPath.section]
        switch section {
        case .airToday(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BasicCollectionViewCell.identifier,
                for: indexPath) as? BasicCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: model[indexPath.row])
            return cell
        case .onAir(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BasicCollectionViewCell.identifier,
                for: indexPath) as? BasicCollectionViewCell else {
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
        header.configure(with: tvShows[indexPath.section].title)
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
//            AirToday
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
//            On Air
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

//        case 2:
//            //            Top Rate
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(1)
//                )
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(0.8),
//                    heightDimension: .absolute(520))
//                ,subitem: item,
//                count: 1
//            )
//
//            let section = NSCollectionLayoutSection(group: groupHorizontal)
//            section.orthogonalScrollingBehavior = .groupPaging
//            section.boundarySupplementaryItems = supplementaryView
//            return section
//        case 3:
////            Up Coming
//            let item = NSCollectionLayoutItem(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(1)
//                )
//            )
//            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
//
//            let groupHorizontal = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(0.98),
//                    heightDimension: .absolute(300))
//                ,subitem: item,
//                count: 2
//            )
//
//            let section = NSCollectionLayoutSection(group: groupHorizontal)
//            section.orthogonalScrollingBehavior = .groupPaging
//            section.boundarySupplementaryItems = supplementaryView
//            return section
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

