//
//  SearchPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import Foundation


enum TypeList {
    case tv
    case movie
}
// MARK: - GenreSection
enum GenreSection {
    case movie(model: [GenreViewModelCell])
    case tv(model: [GenreViewModelCell])
    
    var title: String {
        switch self {
        
        case .movie:
            return "Movie Genre"
        case .tv:
            return "TV Genre"
        
        }
    }
}

// MARK: - SearchPresentable
protocol SearchPresentable: AnyObject {
    var view: SearchViewDelegate? { get }
    var viewResults: SearchResultViewDelegate? { get }
    
    func getGenres()
    func mappingGenresMovies(model: ResultGenreResponseEntity)
    func mappingGenresTV(model: ResultGenreResponseEntity)
    func getQuery(searchText: String?)
    func didTap(idGenre: String, nameGenre: String, type: TypeList)
    func didFailure(message: String)
}

// MARK: - SearchPresenter
class SearchPresenter: SearchPresentable {
    
    // MARK: - Properties
    weak var view: SearchViewDelegate?
    weak var viewResults: SearchResultViewDelegate?
    
    private var interactor: SearchInteractable?
    private let router: SearchRouting
    var genres: [GenreSection] = []
    private var mapper: Mapper
    
    // MARK: - Init
    
    init(interactor: SearchInteractable, router: SearchRouting, mapper: Mapper = Mapper() ) {
        self.interactor = interactor
        self.router = router
        self.mapper = mapper
    }

    // MARK: - Genres
    func getGenres() {
        interactor?.fetchGenresMovie()
        interactor?.fetchGenresTV()
    }
    
    func mappingGenresMovies(model: ResultGenreResponseEntity) {
        let genreMovie = mapper.mappingGenre(model: model)
        genres.append(.movie(model: genreMovie))
        
    }
    
    func mappingGenresTV(model: ResultGenreResponseEntity) {
        let genreTV = mapper.mappingGenre(model: model)
        genres.append(.tv(model: genreTV))
        view?.updateView(model: genres)
    }
    
    // MARK: - Error
    func didFailure(message: String) {
        view?.didFailure(message: message)
    }
    
    // MARK: - Search
    
    func getQuery(searchText: String?) {
        guard let search = searchText, !search.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        router.showResults(query: search)
    }
    
    // MARK: - Genres
    
    func didTap(idGenre: String, nameGenre: String, type: TypeList) {
        router.fetchListByGenre(idGenre: idGenre, nameGenre: nameGenre, type: type)
    }
}
