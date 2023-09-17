//
//  SearchInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import Foundation

// MARK: - SearchInteractable
protocol SearchInteractable: AnyObject {
    var presenter: SearchPresentable? { get }
    
    func fetchGenresMovie()
    func fetchGenresTV()
}

// MARK: - SearchInteractor
class SearchInteractor: SearchInteractable {
    // MARK: - Properties
    
    weak var presenter: SearchPresentable?
    private let service: SearchService
    
    init(service: SearchService = SearchService() ) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func fetchGenresMovie() {
        service.getGenreMovies { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingGenresMovies(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
    
    func fetchGenresTV() {
        service.getGenreTV { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingGenresTV(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
    

}
