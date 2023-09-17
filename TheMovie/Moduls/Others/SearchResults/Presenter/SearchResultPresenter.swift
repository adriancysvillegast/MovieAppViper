//
//  SearchResultPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import Foundation

// MARK: - SearchSection
enum SearchSection {
    case movie(model: [SearchResultViewModelCell])
    case tv(model: [SearchResultViewModelCell])
    
    var title: String {
        switch self {
        
        case .movie:
            return "Movies"
        case .tv:
            return "TV Shows"
        
        }
    }
}

// MARK: - SearchResultPresentable
protocol SearchResultPresentable: AnyObject {
    var query: String { get }
    var view: SearchResultView? { get }
    
    func fetchQuery()
    func mappingSearchMovie(model: SearchResponseEntity)
    func mappingSearchTv(model: SearchResponseEntity)
    func didFailure(message: String)
}

// MARK: - SearchResultPresenter

class SearchResultPresenter: SearchResultPresentable {
    // MARK: - Properties
    weak var view: SearchResultView?
    var query: String
    
    let interactor: SearchResultInteractable
    var searchResult: [SearchSection] = []
    private var mapper: Mapper
    
    init(query: String, interactor: SearchResultInteractable, mapper: Mapper = Mapper() ) {
        self.query = query
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func fetchQuery() {
        interactor.fetchSearch(query: query)
    }
    
    func mappingSearchTv(model: SearchResponseEntity) {
        let modelCell = mapper.searchResult(model: model)
        searchResult.append(.tv(model: modelCell))
    }
    
    func mappingSearchMovie(model: SearchResponseEntity) {
        let modelCell = mapper.searchResult(model: model)
        searchResult.append(.movie(model: modelCell))
        view?.updateView(model: searchResult)
    }
    
    func didFailure(message: String) {
        view?.didFailure(message: message)
    }
}
