//
//  DetailMoviePresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import Foundation

// MARK: - DetailSections
enum DetailSections {
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

// MARK: - DetailMoviePresentable
protocol DetailMoviePresentable: AnyObject {
//    Properties
    var view: DetailMovieViewDelegate? { get }
    var movieID: String { get }
    
//    Methods
    func fetchDetails()
    func didSuccessDetail(model: DetailMovieResponseEntity)
    func didFailureDetail(message: String)
    
}

// MARK: - DetailMoviePresenter
class DetailMoviePresenter: DetailMoviePresentable {
    
    // MARK: - Properties
    weak var view: DetailMovieViewDelegate?
    let interactor : DetailMovieInteractable
    var mapper: Mapper
    let movieID: String
    var detailMovie: [DetailSections] = []
    
    // MARK: - Init
    
    init(movieID: String, interactor: DetailMovieInteractable, mapper: Mapper = Mapper()) {
        self.movieID = movieID
        self.interactor = interactor
        self.mapper = mapper
    }
    
    // MARK: - Methods
    
    func fetchDetails() {
        interactor.fetchDetailMovie(with: movieID)
    }
    
    func didSuccessDetail(model: DetailMovieResponseEntity) {
        let modelCell = mapper.detailMovie(model: model)
        detailMovie.append(.artWork(model: modelCell.artWork))
        detailMovie.append(.description(model: modelCell.description))
        detailMovie.append(.genre(model: modelCell.genre))
        detailMovie.append(.language(model: modelCell.language))
        detailMovie.append(.popularity(model: modelCell.popularity))
        detailMovie.append(.prodCompanies(model: modelCell.prodCompanies))
        view?.updateView(model: detailMovie, title: model.title)
    }
    
    func didFailureDetail(message: String) {
        view?.showError(message: message)
    }
    
}
