//
//  DetailTvPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

// MARK: - DetailTVSections
enum DetailTVSections {
    case artWork(model: URL?)
    case description(model: String)
    case genre(model: String)
    case language(model: String)
    case popularity(model: String)
    case prodCompanies(model: [URL?])
    
    var title: String {
        switch self {
        case .artWork:
            return "Cover"
        case .description:
            return "Overview"
        case .genre:
            return "Genre"
        case .language:
            return "Original Language"
        case .popularity:
            return "Popularity"
        case .prodCompanies:
            return "Production Companies"
        }
    }
}

// MARK: - DetailTvShowPresentable
protocol DetailTvPresentable: AnyObject {
    var view: DetailTvViewDelegate? { get }
    
    func fetchDetail()
    func mappingDetailTV(model: DetailTvResponseEntity)
    
    func didFailure(message: String)
    
}

// MARK: - DetailTvPresenter
class DetailTvPresenter: DetailTvPresentable {
    // MARK: - properties
    weak var view: DetailTvViewDelegate?
    let interactor: DetailTvInteractable
    private let mapper: Mapper
    let idTV: String
    var detailTv: [DetailTVSections] = []
    
    // MARK: - Init
    
    init(idTV: String, interactor: DetailTvInteractable, mapper: Mapper = Mapper()) {
        self.interactor = interactor
        self.idTV = idTV
        self.mapper = mapper
    }
    
    func fetchDetail() {
        interactor.getDetailTV(idTV: idTV)
    }
    
    func mappingDetailTV(model: DetailTvResponseEntity) {
        
        let modelCell = mapper.detailTV(model: model)
        detailTv.append(.artWork(model: modelCell.artWork))
        detailTv.append(.description(model: modelCell.description))
        detailTv.append(.genre(model: modelCell.genre))
        detailTv.append(.language(model: modelCell.language))
        detailTv.append(.popularity(model: modelCell.popularity))
        detailTv.append(.prodCompanies(model: modelCell.prodCompanies))
        
        view?.showDetail(model: detailTv, title: model.name)
    }
    
    func didFailure(message: String) {
        view?.didFailure(message: message)
    }
}
