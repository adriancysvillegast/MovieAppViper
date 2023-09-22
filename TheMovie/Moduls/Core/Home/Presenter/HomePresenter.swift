//
//  HomePresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 20/9/23.
//

import Foundation

enum BrowserType {
    case tv
    case movie
}

enum BrowserData {
    case upComingMovie(model: [UpComingViewModelCell])
    case topRateMovie(model: [TopRateViewModelCell])
    case topRateTV(model: [TvTopRateViewModelCell])
    case sugActionMovie(model: [ListByGenreViewModelCell])
    case sugDocumentaryMovie(model: [ListByGenreViewModelCell])
    case sugAnimationMovie(model: [ListByGenreViewModelCell])
    case sugComedyTV(model: [ListByGenreViewModelCell])
    case sugDramaTV(model: [ListByGenreViewModelCell])
    case sugMisteryTV(model: [ListByGenreViewModelCell])
    
    var title: String {
        switch self {
        case .upComingMovie:
            return "Coming Soon"
        case .topRateMovie:
            return "Top Rate Movies"
        case .topRateTV:
            return "Top Rate Tv Shows"
        case .sugActionMovie:
            return "We Know you love Action"
        case .sugDocumentaryMovie:
            return "Documentaries"
        case .sugAnimationMovie:
            return "Animation"
        case .sugComedyTV:
            return "Comedy TV Shows"
        case .sugDramaTV:
            return "Drama TV Shows"
        case .sugMisteryTV:
            return "Mistery TV Shows"
        }
    }
    
    var type: BrowserType {
        switch self {
        case .upComingMovie:
            return .movie
        case .topRateMovie:
            return .movie
        case .topRateTV:
            return .tv
        case .sugActionMovie:
            return .movie
        case .sugDocumentaryMovie:
            return .movie
        case .sugAnimationMovie:
            return .movie
        case .sugComedyTV:
            return .tv
        case .sugDramaTV:
            return .tv
        case .sugMisteryTV:
            return .tv
        }
    }
}

// MARK: - HomePresentable
protocol HomePresentable: AnyObject {
    var view: HomeView? { get }
    
    func fetchAll()
    func mappingUpComingMovie(model: UpComingResponseEntity)
    func mappingTopRateMovie(model: TopRateResponseEntity)
    func mappingTopRateTV(model: TVTopRateResponseEntity)
    func mappingSuggestionActionMovie(model: ListByGenrerResponseEntity)
    func mappingSuggestionDocumentaryMovie(model: ListByGenrerResponseEntity)
    func mappingSuggestionAnimationMovie(model: ListByGenrerResponseEntity)
    func mappingSuggestionComedyTV(model: ListByGenrerResponseEntity)
    func mappingSuggestionDramaTV(model: ListByGenrerResponseEntity)
    func mappingSuggestionMisteryTV(model: ListByGenrerResponseEntity)
    func didFailure(message: String)
    
    func didTap(id: String, type: BrowserType)
}

// MARK: - HomePresenter
class HomePresenter: HomePresentable  {
    weak var view: HomeView?
    
    private let interactor: HomeInteractable
    private let router: HomeRouting
    private let mapper: Mapper
    var browserAll: [BrowserData] = []
    
    init(interactor: HomeInteractable, router: HomeRouting, mapper: Mapper = Mapper()) {
        self.interactor = interactor
        self.router = router
        self.mapper = mapper
    }
    
    // MARK: - Methods
    
    func fetchAll() {
        interactor.fetchTopRateMovie()
        interactor.fetchSugActionMovie()
        interactor.fetchTopRateTV()
        interactor.fetchSugDocumentaryMovie()
        interactor.fetchSugAnimationMovie()
        interactor.fetchSugComedyTV()
        interactor.fetchSugDramaTV()
        interactor.fetchSugMisteryTV()
        interactor.fetchUpComingMovies()
    }
    
    func mappingTopRateMovie(model: TopRateResponseEntity) {
        let modelCell = mapper.topRateMovie(model: model)
        browserAll.append(.topRateMovie(model: modelCell))
    }
    
    func mappingTopRateTV(model: TVTopRateResponseEntity) {
        let modelCell = mapper.tvTopRate(model: model)
        browserAll.append(.topRateTV(model: modelCell))
    }
    
    func mappingSuggestionActionMovie(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        browserAll.append(.sugActionMovie(model: modelCell))
    }
    
    func mappingSuggestionDocumentaryMovie(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        browserAll.append(.sugDocumentaryMovie(model: modelCell))
    }
    
    func mappingUpComingMovie(model: UpComingResponseEntity) {
        let modelCell = mapper.upComingMovie(model: model)
        browserAll.append(.upComingMovie(model: modelCell))
        view?.updateView(model: browserAll)
    }
    
    func mappingSuggestionAnimationMovie(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        browserAll.append(.sugAnimationMovie(model: modelCell))
    }
    
    func mappingSuggestionComedyTV(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        browserAll.append(.sugComedyTV(model: modelCell))
        
    }
    
    func mappingSuggestionDramaTV(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        browserAll.append(.sugDramaTV(model: modelCell))
        
    }
    
    func mappingSuggestionMisteryTV(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        browserAll.append(.sugMisteryTV(model: modelCell))
        
    }
    
    func didTap(id: String, type: BrowserType) {
        if type == .tv {
            router.showDetailTv(id: id)
        }else {
            router.showDetailMovie(id: id)
        }
    }

    
    func didFailure(message: String) {
        view?.didFailure(message: message)
    }
    
}
